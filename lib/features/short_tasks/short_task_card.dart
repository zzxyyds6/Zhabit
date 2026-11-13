import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../data/db/database.dart';
import '../../providers.dart';

/// 短期记录条目:名称 + 截止时间 + 完成按钮(PRD §3.2.2)。
/// 点击完成:变灰 → 自动隐藏 → 底部提示条可撤销。
class ShortTaskCard extends ConsumerWidget {
  const ShortTaskCard({super.key, required this.task});

  final ShortTaskRow task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final due = task.dueDate;
    final dueLabel = due == null
        ? null
        : '${due.month}/${due.day}'
            '${due.hour == 23 && due.minute == 59 ? '' : ' ${due.hour}:${due.minute.toString().padLeft(2, '0')}'}';

    return Card(
      child: ListTile(
        title: Text(task.name),
        subtitle: dueLabel == null ? null : Text('截止 $dueLabel'),
        trailing: IconButton(
          onPressed: () => _complete(context, ref),
          tooltip: '完成',
          icon: const Icon(Icons.check_circle_outline),
        ),
      ),
    );
  }

  Future<void> _complete(BuildContext context, WidgetRef ref) async {
    final repo = ref.read(shortTaskRepositoryProvider);
    await repo.completeTask(task.id);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('已完成"${task.name}"'),
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: '撤销',
          onPressed: () => repo.undoComplete(task.id),
        ),
      ),
    );
  }
}