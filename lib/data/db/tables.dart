import 'package:drift/drift.dart';

/// 习惯类型(PRD §3.1.1):P0 仅支持普通习惯
enum HabitType { normal, avoid, amount }

/// 打卡频率(PRD §3.1.4)
enum HabitFrequency { daily, weeklyTimes, weekdays, everyNDays }

/// 打卡记录状态
enum CheckStatus { done, failed, skipped }

/// 弹窗提醒全局模式(PRD §6 ReminderGlobal)
enum ReminderMode { fixed, random, scheduledOnly }

/// 长期习惯(PRD §6 Habit)
@DataClassName('HabitRow')
class Habits extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 64)();
  TextColumn get type => textEnum<HabitType>().withDefault(Constant(HabitType.normal.name))();
  TextColumn get unit => text().nullable()();
  IntColumn get dailyGoal => integer().nullable()();
  TextColumn get frequency => textEnum<HabitFrequency>().withDefault(Constant(HabitFrequency.daily.name))();
  IntColumn get frequencyValue => integer().nullable()();
  TextColumn get weekdays => text().nullable()();
  TextColumn get reminderTime => text().nullable()();
  TextColumn get reminderDays => text().nullable()();
  IntColumn get color => integer().withDefault(const Constant(0xFF2E7D6B))();
  TextColumn get icon => text().withDefault(const Constant('star'))();
  BoolColumn get archived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get vacationUntil => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// 每日打卡记录,一条/天(PRD §6 CheckIn)
@DataClassName('CheckInRow')
@TableIndex(name: 'check_in_habit_date', unique: true, columns: {#habitId, #date})
class CheckIns extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get habitId => integer().references(Habits, #id)();
  /// YYYY-MM-DD,避免时区与日期计算歧义
  TextColumn get date => text()();
  TextColumn get status => textEnum<CheckStatus>().withDefault(Constant(CheckStatus.done.name))();
  IntColumn get amount => integer().nullable()();
  TextColumn get note => text().nullable()();
}

/// 短期记录(PRD §6 ShortTask):做完即消失,完成态保留 7 天
@DataClassName('ShortTaskRow')
class ShortTasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 128)();
  DateTimeColumn get dueDate => dateTime().nullable()();
  DateTimeColumn get reminderTime => dateTime().nullable()();
  BoolColumn get done => boolean().withDefault(const Constant(false))();
  DateTimeColumn get completedAt => dateTime().nullable()();
  BoolColumn get hidden => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// 弹窗提醒全局设置,单行(id = 1)(PRD §6 ReminderGlobal)
@DataClassName('ReminderGlobalRow')
class ReminderGlobal extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  BoolColumn get enabled => boolean().withDefault(const Constant(false))();
  TextColumn get mode => textEnum<ReminderMode>().withDefault(Constant(ReminderMode.fixed.name))();
  IntColumn get intervalMinutes => integer().withDefault(const Constant(30))();
  IntColumn get randomMin => integer().withDefault(const Constant(15))();
  IntColumn get randomMax => integer().withDefault(const Constant(60))();
  TextColumn get activeFrom => text().withDefault(const Constant('08:00'))();
  TextColumn get activeUntil => text().withDefault(const Constant('22:00'))();
  IntColumn get maxPerPopup => integer().withDefault(const Constant(3))();
  IntColumn get cooldownMinutes => integer().withDefault(const Constant(15))();
}