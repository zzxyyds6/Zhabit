import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:zhabit/core/reminders/schedule_planner.dart';
import 'package:zhabit/data/db/database.dart';
import 'package:zhabit/data/db/tables.dart';

class _FixedRandom implements Random {
  const _FixedRandom();

  @override
  bool nextBool() => true;

  @override
  double nextDouble() => 0;

  @override
  int nextInt(int max) => 0;
}

ReminderGlobalRow _settings({
  ReminderMode mode = ReminderMode.fixed,
  int intervalMinutes = 30,
  int randomMin = 15,
  int randomMax = 45,
  String activeFrom = '08:00',
  String activeUntil = '22:00',
  bool enabled = true,
}) {
  return ReminderGlobalRow(
    id: 1,
    enabled: enabled,
    mode: mode,
    intervalMinutes: intervalMinutes,
    randomMin: randomMin,
    randomMax: randomMax,
    activeFrom: activeFrom,
    activeUntil: activeUntil,
    maxPerPopup: 1,
    cooldownMinutes: 30,
  );
}

void main() {
  test('fixed: 固定间隔按分钟生成未来 24 小时触发点', () {
    final times = ReminderSchedulePlanner.upcomingFireTimes(
      settings: _settings(intervalMinutes: 30),
      now: DateTime(2026, 11, 13, 9),
    );

    expect(times.first, DateTime(2026, 11, 13, 9, 30));
    expect(times.length, 29);
    expect(times.last, DateTime(2026, 11, 14, 9));
  });

  test('fixed: 生效时段外的触发点被过滤', () {
    final times = ReminderSchedulePlanner.upcomingFireTimes(
      settings: _settings(
        intervalMinutes: 60,
        activeFrom: '09:00',
        activeUntil: '11:00',
      ),
      now: DateTime(2026, 11, 13, 8),
    );

    expect(times, [
      DateTime(2026, 11, 13, 9),
      DateTime(2026, 11, 13, 10),
      DateTime(2026, 11, 13, 11),
    ]);
  });

  test('fixed: 生效时段跨 0 点可正常过滤', () {
    final times = ReminderSchedulePlanner.upcomingFireTimes(
      settings: _settings(
        intervalMinutes: 30,
        activeFrom: '23:00',
        activeUntil: '07:00',
      ),
      now: DateTime(2026, 11, 13, 22, 30),
    );

    expect(times.first, DateTime(2026, 11, 13, 23));
    expect(times.last, DateTime(2026, 11, 14, 7));
  });

  test('random: 注入随机源时按 [min, max] 闭区间取步长', () {
    final times = ReminderSchedulePlanner.upcomingFireTimes(
      settings: _settings(
        mode: ReminderMode.random,
        randomMin: 15,
        randomMax: 45,
      ),
      now: DateTime(2026, 11, 13, 9),
      rng: const _FixedRandom(),
    );

    expect(times.take(3), [
      DateTime(2026, 11, 13, 9, 15),
      DateTime(2026, 11, 13, 9, 30),
      DateTime(2026, 11, 13, 9, 45),
    ]);
  });

  test('disabled: 关闭提醒时返回空列表', () {
    final times = ReminderSchedulePlanner.upcomingFireTimes(
      settings: _settings(enabled: false),
      now: DateTime(2026, 11, 13, 9),
    );

    expect(times, isEmpty);
  });
}
