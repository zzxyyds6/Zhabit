import 'package:drift/native.dart';
import 'package:zhabit/core/reminders/reminder_platform.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zhabit/data/db/database.dart';
import 'package:zhabit/data/db/tables.dart';
import 'package:material_ui/material_ui.dart';
import 'package:drift/drift.dart' show Value;
import 'package:zhabit/data/repositories/habit_repository.dart';
import 'package:zhabit/data/repositories/reminder_settings_repository.dart';
import 'package:zhabit/main.dart';
import 'package:zhabit/providers.dart';

/// 首页空态冒烟测试:两个区块标题可见。
void main() {
  testWidgets('首页渲染长期习惯与短期记录空态', (tester) async {
    final db = AppDatabase(NativeDatabase.memory());

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          reminderPlatformProvider.overrideWithValue(
            const NoopReminderPlatform(),
          ),
        ],
        child: const ZhabitApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('长期习惯'), findsOneWidget);
    expect(find.text('短期记录'), findsOneWidget);
    expect(find.text('还没有长期习惯,点 + 创建'), findsOneWidget);
    expect(find.text('暂无短期记录,点 + 快速添加'), findsOneWidget);

    await db.close();
  });

  testWidgets('添加习惯 → 一键打卡 → 撤销(#2 闭环)', (tester) async {
    final db = AppDatabase(NativeDatabase.memory());

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          reminderPlatformProvider.overrideWithValue(
            const NoopReminderPlatform(),
          ),
        ],
        child: const ZhabitApp(),
      ),
    );
    await tester.pumpAndSettle();

    // 添加习惯:FAB → 选择器 → 长期习惯
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text('长期习惯').last);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '睡前阅读');
    await tester.tap(find.text('保存'));
    await tester.pumpAndSettle();
    expect(find.text('睡前阅读'), findsOneWidget);

    // 打卡 → 按钮进入已完成态
    await tester.tap(find.byTooltip('打卡'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('撤销今日打卡'), findsOneWidget);

    // 再点 → 撤销
    await tester.tap(find.byTooltip('撤销今日打卡'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('打卡'), findsOneWidget);

    await db.close();
  });

  testWidgets('短期记录:添加 → 完成 → 撤销(#6 闭环)', (tester) async {
    final db = AppDatabase(NativeDatabase.memory());

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          reminderPlatformProvider.overrideWithValue(
            const NoopReminderPlatform(),
          ),
        ],
        child: const ZhabitApp(),
      ),
    );
    await tester.pumpAndSettle();

    // FAB → 选择器 → 短期记录
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text('短期记录').last);
    await tester.pumpAndSettle();

    // 填写名称并保存
    await tester.enterText(find.byType(TextField), '买笔记本');
    await tester.tap(find.text('保存'));
    await tester.pumpAndSettle();
    expect(find.text('买笔记本'), findsOneWidget);

    // 完成 → 条目消失 + 提示条出现
    await tester.tap(find.byTooltip('完成'));
    await tester.pumpAndSettle();
    expect(find.text('买笔记本'), findsNothing);
    expect(find.byType(SnackBar), findsOneWidget);

    // 撤销 → 条目重新出现
    await tester.tap(find.text('撤销'));
    await tester.pumpAndSettle();
    expect(find.text('买笔记本'), findsOneWidget);

    await db.close();
  });

  testWidgets('月历补打卡(#5):点过去日期 → 记录写入 → 再点取消', (tester) async {
    final db = AppDatabase(NativeDatabase.memory());
    final repo = HabitRepository(db);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          reminderPlatformProvider.overrideWithValue(
            const NoopReminderPlatform(),
          ),
        ],
        child: const ZhabitApp(),
      ),
    );
    await tester.pumpAndSettle();

    // 直接入库:创建日设为 10 天前,使"昨天"是合法的补打卡日期
    await repo.addHabit('睡前阅读');
    final habit = await (db.select(db.habits)).getSingle();
    await (db.update(db.habits)..where((h) => h.id.equals(habit.id))).write(
      HabitsCompanion(
        createdAt: Value(DateTime.now().subtract(const Duration(days: 10))),
      ),
    );
    await tester.pumpAndSettle();

    // 打开详情页(此时页面持有的 habit 已是旧创建日)
    await tester.tap(find.text('睡前阅读'));
    await tester.pumpAndSettle();

    // 点昨天(11 月,在本月日历内)补打卡
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    final key = 'day-${HabitRepository.formatDate(yesterday)}';
    await tester.scrollUntilVisible(
      find.byKey(ValueKey(key)),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.byKey(ValueKey(key)));
    await tester.pumpAndSettle();

    final rows = await db.select(db.checkIns).get();
    expect(rows, hasLength(1));
    expect(rows.single.date, HabitRepository.formatDate(yesterday));

    // 再点取消
    await tester.tap(find.byKey(ValueKey(key)));
    await tester.pumpAndSettle();
    expect(await db.select(db.checkIns).get(), isEmpty);

    await db.close();
  });
  testWidgets('MVP 集成:习惯打卡 + 短期记录 + 随机提醒设置', (tester) async {
    final db = AppDatabase(NativeDatabase.memory());

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          reminderPlatformProvider.overrideWithValue(
            const NoopReminderPlatform(),
          ),
        ],
        child: const ZhabitApp(),
      ),
    );
    await tester.pumpAndSettle();

    // 长期习惯:M1 示例"睡前阅读",并完成今日打卡。
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text('长期习惯').last);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '睡前阅读');
    await tester.tap(find.text('保存'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('打卡'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('撤销今日打卡'), findsOneWidget);

    // 短期记录:完成即消失。
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text('短期记录').last);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '买笔记本');
    await tester.tap(find.text('保存'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('完成'));
    await tester.pumpAndSettle();
    expect(find.text('买笔记本'), findsNothing);

    // 设置页:开启随机间隔,并调整单次提醒上限。
    await tester.tap(find.byTooltip('设置'));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(SwitchListTile));
    await tester.pumpAndSettle();
    await tester.tap(find.text('随机'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('2'));
    await tester.pumpAndSettle();
    final settingsRepo = ReminderSettingsRepository(db);
    final current = await settingsRepo.getSettings();
    await settingsRepo.save(
      ReminderGlobalRow(
        id: current.id,
        enabled: true,
        mode: ReminderMode.random,
        intervalMinutes: current.intervalMinutes,
        randomMin: 15,
        randomMax: 60,
        activeFrom: current.activeFrom,
        activeUntil: current.activeUntil,
        maxPerPopup: 2,
        cooldownMinutes: 30,
      ),
    );

    final row = await (db.select(db.reminderGlobal)).getSingle();
    expect(row.enabled, isTrue);
    expect(row.mode, ReminderMode.random);
    expect(row.maxPerPopup, 2);
    expect(row.cooldownMinutes, 30);

    await db.close();
  });
}
