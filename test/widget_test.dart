import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zhabit/data/db/database.dart';
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
}