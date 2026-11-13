import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zhabit/data/db/database.dart';
import 'package:material_ui/material_ui.dart';
import 'package:zhabit/main.dart';
import 'package:zhabit/providers.dart';

/// 首页空态冒烟测试:两个区块标题可见。
void main() {
  testWidgets('首页渲染长期习惯与短期记录空态', (tester) async {
    final db = AppDatabase(NativeDatabase.memory());

    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
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
        overrides: [appDatabaseProvider.overrideWithValue(db)],
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
        overrides: [appDatabaseProvider.overrideWithValue(db)],
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
}