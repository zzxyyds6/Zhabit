import 'package:drift/drift.dart' show QueryExecutor;
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:integration_test/integration_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:zhabit/core/reminders/reminder_platform.dart';
import 'package:zhabit/data/db/database.dart';
import 'package:zhabit/main.dart';
import 'package:zhabit/providers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Web 冒烟:添加/打卡/短期完成', (tester) async {
    final dbName = 'zhabit-web-smoke-';
    final executor = driftDatabase(
      name: dbName,
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
      ),
    ) as QueryExecutor;
    final db = AppDatabase(executor);
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

    // 长期习惯闭环。
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

    // 短期记录闭环。
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

    await db.close();
  });
}
