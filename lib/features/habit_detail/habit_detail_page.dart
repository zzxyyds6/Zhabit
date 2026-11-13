import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/habits/frequency.dart';
import '../../core/habits/streak.dart';
import '../../data/db/database.dart';
import '../../providers.dart';

/// 习惯详情(PRD §3.1.6):月历视图 + 30 天内补打卡/取消。
class HabitDetailPage extends ConsumerStatefulWidget {
  const HabitDetailPage({super.key, required this.habit});

  final HabitRow habit;

  @override
  ConsumerState<HabitDetailPage> createState() => _HabitDetailPageState();
}

class _HabitDetailPageState extends ConsumerState<HabitDetailPage> {
  late DateTime _month;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _month = DateTime(now.year, now.month);
  }

  @override
  Widget build(BuildContext context) {
    final datesStream = ref
        .watch(habitRepositoryProvider)
        .watchAllCheckInDates(widget.habit.id);

    return Scaffold(
      appBar: AppBar(title: Text(widget.habit.name)),
      body: StreamBuilder<Set<String>>(
        stream: datesStream,
        builder: (context, snapshot) {
          final done = snapshot.data ?? const <String>{};
          final streak = HabitStreakLogic.currentStreak(widget.habit, done);
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text('连续 $streak ${HabitStreakLogic.unit(widget.habit)}',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),
              _MonthHeader(
                month: _month,
                onPrev: () => setState(() => _month = DateTime(_month.year, _month.month - 1)),
                onNext: () => setState(() => _month = DateTime(_month.year, _month.month + 1)),
              ),
              const SizedBox(height: 8),
              _CalendarGrid(
                habit: widget.habit,
                month: _month,
                done: done,
                onDayTap: _onDayTap,
              ),
              const SizedBox(height: 8),
              Text(
                '点击过去 30 天内的日期可补打卡或取消',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _onDayTap(DateTime day) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(day.year, day.month, day.day);
    // 回溯上限 30 天,且不能早于习惯创建日(PRD §3.1.5)
    if (target.isAfter(today)) return;
    if (today.difference(target).inDays > 30) return;
    if (target.isBefore(DateTime(widget.habit.createdAt.year,
        widget.habit.createdAt.month, widget.habit.createdAt.day))) {
      return;
    }
    await ref
        .read(habitRepositoryProvider)
        .toggleCheckIn(widget.habit.id, HabitFrequencyLogic.formatDate(target));
  }
}

class _MonthHeader extends StatelessWidget {
  const _MonthHeader({required this.month, required this.onPrev, required this.onNext});

  final DateTime month;
  final VoidCallback onPrev;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(onPressed: onPrev, icon: const Icon(Icons.chevron_left)),
        Text('${month.year} 年 ${month.month} 月',
            style: Theme.of(context).textTheme.titleMedium),
        IconButton(onPressed: onNext, icon: const Icon(Icons.chevron_right)),
      ],
    );
  }
}

class _CalendarGrid extends StatelessWidget {
  const _CalendarGrid({
    required this.habit,
    required this.month,
    required this.done,
    required this.onDayTap,
  });

  final HabitRow habit;
  final DateTime month;
  final Set<String> done;
  final ValueChanged<DateTime> onDayTap;

  @override
  Widget build(BuildContext context) {
    const weekdayNames = ['一', '二', '三', '四', '五', '六', '日'];
    final first = DateTime(month.year, month.month);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final leadingBlanks = first.weekday - 1; // 周一为首列

    return Column(
      children: [
        Row(
          children: [
            for (final name in weekdayNames)
              Expanded(
                child: Center(
                  child: Text(name, style: Theme.of(context).textTheme.labelSmall),
                ),
              ),
          ],
        ),
        for (var row = 0; row < 6; row++)
          Row(
            children: [
              for (var col = 0; col < 7; col++)
                Expanded(child: _cell(context, row, col, leadingBlanks, daysInMonth)),
            ],
          ),
      ],
    );
  }

  Widget _cell(BuildContext context, int row, int col, int leading, int daysInMonth) {
    final dayNumber = row * 7 + col - leading + 1;
    if (dayNumber < 1 || dayNumber > daysInMonth) {
      return const SizedBox(height: 44);
    }
    final day = DateTime(month.year, month.month, dayNumber);
    final status = HabitStreakLogic.dayStatus(habit, done, day);
    final scheme = Theme.of(context).colorScheme;
    final dotColor = switch (status) {
      true => scheme.primary,
      false => scheme.outlineVariant,
      null => scheme.surfaceContainerHighest,
    };
    final key = 'day-${HabitFrequencyLogic.formatDate(day)}';

    return SizedBox(
      height: 44,
      child: InkWell(
        key: ValueKey(key),
        onTap: () => onDayTap(day),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$dayNumber', style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 4),
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
            ),
          ],
        ),
      ),
    );
  }
}