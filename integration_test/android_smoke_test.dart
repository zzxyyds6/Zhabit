import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:zhabit/core/reminders/reminder_platform.dart';
import 'package:zhabit/core/reminders/reminder_platform_factory.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Android 通知调度冒烟', (tester) async {
    final platform = createReminderPlatform();
    final capability = await platform.capability();

    // 模拟器上精确闹钟可能受限,所以允许 notificationsOnly;
    // 通知权限未授予时才是 unavailable。
    expect(capability, isNot(ReminderCapability.unavailable));

    final scheduled = await platform.scheduleReminder(
      id: 900001,
      at: DateTime.now().add(const Duration(minutes: 1)),
      title: 'Zhabit Android 冒烟',
      body: '验证通知调度链路',
      payload: 'habit:1',
    );
    expect(scheduled, isTrue);

    await platform.cancelReminder(900001);
  });
}
