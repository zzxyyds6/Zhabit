import 'package:drift/drift.dart';

import '../db/database.dart';

/// 短期记录仓储层(PRD §3.2):做完变灰自动隐藏,完成态保留 7 天后清除。
class ShortTaskRepository {
  ShortTaskRepository(this._db);

  final AppDatabase _db;

  /// 完成态保留 7 天(PRD §3.2.2)。
  static const Duration retentionAfterComplete = Duration(days: 7);

  /// 首页"短期记录"区块:未隐藏的条目。
  Stream<List<ShortTaskRow>> watchVisibleTasks() {
    final query = _db.select(_db.shortTasks)
      ..where((t) => t.hidden.equals(false))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
    return query.watch();
  }

  Future<int> addTask(String name, {DateTime? dueDate, DateTime? reminderTime}) {
    return _db.into(_db.shortTasks).insert(ShortTasksCompanion.insert(
          name: name,
          dueDate: Value(dueDate),
          reminderTime: Value(reminderTime),
        ));
  }

  /// 完成:done + completedAt,前端据此变灰并自动隐藏。
  Future<void> completeTask(int id) {
    return (_db.update(_db.shortTasks)..where((t) => t.id.equals(id))).write(
      ShortTasksCompanion(
        done: const Value(true),
        completedAt: Value(DateTime.now()),
      ),
    );
  }

  /// 撤销完成(底部提示条的有效期内)。
  Future<void> undoComplete(int id) {
    return (_db.update(_db.shortTasks)..where((t) => t.id.equals(id))).write(
      ShortTasksCompanion(done: const Value(false), completedAt: const Value(null)),
    );
  }

  /// 超过保留期的完成项从数据库清除(启动时调用,#6 扩展每日触发)。
  Future<int> removeExpiredCompleted({DateTime? now}) {
    final now0 = now ?? DateTime.now();
    final cutoff = now0.subtract(retentionAfterComplete);
    return (_db.delete(_db.shortTasks)
          ..where((t) => t.done.equals(true) & t.completedAt.isSmallerOrEqualValue(cutoff)))
        .go();
  }
}