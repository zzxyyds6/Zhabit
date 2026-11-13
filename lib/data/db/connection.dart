import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

/// 平台差异隔离层(ADR-0001 第 2 条):
/// - Android:原生 SQLite(sqlite3_flutter_libs + path_provider,drift_flutter 自动处理)
/// - Web:drift WASM(sqlite3.wasm / drift_worker.js 需放入 web/,仅测试用途)
/// 数据模型、查询逻辑、Repository 不感知平台差异。
QueryExecutor openAppDatabaseConnection() {
  return driftDatabase(name: 'zhabit');
}