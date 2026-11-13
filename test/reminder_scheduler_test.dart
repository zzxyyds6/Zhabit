import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zhabit/core/reminders/reminder_platform.dart';
import 'package:zhabit/data/db/database.dart';
import 'package:zhabit/data/repositories/habit_repository.dart';
import 'package:zhabit/data/repositories/reminder_settings_repository.dart';
import 'package:zhabit/providers.dart';

class _FakeReminderPlatform implements ReminderPlatform {
  final List<(DateTime, String)> scheduled = [];

  @override
  Future<bool> scheduleReminder({
    required int id,
    required DateTime at,
    required String title,
    required String body,
    String? payload,
  }) async {
    scheduled.add((at, payload ?? ''));
    return true;
  }

  @override
  Future<void> cancelReminder(int id) async {}

  @override
  Future<void> cancelAll() async {
    scheduled.clear();
  }

  @override
  Stream<String> get actionPayloads => const Stream.empty();

  @override
  Future<ReminderCapability> capability() async => ReminderCapability.full;
}

void main() {
  test('提醒调度:单次上限与同一条目冷却时间生效', () async {
    final db = AppDatabase(NativeDatabase.memory());
    final habitRepo = HabitRepository(db);
    final habitA = await habitRepo.addHabit('阅读');
    final habitB = await habitRepo.addHabit('运动');

    final settingsRepo = ReminderSettingsRepository(db);
    final settings = await settingsRepo.getSettings();
    await settingsRepo.save(
      ReminderGlobalRow(
        id: settings.id,
        enabled: true,
        mode: settings.mode,
        intervalMinutes: 15,
        randomMin: settings.randomMin,
        randomMax: settings.randomMax,
        activeFrom: '00:00',
        activeUntil: '23:59',
        maxPerPopup: 2,
        cooldownMinutes: 30,
      ),
    );

    final platform = _FakeReminderPlatform();
    final container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
        reminderPlatformProvider.overrideWithValue(platform),
      ],
    );
    addTearDown(container.dispose);
    addTearDown(db.close);

    await container.read(reminderSchedulerProvider).scheduleAll();

    expect(platform.scheduled, isNotEmpty);

    final byTime = <DateTime, List<String>>{};
    for (final item in platform.scheduled) {
      byTime.putIfAbsent(item.$1, () => []).add(item.$2);
    }
    expect(byTime.values.every((targets) => targets.length == 2), isTrue);

    for (final habitId in [habitA, habitB]) {
      final payload = 'habit:$habitId';
      final times =
          platform.scheduled
              .where((item) => item.$2 == payload)
              .map((item) => item.$1)
              .toList()
            ..sort();
      expect(times, isNotEmpty);
      for (var i = 1; i < times.length; i++) {
        expect(
          times[i].difference(times[i - 1]),
          greaterThanOrEqualTo(const Duration(minutes: 30)),
        );
      }
    }
  });
}
