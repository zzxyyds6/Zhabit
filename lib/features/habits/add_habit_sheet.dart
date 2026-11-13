import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/habits/frequency.dart';
import '../../data/db/tables.dart';
import '../../providers.dart';

/// 添加长期习惯(PRD §3.1.2 / §3.1.4):名称 + 频率。
Future<void> showAddHabitSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) => const _AddHabitSheet(),
  );
}

class _AddHabitSheet extends ConsumerStatefulWidget {
  const _AddHabitSheet();

  @override
  ConsumerState<_AddHabitSheet> createState() => _AddHabitSheetState();
}

class _AddHabitSheetState extends ConsumerState<_AddHabitSheet> {
  final _controller = TextEditingController();
  bool _saving = false;
  HabitFrequency _frequency = HabitFrequency.daily;
  int _weeklyTimes = 3;
  final Set<int> _weekdays = {1, 3, 5};
  int _everyNDays = 2;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _controller.text.trim();
    if (name.isEmpty || _saving) return;
    // 星期几必须至少选一天;每周 X 次至少 1
    if (_frequency == HabitFrequency.weekdays && _weekdays.isEmpty) return;
    if (_frequency == HabitFrequency.weeklyTimes && _weeklyTimes < 1) return;
    setState(() => _saving = true);
    await ref.read(habitRepositoryProvider).addHabit(
          name,
          frequency: _frequency,
          frequencyValue: switch (_frequency) {
            HabitFrequency.weeklyTimes => _weeklyTimes,
            HabitFrequency.everyNDays => _everyNDays,
            _ => null,
          },
          weekdays:
              _frequency == HabitFrequency.weekdays ? HabitFrequencyLogic.encodeWeekdays(_weekdays) : null,
        );
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('添加长期习惯', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          TextField(
            controller: _controller,
            autofocus: true,
            maxLength: 64,
            decoration: const InputDecoration(
              hintText: '例如:睡前阅读',
              border: OutlineInputBorder(),
            ),
            onSubmitted: (_) => _save(),
          ),
          const SizedBox(height: 4),
          Text('频率', style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 4),
          Wrap(
            spacing: 8,
            children: [
              for (final f in HabitFrequency.values)
                ChoiceChip(
                  label: Text(switch (f) {
                    HabitFrequency.daily => '每天',
                    HabitFrequency.weeklyTimes => '每周几次',
                    HabitFrequency.weekdays => '指定星期',
                    HabitFrequency.everyNDays => '每 N 天',
                  }),
                  selected: _frequency == f,
                  onSelected: (_) => setState(() => _frequency = f),
                ),
            ],
          ),
          _FrequencyInput(
            frequency: _frequency,
            weeklyTimes: _weeklyTimes,
            weekdays: _weekdays,
            everyNDays: _everyNDays,
            onWeeklyTimes: (v) => setState(() => _weeklyTimes = v),
            onWeekdays: (days) => setState(() => _weekdays
              ..clear()
              ..addAll(days)),
            onEveryNDays: (v) => setState(() => _everyNDays = v),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: _save,
            icon: const Icon(Icons.check),
            label: const Text('保存'),
          ),
        ],
      ),
    );
  }
}

class _FrequencyInput extends StatelessWidget {
  const _FrequencyInput({
    required this.frequency,
    required this.weeklyTimes,
    required this.weekdays,
    required this.everyNDays,
    required this.onWeeklyTimes,
    required this.onWeekdays,
    required this.onEveryNDays,
  });

  final HabitFrequency frequency;
  final int weeklyTimes;
  final Set<int> weekdays;
  final int everyNDays;
  final ValueChanged<int> onWeeklyTimes;
  final ValueChanged<Set<int>> onWeekdays;
  final ValueChanged<int> onEveryNDays;

  static const _names = ['一', '二', '三', '四', '五', '六', '日'];

  @override
  Widget build(BuildContext context) {
    return switch (frequency) {
      HabitFrequency.daily => const SizedBox.shrink(),
      HabitFrequency.weeklyTimes => Wrap(
          spacing: 8,
          children: [
            for (final n in [1, 2, 3, 4, 5, 6, 7])
              ChoiceChip(
                label: Text('$n 次'),
                selected: weeklyTimes == n,
                onSelected: (_) => onWeeklyTimes(n),
              ),
          ],
        ),
      HabitFrequency.weekdays => Wrap(
          spacing: 8,
          children: [
            for (var i = 1; i <= 7; i++)
              FilterChip(
                label: Text(_names[i - 1]),
                selected: weekdays.contains(i),
                onSelected: (sel) {
                  final next = {...weekdays};
                  sel ? next.add(i) : next.remove(i);
                  onWeekdays(next);
                },
              ),
          ],
        ),
      HabitFrequency.everyNDays => Wrap(
          spacing: 8,
          children: [
            for (final n in [2, 3, 4, 5, 6, 7])
              ChoiceChip(
                label: Text('每 $n 天'),
                selected: everyNDays == n,
                onSelected: (_) => onEveryNDays(n),
              ),
          ],
        ),
    };
  }
}