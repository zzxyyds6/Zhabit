import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zhabit/core/habits/frequency.dart';
import 'package:zhabit/data/db/database.dart';
import 'package:zhabit/data/db/tables.dart';
import 'package:zhabit/data/repositories/habit_repository.dart';

void main() {
  late AppDatabase db;
  late HabitRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = HabitRepository(db);
  });
  tearDown(() async => db.close());

  Future<HabitRow> makeHabit({
    required HabitFrequency frequency,
    int? value,
    String? weekdays,
    DateTime? createdAt,
  }) async {
    final id = await repo.addHabit('t',
        frequency: frequency, frequencyValue: value, weekdays: weekdays);
    if (createdAt != null) {
      await (db.update(db.habits)..where((h) => h.id.equals(id)))
          .write(HabitsCompanion(createdAt: Value(createdAt)));
    }
    return (db.select(db.habits)..where((h) => h.id.equals(id))).getSingle();
  }

  group('isDueOn', () {
    test('daily:每天轮到', () async {
      final h = await makeHabit(frequency: HabitFrequency.daily);
      expect(HabitFrequencyLogic.isDueOn(h, DateTime(2026, 11, 13)), isTrue);
      expect(HabitFrequencyLogic.isDueOn(h, DateTime(2026, 1, 1)), isTrue);
    });

    test('weeklyTimes:每天显示(周内自选完成)', () async {
      final h = await makeHabit(
          frequency: HabitFrequency.weeklyTimes, value: 3);
      expect(HabitFrequencyLogic.isDueOn(h, DateTime(2026, 11, 13)), isTrue);
    });

    test('weekdays:一三五', () async {
      final h = await makeHabit(
          frequency: HabitFrequency.weekdays, weekdays: '1,3,5');
      // 2026-11-09 是周一
      expect(HabitFrequencyLogic.isDueOn(h, DateTime(2026, 11, 9)), isTrue);
      expect(HabitFrequencyLogic.isDueOn(h, DateTime(2026, 11, 10)), isFalse);
      expect(HabitFrequencyLogic.isDueOn(h, DateTime(2026, 11, 13)), isTrue);
    });

    test('weekdays:非法 CSV 忽略', () {
      expect(HabitFrequencyLogic.parseWeekdays('1,x,9,3'), {1, 3});
      expect(HabitFrequencyLogic.parseWeekdays(null), isEmpty);
    });

    test('everyNDays:从创建日起每 N 天', () async {
      final anchor = DateTime(2026, 11, 13);
      final h = await makeHabit(
          frequency: HabitFrequency.everyNDays, value: 2, createdAt: anchor);
      expect(HabitFrequencyLogic.isDueOn(h, DateTime(2026, 11, 13), anchor: anchor), isTrue);
      expect(HabitFrequencyLogic.isDueOn(h, DateTime(2026, 11, 14), anchor: anchor), isFalse);
      expect(HabitFrequencyLogic.isDueOn(h, DateTime(2026, 11, 15), anchor: anchor), isTrue);
      // 跨月:11-13 每 2 天 → 12-01(18 天后)是轮到日
      expect(HabitFrequencyLogic.isDueOn(h, DateTime(2026, 12, 1), anchor: anchor), isTrue);
      // 创建日之前不显示
      expect(HabitFrequencyLogic.isDueOn(h, DateTime(2026, 11, 12), anchor: anchor), isFalse);
    });

    test('everyNDays:无 value 时视为不轮到(数据兜底)', () async {
      final h = await makeHabit(frequency: HabitFrequency.everyNDays);
      expect(HabitFrequencyLogic.isDueOn(h, DateTime(2026, 11, 13)), isFalse);
    });
  });

  group('label', () {
    test('四种频率文案', () async {
      final daily = await makeHabit(frequency: HabitFrequency.daily);
      expect(HabitFrequencyLogic.label(daily), '每天');

      final wt = await makeHabit(frequency: HabitFrequency.weeklyTimes, value: 3);
      expect(HabitFrequencyLogic.label(wt), '每周 3 次');

      final wd = await makeHabit(
          frequency: HabitFrequency.weekdays, weekdays: '1,3,5');
      expect(HabitFrequencyLogic.label(wd), '每周一、三、五');

      final en = await makeHabit(frequency: HabitFrequency.everyNDays, value: 2);
      expect(HabitFrequencyLogic.label(en), '每 2 天');
    });
  });

  group('watchHabitsDueOn', () {
    test('今日列表按频率过滤', () async {
      final today = DateTime.now();
      final anchor = DateTime(today.year, today.month, today.day);
      await repo.addHabit('每天习惯');
      await repo.addHabit('隔天习惯',
          frequency: HabitFrequency.everyNDays, frequencyValue: 2);
      // 把隔天习惯的创建日拨回昨天 → 今天不轮到
      final rows = await (db.select(db.habits)).get();
      final everyNDay = rows.firstWhere((r) => r.name == '隔天习惯');
      await (db.update(db.habits)..where((h) => h.id.equals(everyNDay.id)))
          .write(HabitsCompanion(
              createdAt: Value(anchor.subtract(const Duration(days: 1)))));

      final dueToday = await repo.watchHabitsDueOn(today).first;
      expect(dueToday.map((h) => h.name), contains('每天习惯'));
      expect(dueToday.map((h) => h.name), isNot(contains('隔天习惯')));

      final dueTomorrow = await repo.watchHabitsDueOn(anchor.add(const Duration(days: 1))).first;
      expect(dueTomorrow.map((h) => h.name), contains('隔天习惯'));
    });
  });
}