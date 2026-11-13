import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/habits/frequency.dart';
import '../../data/db/database.dart';
import '../../data/repositories/habit_repository.dart';
import '../../providers.dart';

/// 首页习惯卡片:名称 + 一键打卡按钮(#2 闭环)。
/// 连续天数与 7 天圆点在 #4 补充。
class HabitCard extends ConsumerWidget {
  const HabitCard({super.key, required this.habit, required this.checkedToday});

  final HabitRow habit;
  final bool checkedToday;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        title: Text(habit.name),
        subtitle: Text(HabitFrequencyLogic.label(habit)),
        trailing: IconButton.filled(
          isSelected: checkedToday,
          onPressed: () => _toggle(ref),
          icon: Icon(checkedToday ? Icons.check : Icons.radio_button_unchecked),
          tooltip: checkedToday ? '撤销今日打卡' : '打卡',
        ),
      ),
    );
  }

  Future<void> _toggle(WidgetRef ref) async {
    await ref.read(habitRepositoryProvider).toggleCheckIn(
          habit.id,
          HabitRepository.today(),
        );
  }
}