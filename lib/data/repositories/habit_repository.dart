import 'package:drift/drift.dart';

import '../db/database.dart';
import '../db/tables.dart';

/// 长期习惯与打卡的仓储层(PRD §3.1、§6)。
/// 频率过滤(#3)与 streak 计算(#4)在本层扩展。
class HabitRepository {
  HabitRepository(this._db);

  final AppDatabase _db;

  /// 首页"长期习惯"区块:未归档,按创建时间倒序。
  Stream<List<HabitRow>> watchActiveHabits() {
    final query = _db.select(_db.habits)
      ..where((h) => h.archived.equals(false))
      ..orderBy([(h) => OrderingTerm.desc(h.createdAt)]);
    return query.watch();
  }

  Future<int> addHabit(String name) {
    return _db.into(_db.habits).insert(HabitsCompanion.insert(name: name));
  }

  Future<void> archiveHabit(int id) {
    return (_db.update(_db.habits)..where((h) => h.id.equals(id)))
        .write(const HabitsCompanion(archived: Value(true)));
  }

  /// 一键打卡:当天无记录则插入 done;再点一次撤销(删除当天记录)。#2 闭环的核心。
  Future<bool> toggleCheckIn(int habitId, String date) async {
    final existing = await (_db.select(_db.checkIns)
          ..where((c) => c.habitId.equals(habitId) & c.date.equals(date)))
        .getSingleOrNull();
    if (existing != null) {
      await (_db.delete(_db.checkIns)..where((c) => c.id.equals(existing.id))).go();
      return false;
    }
    await _db.into(_db.checkIns).insert(CheckInsCompanion.insert(
          habitId: habitId,
          date: date,
        ));
    return true;
  }

  /// 今日已完成打卡的习惯 id 集合(驱动首页打卡按钮状态)。
  Stream<Set<int>> watchCheckedHabitIds(String date) {
    final query = _db.select(_db.checkIns)..where((c) => c.date.equals(date));
    return query.watch().map(
          (rows) => rows.where((r) => r.status == CheckStatus.done).map((r) => r.habitId).toSet(),
        );
  }
  /// 某习惯近 [days] 天的打卡记录(升序)。
  Stream<List<CheckInRow>> watchRecentCheckIns(int habitId, int days) {
    final fromDate = formatDate(DateTime.now().subtract(Duration(days: days)));
    final query = _db.select(_db.checkIns)
      ..where((c) => c.habitId.equals(habitId) & c.date.isBiggerOrEqualValue(fromDate))
      ..orderBy([(c) => OrderingTerm.asc(c.date)]);
    return query.watch();
  }

  /// 统一日期键:YYYY-MM-DD(本地时区)。
  static String formatDate(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-'
      '${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';

  static String today() => formatDate(DateTime.now());
}