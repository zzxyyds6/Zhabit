import '../../data/db/database.dart';
import '../../data/db/tables.dart';

/// 频率判定与展示(PRD §3.1.4)。
/// 纯函数,便于单元测试;streak 的"频率达成"语义(#4)复用本文件。
class HabitFrequencyLogic {
  HabitFrequencyLogic._();

  /// [day] 当天是否轮到该习惯。
  ///
  /// - daily:每天
  /// - weeklyTimes(每周 X 次):每天显示,由用户自选 X 天完成;
  ///   连续性按"周内完成数 ≥ X"判定(#4)
  /// - weekdays:weekdays 为 1-7 的 CSV(1=周一…7=周日,与 DateTime.weekday 一致)
  /// - everyNDays:value = N,从习惯创建日([anchor])起每 N 天一次
  static bool isDueOn(HabitRow habit, DateTime day, {DateTime? anchor}) {
    final a = DateTime(anchor?.year ?? habit.createdAt.year,
        anchor?.month ?? habit.createdAt.month, anchor?.day ?? habit.createdAt.day);
    final d = DateTime(day.year, day.month, day.day);
    return switch (habit.frequency) {
      HabitFrequency.daily => true,
      // 每周 X 次:不设固定日程,列表常显
      HabitFrequency.weeklyTimes => true,
      HabitFrequency.weekdays => parseWeekdays(habit.weekdays).contains(d.weekday),
      HabitFrequency.everyNDays =>
        habit.frequencyValue != null &&
            habit.frequencyValue! > 0 &&
            d.difference(a).inDays >= 0 &&
            d.difference(a).inDays % habit.frequencyValue! == 0,
    };
  }

  /// 解析 weekdays CSV("1,3,5" → {1,3,5});非法内容忽略。
  static Set<int> parseWeekdays(String? csv) {
    if (csv == null || csv.isEmpty) return {};
    return csv
        .split(',')
        .map((s) => int.tryParse(s.trim()))
        .whereType<int>()
        .where((v) => v >= 1 && v <= 7)
        .toSet();
  }

  static String encodeWeekdays(Set<int> days) =>
      (days.toList()..sort()).join(',');

  /// 卡片上的频率说明文案(PRD §3.1.6)。
  static String label(HabitRow habit) {
    const names = ['一', '二', '三', '四', '五', '六', '日'];
    return switch (habit.frequency) {
      HabitFrequency.daily => '每天',
      HabitFrequency.weeklyTimes => '每周 ${habit.frequencyValue ?? 1} 次',
      HabitFrequency.weekdays => () {
          final days = parseWeekdays(habit.weekdays).toList()..sort();
          return '每周${days.map((d) => names[d - 1]).join('、')}';
        }(),
      HabitFrequency.everyNDays => '每 ${habit.frequencyValue ?? 1} 天',
    };
  }

  /// 日期键:YYYY-MM-DD(本地时区)。
  static String formatDate(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-'
      '${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';
}