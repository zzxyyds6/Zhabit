import 'dart:math';

import '../../data/db/database.dart';
import '../../data/db/tables.dart';

/// 未来 24h 触发点规划(ADR-0003 第 1 条:批量预排)。
/// 纯函数,注入 Random 便于测试。
class ReminderSchedulePlanner {
  ReminderSchedulePlanner._();

  static const horizon = Duration(hours: 24);

  /// 按设置生成触发时刻列表(升序)。
  /// 生效时段 [activeFrom, activeUntil] 为 HH:mm 文本;跨 0 点按 [from>until] 处理。
  static List<DateTime> upcomingFireTimes({
    required ReminderGlobalRow settings,
    required DateTime now,
    Random? rng,
  }) {
    if (!settings.enabled) return const [];
    final from = _parseHm(settings.activeFrom);
    final until = _parseHm(settings.activeUntil);
    final end = now.add(horizon);
    final result = <DateTime>[];
    final random = rng ?? Random();

    var cursor = now;
    while (true) {
      final step = switch (settings.mode) {
        ReminderMode.fixed => Duration(minutes: settings.intervalMinutes),
        ReminderMode.random => Duration(
          minutes:
              settings.randomMin +
              random.nextInt(
                (settings.randomMax - settings.randomMin + 1).clamp(1, 24 * 60),
              ),
        ),
        // scheduled_only:由具体条目的提醒时间驱动,MVP 不做全量预排
        ReminderMode.scheduledOnly => const Duration(hours: 24),
      };
      final next = cursor.add(step);
      if (next.isAfter(end)) break;
      if (_inActiveWindow(next, from, until)) result.add(next);
      cursor = next;
    }
    return result;
  }

  static (int, int) _parseHm(String s) {
    final parts = s.split(':');
    final h = int.tryParse(parts.isNotEmpty ? parts[0] : '') ?? 0;
    final m = int.tryParse(parts.length > 1 ? parts[1] : '') ?? 0;
    return (h.clamp(0, 23), m.clamp(0, 59));
  }

  static bool _inActiveWindow(DateTime t, (int, int) from, (int, int) until) {
    final minutes = t.hour * 60 + t.minute;
    final f = from.$1 * 60 + from.$2;
    final u = until.$1 * 60 + until.$2;
    if (f <= u) return minutes >= f && minutes <= u;
    // 跨 0 点:如 22:00-06:00
    return minutes >= f || minutes <= u;
  }
}
