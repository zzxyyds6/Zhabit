import 'package:drift/drift.dart';

import '../db/database.dart';

/// 弹窗提醒全局设置(单行,id = 1)。#7 扩展具体调度逻辑。
class ReminderSettingsRepository {
  ReminderSettingsRepository(this._db);

  final AppDatabase _db;

  Stream<ReminderGlobalRow> watchSettings() {
    return (_db.select(_db.reminderGlobal)..where((r) => r.id.equals(1)))
        .watchSingleOrNull()
        .asyncMap((row) async => row ?? await _ensureDefaults());
  }

  Future<ReminderGlobalRow> getSettings() async {
    final row = await (_db.select(_db.reminderGlobal)..where((r) => r.id.equals(1)))
        .getSingleOrNull();
    return row ?? await _ensureDefaults();
  }

  Future<ReminderGlobalRow> _ensureDefaults() async {
    await _db.into(_db.reminderGlobal).insert(const ReminderGlobalCompanion());
    return (_db.select(_db.reminderGlobal)..where((r) => r.id.equals(1))).getSingle();
  }

  Future<void> save(ReminderGlobalRow row) {
    return (_db.update(_db.reminderGlobal)..where((r) => r.id.equals(1))).write(
      ReminderGlobalCompanion(
        enabled: Value(row.enabled),
        mode: Value(row.mode),
        intervalMinutes: Value(row.intervalMinutes),
        randomMin: Value(row.randomMin),
        randomMax: Value(row.randomMax),
        activeFrom: Value(row.activeFrom),
        activeUntil: Value(row.activeUntil),
        maxPerPopup: Value(row.maxPerPopup),
        cooldownMinutes: Value(row.cooldownMinutes),
      ),
    );
  }
}