import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/db/database.dart';
import 'data/repositories/habit_repository.dart';
import 'data/repositories/reminder_settings_repository.dart';
import 'data/repositories/short_task_repository.dart';

export 'core/reminders/reminder_platform.dart' show reminderPlatformProvider;

/// 数据库单例:平台差异封装在 createAppDatabase 内(ADR-0001)。
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = createAppDatabase();
  ref.onDispose(db.close);
  return db;
});

final habitRepositoryProvider = Provider<HabitRepository>(
  (ref) => HabitRepository(ref.watch(appDatabaseProvider)),
);

final shortTaskRepositoryProvider = Provider<ShortTaskRepository>(
  (ref) => ShortTaskRepository(ref.watch(appDatabaseProvider)),
);

final reminderSettingsRepositoryProvider = Provider<ReminderSettingsRepository>(
  (ref) => ReminderSettingsRepository(ref.watch(appDatabaseProvider)),
);