import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../data/db/database.dart';
import '../../providers.dart';

/// 首页(PRD §4.1):两个区块——长期习惯 / 短期记录。
/// #1 为空态骨架;#2、#6 接入各自的添加/打卡交互。
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    // 清理超过 7 天保留期的已完成短期记录(PRD §3.2.2)
    Future.microtask(() => ref.read(shortTaskRepositoryProvider).removeExpiredCompleted());
  }

  @override
  Widget build(BuildContext context) {
    final habits = ref.watch(habitRepositoryProvider).watchActiveHabits();
    final tasks = ref.watch(shortTaskRepositoryProvider).watchVisibleTasks();

    return Scaffold(
      appBar: AppBar(title: const Text('Zhabit')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showPlaceholder(context),
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          const _SectionHeader(title: '长期习惯'),
          StreamBuilder<List<HabitRow>>(
            stream: habits,
            builder: (context, snapshot) {
              final list = snapshot.data ?? const [];
              if (list.isEmpty) return const _EmptyHint(text: '还没有长期习惯,点 + 创建');
              return Column(children: [
                for (final h in list) Card(child: ListTile(title: Text(h.name))),
              ]);
            },
          ),
          const SizedBox(height: 16),
          const _SectionHeader(title: '短期记录'),
          StreamBuilder<List<ShortTaskRow>>(
            stream: tasks,
            builder: (context, snapshot) {
              final list = snapshot.data ?? const [];
              if (list.isEmpty) return const _EmptyHint(text: '暂无短期记录,点 + 快速添加');
              return Column(children: [
                for (final t in list) Card(child: ListTile(title: Text(t.name))),
              ]);
            },
          ),
        ],
      ),
    );
  }

  void _showPlaceholder(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('添加入口将在 #2(长期习惯)与 #6(短期记录)接入')),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(title, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}

class _EmptyHint extends StatelessWidget {
  const _EmptyHint({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(text, style: Theme.of(context).textTheme.bodySmall),
    );
  }
}