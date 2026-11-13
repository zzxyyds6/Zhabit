import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../providers.dart';

/// 添加短期记录(PRD §3.2.1):名称必填,截止时间与提醒时间可选。
Future<void> showAddShortTaskSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) => const _AddShortTaskSheet(),
  );
}

enum _DuePreset { none, today, tomorrow, thisWeek, custom }

class _AddShortTaskSheet extends ConsumerStatefulWidget {
  const _AddShortTaskSheet();

  @override
  ConsumerState<_AddShortTaskSheet> createState() => _AddShortTaskSheetState();
}

class _AddShortTaskSheetState extends ConsumerState<_AddShortTaskSheet> {
  final _controller = TextEditingController();
  bool _saving = false;
  _DuePreset _preset = _DuePreset.none;
  DateTime? _customDue;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  DateTime? get _dueDate {
    final now = DateTime.now();
    return switch (_preset) {
      _DuePreset.none => null,
      _DuePreset.today => DateTime(now.year, now.month, now.day, 23, 59),
      _DuePreset.tomorrow => DateTime(now.year, now.month, now.day + 1, 23, 59),
      // 本周 = 本周日 23:59
      _DuePreset.thisWeek => DateTime(now.year, now.month, now.day + (7 - now.weekday), 23, 59),
      _DuePreset.custom => _customDue,
    };
  }

  Future<void> _save() async {
    final name = _controller.text.trim();
    if (name.isEmpty || _saving) return;
    setState(() => _saving = true);
    // 提醒时间暂只记录,#7 接入平台调度(ADR-0002)
    await ref.read(shortTaskRepositoryProvider).addTask(name, dueDate: _dueDate);
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
          Text('添加短期记录', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          TextField(
            controller: _controller,
            autofocus: true,
            maxLength: 128,
            decoration: const InputDecoration(
              hintText: '例如:买笔记本、回电话',
              border: OutlineInputBorder(),
            ),
            onSubmitted: (_) => _save(),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              for (final preset in _DuePreset.values)
                ChoiceChip(
                  label: Text(switch (preset) {
                    _DuePreset.none => '不限期',
                    _DuePreset.today => '今天',
                    _DuePreset.tomorrow => '明天',
                    _DuePreset.thisWeek => '本周',
                    _DuePreset.custom => _customDue == null
                        ? '自定义'
                        : '${_customDue!.month}/${_customDue!.day}',
                  }),
                  selected: _preset == preset,
                  onSelected: (_) async {
                    if (preset == _DuePreset.custom) {
                      final picked = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (picked == null) return;
                      setState(() {
                        _customDue = picked;
                        _preset = _DuePreset.custom;
                      });
                    } else {
                      setState(() => _preset = preset);
                    }
                  },
                ),
            ],
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