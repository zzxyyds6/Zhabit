import 'noop_reminder_platform_stub.dart'
    if (dart.library.io) 'notification_reminder_platform.dart'
    as impl;

import 'reminder_platform.dart';

/// 平台工厂(ADR-0001):Web 用 Noop 占位,原生平台用系统通知实现。
/// 业务层与设置页只依赖本函数与 ReminderPlatform 接口。
ReminderPlatform createReminderPlatform() => impl.createPlatform();
