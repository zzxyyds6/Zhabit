import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zhabit/core/habits/streak.dart';
import 'package:zhabit/data/db/database.dart';
import 'package:zhabit/data/db/tables.dart';
import 'package:zhabit/data/repositories/habit_repository.dart';

void main() {
  late AppDatabase db;
  late HabitRepository repo;
  // 固定"今天":2026-11-13(周五)
  final now = DateTime(2026, 11, 13, 12);

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = HabitRepository(db);
  });
  tearDown(() async => db.close());

  Future<HabitRow> makeHabit({
    required HabitFrequency frequency,
    int? frequencyValue,
    String? weekdays,
    DateTime? createdAt,
  }) async {
    final id = await repo.addHabit('t',
        frequency: frequency, frequencyValue: frequencyValue, weekdays: weekdays);
    // 默认把创建日放到足够早,让测试注入的历史打卡日期合法
    final anchor = createdAt ?? DateTime(2026, 10, 1);
    await (db.update(db.habits)..where((h) => h.id.equals(id)))
        .write(HabitsCompanion(createdAt: Value(anchor)));
    return (db.select(db.habits)..where((h) => h.id.equals(id))).getSingle();
  }

  String d(int month, int day) => '2026-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

  group('daily streak', () {
    test('连续两天 + 今天已打', () async {
      final h = await makeHabit(frequency: HabitFrequency.daily);
      final done = {d(11, 11), d(11, 12), d(11, 13)};
      expect(HabitStreakLogic.currentStreak(h, done, now: now), 3);
    });

    test('今天未打不算断签(宽限)', () async {
      final h = await makeHabit(frequency: HabitFrequency.daily);
      final done = {d(11, 11), d(11, 12)};
      expect(HabitStreakLogic.currentStreak(h, done, now: now), 2);
    });

    test('昨天漏了就断', () async {
      final h = await makeHabit(frequency: HabitFrequency.daily);
      final done = {d(11, 11), d(11, 13)};
      expect(HabitStreakLogic.currentStreak(h, done, now: now), 1);
    });
  });

  group('weeklyTimes streak', () {
    test('本周达标 = 1 周', () async {
      final h = await makeHabit(frequency: HabitFrequency.weeklyTimes, frequencyValue: 3);
      // 本周:11-09(周一)~11-15(周日)
      final done = {d(11, 9), d(11, 10), d(11, 13)};
      expect(HabitStreakLogic.currentStreak(h, done, now: now), 1);
    });

    test('上周达标 + 本周未达标 = 宽限,仍计 1 周', () async {
      final h = await makeHabit(frequency: HabitFrequency.weeklyTimes, frequencyValue: 3);
      final done = {d(11, 2), d(11, 3), d(11, 4)};
      expect(HabitStreakLogic.currentStreak(h, done, now: now), 1);
    });

    test('连续两周达标 = 2 周', () async {
      final h = await makeHabit(frequency: HabitFrequency.weeklyTimes, frequencyValue: 3);
      final done = {d(11, 2), d(11, 3), d(11, 4), d(11, 9), d(11, 10), d(11, 13)};
      expect(HabitStreakLogic.currentStreak(h, done, now: now), 2);
    });
  });

  group('weekdays streak', () {
    test('只数轮到日,跳过非轮到日', () async {
      final h = await makeHabit(
          frequency: HabitFrequency.weekdays, weekdays: '1,3,5');
      // 轮到:11-11(三)、11-13(五)
      final done = {d(11, 11), d(11, 13)};
      expect(HabitStreakLogic.currentStreak(h, done, now: now), 2);
    });

    test('今天轮到未打不中断(宽限)', () async {
      final h = await makeHabit(
          frequency: HabitFrequency.weekdays, weekdays: '1,3,5');
      final done = {d(11, 11)};
      expect(HabitStreakLogic.currentStreak(h, done, now: now), 1);
    });

    test('前一个轮到日漏了就断', () async {
      final h = await makeHabit(
          frequency: HabitFrequency.weekdays, weekdays: '1,3,5');
      final done = {d(11, 13)};
      expect(HabitStreakLogic.currentStreak(h, done, now: now), 1);
    });
  });

  group('everyNDays streak', () {
    test('每 2 天:13/15 连续', () async {
      final anchor = DateTime(2026, 11, 13);
      final h = await makeHabit(
          frequency: HabitFrequency.everyNDays,
          frequencyValue: 2,
          createdAt: anchor);
      final done = {d(11, 13), d(11, 15)};
      // 该用例的"今天"是 11-15
      expect(HabitStreakLogic.currentStreak(h, done, now: DateTime(2026, 11, 15, 12)), 2);
    });
  });

  group('lastDays(7 天圆点)', () {
    test('daily:完成/轮到未完成状态正确', () async {
      final h = await makeHabit(frequency: HabitFrequency.daily);
      final done = {d(11, 12)};
      final dots = HabitStreakLogic.lastDays(h, done, 7, now: now);
      expect(dots, hasLength(7));
      // 今天 11-13:轮到未完成 → false
      expect(dots.last, false);
      // 昨天:完成 → true
      expect(dots[5], true);
      // 其余:轮到未完成 → false(daily 每天都轮到)
      expect(dots[0], false);
    });
  });

  group('unit', () {
    test('weeklyTimes 用周,其余用天', () async {
      final w = await makeHabit(frequency: HabitFrequency.weeklyTimes, frequencyValue: 2);
      final dly = await makeHabit(frequency: HabitFrequency.daily);
      expect(HabitStreakLogic.unit(w), '周');
      expect(HabitStreakLogic.unit(dly), '天');
    });
  });
}