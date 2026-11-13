import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/reminders/reminder_platform.dart';
import 'core/reminders/reminder_platform_factory.dart';
import 'core/reminders/reminder_scheduler.dart';
import 'data/db/database.dart';
import 'data/repositories/habit_repository.dart';
import 'data/repositories/reminder_settings_repository.dart';
import 'data/repositories/short_task_repository.dart';

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

/// 平台提醒实现(Web 为 Noop 占位,原生平台为系统通知)。
final reminderPlatformProvider = Provider<ReminderPlatform>(
  (ref) => createReminderPlatform(),
);

/// 调度服务:绑定通知"完成"动作路由,读方负责 dispose。
final reminderSchedulerProvider = Provider<ReminderSchedulerService>((ref) {
  final service = ReminderSchedulerService(ref);
  service.bindActionRouter();
  ref.onDispose(service.dispose);
  return service;
});
