/// 提醒能力的平台接口(ADR-0001 第 3 条 / ADR-0002 第 4 条)。
/// 业务层只依赖本接口;Android 原生(Kotlin)实现在 #7 接入,
/// 浮窗增强(#10)同样通过本接口扩展,不得污染通用业务逻辑。
abstract interface class ReminderPlatform {
  /// 返回是否成功调度。false 表示权限缺失或平台不支持。
  /// [payload] 随通知返回,"完成"操作据此写打卡(约定 habit:id / task:id)。
  Future<bool> scheduleReminder({
    required int id,
    required DateTime at,
    required String title,
    required String body,
    String? payload,
  });

  Future<void> cancelReminder(int id);

  /// 重排前清理平台侧旧提醒。
  Future<void> cancelAll();

  /// "完成"动作的 payload 流(habit:id / task:id);不支持的实现返回空流。
  Stream<String> get actionPayloads;

  /// 返回当前可用能力摘要,供设置页展示退化状态。
  Future<ReminderCapability> capability();
}

enum ReminderCapability { unavailable, notificationsOnly, full }

/// 默认实现:占位实现,保持业务层可运行、可测试。
class NoopReminderPlatform implements ReminderPlatform {
  const NoopReminderPlatform();

  @override
  Future<bool> scheduleReminder({
    required int id,
    required DateTime at,
    required String title,
    required String body,
    String? payload,
  }) async => false;

  @override
  Future<void> cancelReminder(int id) async {}

  @override
  Future<void> cancelAll() async {}

  @override
  Stream<String> get actionPayloads => const Stream.empty();

  @override
  Future<ReminderCapability> capability() async =>
      ReminderCapability.unavailable;
}
