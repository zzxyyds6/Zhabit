import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import 'reminder_platform.dart';

/// Android 系统通知实现(ADR-0002:默认提醒方式;ADR-0003:批量预排)。
class NotificationReminderPlatform implements ReminderPlatform {
  NotificationReminderPlatform({this.onCompleteAction});

  /// 用户在通知上点"完成"时回调,payload 由调度方约定。
  final void Function(String payload)? onCompleteAction;

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  final StreamController<String> _actions =
      StreamController<String>.broadcast();
  bool _initialized = false;
  bool? _exactAllowed;

  /// 通知"完成"按钮的 payload 流(habit:id / task:id)。
  @override
  Stream<String> get actionPayloads => _actions.stream;

  Future<void> _ensureInit() async {
    if (_initialized) return;
    tzdata.initializeTimeZones();
    final dynamic tzInfo = await FlutterTimezone.getLocalTimezone();
    final name = tzInfo is String ? tzInfo : tzInfo.identifier as String;
    tz.setLocalLocation(tz.getLocation(name));
    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
      onDidReceiveNotificationResponse: _onResponse,
    );
    _initialized = true;
  }

  void _onResponse(NotificationResponse response) {
    final payload = response.payload;
    if (payload == null || payload.isEmpty) return;
    // 仅操作按钮"完成"触发直接打卡;点通知本体只打开 App
    if (response.actionId == 'complete') {
      _actions.add(payload);
      onCompleteAction?.call(payload);
    }
  }

  @override
  Future<bool> scheduleReminder({
    required int id,
    required DateTime at,
    required String title,
    required String body,
    String? payload,
  }) async {
    try {
      await _ensureInit();
      final android = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      final notificationsEnabled =
          await android?.areNotificationsEnabled() ?? false;
      if (!notificationsEnabled) return false;

      _exactAllowed = await android?.canScheduleExactNotifications();
      final exact = _exactAllowed ?? false;

      const details = NotificationDetails(
        android: AndroidNotificationDetails(
          'zhabit-reminders',
          '习惯提醒',
          channelDescription: '固定/随机间隔的打卡提醒',
          importance: Importance.high,
          priority: Priority.high,
          actions: [AndroidNotificationAction('complete', '完成')],
        ),
      );
      await _plugin.zonedSchedule(
        id: id,
        title: title,
        body: body,
        scheduledDate: tz.TZDateTime.from(at, tz.local),
        notificationDetails: details,
        payload: payload ?? '',
        androidScheduleMode: exact
            ? AndroidScheduleMode.exactAllowWhileIdle
            : AndroidScheduleMode.inexactAllowWhileIdle,
      );
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<void> cancelReminder(int id) async {
    if (!_initialized) return;
    await _plugin.cancel(id: id);
  }

  @override
  Future<void> cancelAll() async {
    try {
      await _ensureInit();
      await _plugin.cancelAll();
    } catch (_) {
      // 测试环境或未就绪时忽略;真实平台由后续 schedule 重试初始化。
    }
  }

  @override
  @override
  Future<ReminderCapability> capability() async {
    try {
      await _ensureInit();
      final android = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      final notificationsEnabled =
          await android?.areNotificationsEnabled() ?? false;
      if (!notificationsEnabled) return ReminderCapability.unavailable;
      final exact = await android?.canScheduleExactNotifications() ?? false;
      return exact
          ? ReminderCapability.full
          : ReminderCapability.notificationsOnly;
    } catch (_) {
      return ReminderCapability.unavailable;
    }
  }
}

ReminderPlatform createPlatform() => NotificationReminderPlatform();
