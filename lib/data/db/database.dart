import 'package:drift/drift.dart';

import 'connection.dart';
import 'tables.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Habits, CheckIns, ShortTasks, ReminderGlobal])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;
}

/// 平台无关的数据库构造入口。
/// Android 与 Web 的差异全部封装在 [openAppDatabaseConnection] 内(ADR-0001)。
AppDatabase createAppDatabase() => AppDatabase(openAppDatabaseConnection());