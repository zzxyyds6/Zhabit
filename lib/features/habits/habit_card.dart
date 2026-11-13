import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/habits/streak.dart';
import '../../data/db/database.dart';
import '../../data/repositories/habit_repository.dart';
import '../../providers.dart';
import '../habit_detail/habit_detail_page.dart';

/// 首页习惯卡片:名称 + 频率 + 连续天数 + 7 天圆点 + 一键打卡(#2/#4)。
class HabitCard extends ConsumerWidget {
  const HabitCard({super.key, required this.habit, required this.checkedToday});

  final HabitRow habit;
  final bool checkedToday;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final datesStream = ref.watch(habitRepositoryProvider).watchAllCheckInDates(habit.id);

    return Card(
      child: ListTile(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => HabitDetailPage(habit: habit))),
        title: Text(habit.name),
        subtitle: StreamBuilder<Set<String>>(
          stream: datesStream,
          builder: (context, snapshot) {
            final done = snapshot.data ?? const <String>{};
            final streak = HabitStreakLogic.currentStreak(habit, done);
            final dots = HabitStreakLogic.lastDays(habit, done, 7);
            return Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                children: [
                  Text(
                    '连续 $streak ${HabitStreakLogic.unit(habit)}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(width: 12),
                  for (final status in dots) ...[
                    _DayDot(status: status),
                    const SizedBox(width: 3),
                  ],
                ],
              ),
            );
          },
        ),
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

class _DayDot extends StatelessWidget {
  const _DayDot({required this.status});

  /// true = 已完成,false = 轮到未完成,null = 不轮到
  final bool? status;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = switch (status) {
      true => scheme.primary,
      false => scheme.outlineVariant,
      null => scheme.surfaceContainerHighest,
    };
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}