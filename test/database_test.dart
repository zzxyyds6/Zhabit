import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zhabit/data/db/database.dart';
import 'package:zhabit/data/db/tables.dart';
import 'package:zhabit/data/repositories/habit_repository.dart';
import 'package:zhabit/data/repositories/reminder_settings_repository.dart';
import 'package:zhabit/data/repositories/short_task_repository.dart';

/// 数据层单元测试(内存 SQLite,VM 运行,CI 无需模拟器)。
void main() {
  late AppDatabase db;
  late HabitRepository habits;
  late ShortTaskRepository tasks;
  late ReminderSettingsRepository settings;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    habits = HabitRepository(db);
    tasks = ShortTaskRepository(db);
    settings = ReminderSettingsRepository(db);
  });

  tearDown(() async => db.close());

  group('长期习惯与打卡', () {
    test('添加习惯后可见,归档后隐藏', () async {
      final id = await habits.addHabit('睡前阅读');
      expect(await habits.watchActiveHabits().first, hasLength(1));

      await habits.archiveHabit(id);
      expect(await habits.watchActiveHabits().first, isEmpty);
    });

    test('打卡/撤销形成闭环,同一天只有一条记录', () async {
      final id = await habits.addHabit('喝水');
      final today = HabitRepository.today();

      expect(await habits.toggleCheckIn(id, today), isTrue,
          reason: '首次打卡应返回 true');
      expect(await habits.toggleCheckIn(id, today), isFalse,
          reason: '再次点击应撤销');
      expect(await habits.toggleCheckIn(id, today), isTrue,
          reason: '撤销后可重新打卡');

      final rows = await db.select(db.checkIns).get();
      expect(rows, hasLength(1));
      expect(rows.single.status, CheckStatus.done);
    });

    test('同一习惯一天重复打卡不产生重复行(唯一索引兜底)', () async {
      final id = await habits.addHabit('阅读');
      final today = HabitRepository.today();
      await habits.toggleCheckIn(id, today);
      // 绕过仓储层直接插重复行:唯一索引必须拒绝,保证数据完整性
      await expectLater(
        db.into(db.checkIns).insert(
              CheckInsCompanion.insert(habitId: id, date: today),
            ),
        throwsA(anything),
      );
      final rows = await db.select(db.checkIns).get();
      expect(rows, hasLength(1));
    });

    test('watchRecentCheckIns 返回区间内记录', () async {
      final id = await habits.addHabit('阅读');
      await habits.toggleCheckIn(id, HabitRepository.today());
      final recent = await habits.watchRecentCheckIns(id, 7).first;
      expect(recent, hasLength(1));
    });
  });

  group('短期记录', () {
    test('完成 → 撤销 → 再完成的生命周期', () async {
      final id = await tasks.addTask('买笔记本', dueDate: DateTime.now());
      await tasks.completeTask(id);
      var row = await (db.select(db.shortTasks)..where((t) => t.id.equals(id))).getSingle();
      expect(row.done, isTrue);
      expect(row.completedAt, isNotNull);

      await tasks.undoComplete(id);
      row = await (db.select(db.shortTasks)..where((t) => t.id.equals(id))).getSingle();
      expect(row.done, isFalse);
      expect(row.completedAt, isNull);
    });

    test('超过 7 天保留期的完成项被清除,未到期的保留', () async {
      final now = DateTime(2026, 11, 13, 12);
      final stale = await tasks.addTask('旧任务');
      final fresh = await tasks.addTask('新任务');
      await tasks.completeTask(stale);
      await tasks.completeTask(fresh);
      // 手动把旧任务完成时间拨回 8 天前
      await (db.update(db.shortTasks)..where((t) => t.id.equals(stale))).write(
        ShortTasksCompanion(completedAt: Value(now.subtract(const Duration(days: 8)))),
      );

      final removed = await tasks.removeExpiredCompleted(now: now);
      expect(removed, 1);
      final names = (await db.select(db.shortTasks).get()).map((t) => t.name);
      expect(names, isNot(contains('旧任务')));
      expect(names, contains('新任务'));
    });
  });

  group('提醒全局设置', () {
    test('默认行自动创建,可保存修改', () async {
      final s = await settings.getSettings();
      expect(s.enabled, isFalse);
      expect(s.mode, ReminderMode.fixed);
      expect(s.intervalMinutes, 30);

      await settings.save(
        ReminderGlobalRow(
          id: 1,
          enabled: true,
          mode: ReminderMode.random,
          intervalMinutes: 45,
          randomMin: 10,
          randomMax: 90,
          activeFrom: '07:00',
          activeUntil: '23:00',
          maxPerPopup: 2,
          cooldownMinutes: 20,
        ),
      );
      final reloaded = await settings.getSettings();
      expect(reloaded.enabled, isTrue);
      expect(reloaded.mode, ReminderMode.random);
      expect(reloaded.intervalMinutes, 45);
    });
  });
}