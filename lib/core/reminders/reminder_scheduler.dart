import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/habit_repository.dart';
import '../../providers.dart';
import 'schedule_planner.dart';
import 'reminder_platform.dart';

/// 调度服务:设置变更/启动时批量预排未来 24h 的提醒(ADR-0003)。
/// payload 约定:`habit:<id>` 或 `task:<id>`,通知"完成"按钮据此直接打卡。
class ReminderSchedulerService {
  ReminderSchedulerService(this._ref);

  final Ref _ref;
  StreamSubscription<String>? _actionSub;
  int _nextId = 1000;

  ReminderPlatform get _platform => _ref.read(reminderPlatformProvider);

  Future<void> scheduleAll() async {
    final settings = await _ref
        .read(reminderSettingsRepositoryProvider)
        .getSettings();
    if (!settings.enabled) return;

    await _platform.cancelAll();

    final fireTimes = ReminderSchedulePlanner.upcomingFireTimes(
      settings: settings,
      now: DateTime.now(),
    );
    final candidates = await _candidateTargets();
    if (candidates.isEmpty) return;

    final maxPerPopup = settings.maxPerPopup.clamp(1, 10);
    final cooldown = Duration(
      minutes: settings.cooldownMinutes.clamp(0, 24 * 60),
    );
    final lastScheduled = <String, DateTime>{};
    var nextId = _nextId;

    for (final at in fireTimes) {
      final picked = <(String, String)>[];
      for (final target in candidates) {
        final last = lastScheduled[target.$2];
        if (last != null && at.difference(last) < cooldown) continue;
        picked.add(target);
        if (picked.length >= maxPerPopup) break;
      }

      for (final target in picked) {
        final ok = await _platform.scheduleReminder(
          id: nextId++,
          at: at,
          title: target.$1,
          body: '到点啦,点"完成"直接打卡',
          payload: target.$2,
        );
        if (!ok) {
          _nextId = nextId;
          return;
        }
        lastScheduled[target.$2] = at;
      }
    }
    _nextId = nextId;
  }

  /// 当日候选目标:未完成的长期习惯(按当日频率过滤),其次未完成短期记录。
  Future<List<(String, String)>> _candidateTargets() async {
    final today = DateTime.now();
    final habits = await _ref
        .read(habitRepositoryProvider)
        .watchHabitsDueOn(today)
        .first;
    final result = <(String, String)>[];
    for (final habit in habits) {
      result.add((habit.name, 'habit:${habit.id}'));
    }

    final tasks = await _ref
        .read(shortTaskRepositoryProvider)
        .watchVisibleTasks()
        .first;
    for (final task in tasks.where((t) => !t.done)) {
      result.add((task.name, 'task:${task.id}'));
    }
    return result;
  }

  /// 订阅通知"完成"动作 → 直接写打卡,并重排剩余提醒(#7 验收)。
  void bindActionRouter() {
    _actionSub?.cancel();
    _actionSub = _platform.actionPayloads.listen((payload) async {
      await _handlePayload(payload);
      await scheduleAll();
    });
  }

  Future<void> _handlePayload(String payload) async {
    final parts = payload.split(':');
    if (parts.length != 2) return;
    final id = int.tryParse(parts[1]);
    if (id == null) return;

    switch (parts[0]) {
      case 'habit':
        await _ref
            .read(habitRepositoryProvider)
            .toggleCheckIn(id, HabitRepository.today());
      case 'task':
        await _ref.read(shortTaskRepositoryProvider).completeTask(id);
    }
  }

  void dispose() => _actionSub?.cancel();
}
