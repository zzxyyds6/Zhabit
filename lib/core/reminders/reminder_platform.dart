import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 提醒能力的平台接口(ADR-0001 第 3 条 / ADR-0002 第 4 条)。
/// 业务层只依赖本接口;Android 原生(Kotlin)实现在 #7 接入,
/// 浮窗增强(#10)同样通过本接口扩展,不得污染通用业务逻辑。
abstract interface class ReminderPlatform {
  /// 返回是否成功调度。false 表示权限缺失或平台不支持。
  Future<bool> scheduleReminder({
    required int id,
    required DateTime at,
    required String title,
    required String body,
  });

  Future<void> cancelReminder(int id);

  /// 返回当前可用能力摘要,供设置页展示退化状态。
  Future<ReminderCapability> capability();
}

enum ReminderCapability { unavailable, notificationsOnly, full }

/// 默认实现:#1 阶段占位,保持业务层可运行、可测试。
/// #7 按预研结论(ADR-0003)替换为真实实现。
class NoopReminderPlatform implements ReminderPlatform {
  const NoopReminderPlatform();

  @override
  Future<bool> scheduleReminder({
    required int id,
    required DateTime at,
    required String title,
    required String body,
  }) async => false;

  @override
  Future<void> cancelReminder(int id) async {}

  @override
  Future<ReminderCapability> capability() async => ReminderCapability.unavailable;
}

final reminderPlatformProvider =
    Provider<ReminderPlatform>((ref) => const NoopReminderPlatform());