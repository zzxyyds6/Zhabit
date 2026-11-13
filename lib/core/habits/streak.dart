import '../../data/db/database.dart';
import '../../data/db/tables.dart';
import 'frequency.dart';

/// 连续天数计算(PRD §3.1.6),频率感知(ADR 讨论确认的语义):
/// - daily:按自然日连续,漏一天即断;今天未打卡不算断签(宽限)
/// - weeklyTimes:按周连续,周内完成数 ≥ X 才算该周完成;当周未达标是宽限期
/// - weekdays / everyNDays:只看轮到日,跳过非轮到日;今天未打卡不算断
class HabitStreakLogic {
  HabitStreakLogic._();

  static const _maxLookbackDays = 3650;

  /// 当前连续值。daily 返回"天",weeklyTimes 返回"周",其余返回"轮到日数"。
  static int currentStreak(HabitRow habit, Set<String> doneDates,
      {DateTime? now, DateTime? anchor}) {
    final today = DateTime(now?.year ?? DateTime.now().year,
        now?.month ?? DateTime.now().month, now?.day ?? DateTime.now().day);
    final start = _anchor(habit, anchor);

    return switch (habit.frequency) {
      HabitFrequency.daily => _dailyStreak(doneDates, today),
      HabitFrequency.weeklyTimes =>
        _weeklyStreak(habit, doneDates, today, start),
      _ => _scheduledStreak(habit, doneDates, today, start),
    };
  }

  static DateTime _anchor(HabitRow habit, DateTime? anchor) {
    final a = anchor ?? habit.createdAt;
    return DateTime(a.year, a.month, a.day);
  }

  static int _dailyStreak(Set<String> done, DateTime today) {
    var streak = 0;
    var d = today;
    for (var i = 0; i < _maxLookbackDays; i++) {
      final key = HabitFrequencyLogic.formatDate(d);
      if (done.contains(key)) {
        streak++;
        d = d.subtract(const Duration(days: 1));
      } else if (i == 0) {
        // 今天还没打:宽限,从昨天继续数
        d = d.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }
    return streak;
  }

  static int _weeklyStreak(
      HabitRow habit, Set<String> done, DateTime today, DateTime anchor) {
    final need = habit.frequencyValue ?? 1;
    var weekStart = today.subtract(Duration(days: today.weekday - 1));
    var streak = 0;
    for (var i = 0; i < _maxLookbackDays ~/ 7; i++) {
      var count = 0;
      for (var j = 0; j < 7; j++) {
        if (done.contains(HabitFrequencyLogic.formatDate(
            weekStart.add(Duration(days: j))))) {
          count++;
        }
      }
      if (count >= need) {
        streak++;
      } else if (i == 0) {
        // 当周未达标:宽限期,不计入,继续看上一周
      } else {
        break;
      }
      if (weekStart.isBefore(anchor)) break;
      weekStart = weekStart.subtract(const Duration(days: 7));
    }
    return streak;
  }

  static int _scheduledStreak(
      HabitRow habit, Set<String> done, DateTime today, DateTime anchor) {
    var streak = 0;
    var d = today;
    var first = true;
    for (var i = 0; i < _maxLookbackDays; i++) {
      if (HabitFrequencyLogic.isDueOn(habit, d, anchor: anchor)) {
        final key = HabitFrequencyLogic.formatDate(d);
        if (done.contains(key)) {
          streak++;
        } else if (first) {
          // 今天轮到但还没打:宽限,不中断
        } else {
          break;
        }
        first = false;
      }
      d = d.subtract(const Duration(days: 1));
      if (d.isBefore(anchor)) break;
    }
    return streak;
  }

  /// 最近 [days] 天(含今天)的逐日状态,供 7 天圆点渲染。
  /// 不轮到的日子返回 null;轮到且已完成 true;轮到未完成 false。
  static List<bool?> lastDays(HabitRow habit, Set<String> done, int days,
      {DateTime? now}) {
    final today = DateTime(now?.year ?? DateTime.now().year,
        now?.month ?? DateTime.now().month, now?.day ?? DateTime.now().day);
    return [
      for (var i = days - 1; i >= 0; i--)
        _status(habit, done, today.subtract(Duration(days: i))),
    ];
  }

  static bool? _status(HabitRow habit, Set<String> done, DateTime day) {
    final due = habit.frequency == HabitFrequency.daily ||
        habit.frequency == HabitFrequency.weeklyTimes ||
        HabitFrequencyLogic.isDueOn(habit, day);
    final key = HabitFrequencyLogic.formatDate(day);
    if (done.contains(key)) return true;
    if (!due) return null;
    return false;
  }

  /// 连续值单位文案。
  static String unit(HabitRow habit) => switch (habit.frequency) {
        HabitFrequency.weeklyTimes => '周',
        _ => '天',
      };
}