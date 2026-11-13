import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/reminders/reminder_platform.dart';
import '../../data/db/database.dart';
import '../../data/db/tables.dart';
import '../../providers.dart';

/// 设置页(PRD §4.1):提醒全局设置(开关/模式/间隔/生效时段)。
/// 主题、备份与多语言在后续里程碑接入。
class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  ReminderGlobalRow? _settings;
  ReminderCapability _capability = ReminderCapability.unavailable;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final s = await ref.read(reminderSettingsRepositoryProvider).getSettings();
    _capability = await ref.read(reminderPlatformProvider).capability();
    setState(() => _settings = s);
  }

  Future<void> _save(ReminderGlobalRow s) async {
    setState(() => _saving = true);
    await ref.read(reminderSettingsRepositoryProvider).save(s);
    await ref.read(reminderSchedulerProvider).scheduleAll();
    setState(() => _saving = false);
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('已保存并重排提醒')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = _settings;
    if (s == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final capabilityText = switch (_capability) {
      ReminderCapability.full => '通知 + 精确闹钟可用',
      ReminderCapability.notificationsOnly => '通知可用(精确闹钟受限,时间可能漂移)',
      ReminderCapability.unavailable => '通知不可用,请在系统设置中开启',
    };

    return Scaffold(
      appBar: AppBar(title: const Text('设置')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('提醒', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 4),
          Text(capabilityText, style: Theme.of(context).textTheme.bodySmall),
          SwitchListTile(
            title: const Text('间隔提醒'),
            subtitle: const Text('按固定/随机间隔提醒未完成项'),
            value: s.enabled,
            onChanged: (v) => setState(() => _settings = _copy(s, enabled: v)),
          ),
          if (s.enabled) ...[
            SegmentedButton<ReminderMode>(
              segments: const [
                ButtonSegment(value: ReminderMode.fixed, label: Text('固定')),
                ButtonSegment(value: ReminderMode.random, label: Text('随机')),
              ],
              selected: {s.mode},
              onSelectionChanged: (sel) =>
                  setState(() => _settings = _copy(s, mode: sel.first)),
            ),
            const SizedBox(height: 8),
            if (s.mode == ReminderMode.fixed)
              _IntChips(
                label: '固定间隔',
                values: const [15, 30, 45, 60, 90, 120],
                selected: s.intervalMinutes,
                onSelected: (v) =>
                    setState(() => _settings = _copy(s, intervalMinutes: v)),
              ),
            if (s.mode == ReminderMode.random) ...[
              _IntChips(
                label: '随机下限(分钟)',
                values: const [5, 10, 15, 20, 30],
                selected: s.randomMin,
                onSelected: (v) => setState(
                  () => _settings = _copy(
                    s,
                    randomMin: v,
                    randomMax: v > s.randomMax ? v : s.randomMax,
                  ),
                ),
              ),
              _IntChips(
                label: '随机上限(分钟)',
                values: const [30, 45, 60, 90, 120, 180],
                selected: s.randomMax,
                onSelected: (v) =>
                    setState(() => _settings = _copy(s, randomMax: v)),
              ),
            ],
            ListTile(
              title: const Text('生效时段'),
              subtitle: Text('${s.activeFrom} ~ ${s.activeUntil}'),
              onTap: () async {
                final from = await _pickTime(s.activeFrom);
                if (from == null) return;
                final until = await _pickTime(s.activeUntil);
                if (until == null) return;
                setState(
                  () => _settings = _copy(
                    s,
                    activeFrom: from,
                    activeUntil: until,
                  ),
                );
              },
            ),
            _IntChips(
              label: '每次最多提醒条数',
              values: const [1, 2, 3],
              selected: s.maxPerPopup,
              onSelected: (v) =>
                  setState(() => _settings = _copy(s, maxPerPopup: v)),
            ),
            _IntChips(
              label: '同一记录冷却(分钟)',
              values: const [5, 15, 30, 60],
              selected: s.cooldownMinutes,
              onSelected: (v) =>
                  setState(() => _settings = _copy(s, cooldownMinutes: v)),
            ),
          ],
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: _saving ? null : () => _save(s),
            icon: const Icon(Icons.save),
            label: const Text('保存'),
          ),
        ],
      ),
    );
  }

  ReminderGlobalRow _copy(
    ReminderGlobalRow s, {
    bool? enabled,
    ReminderMode? mode,
    int? intervalMinutes,
    int? randomMin,
    int? randomMax,
    String? activeFrom,
    String? activeUntil,
    int? maxPerPopup,
    int? cooldownMinutes,
  }) {
    return ReminderGlobalRow(
      id: s.id,
      enabled: enabled ?? s.enabled,
      mode: mode ?? s.mode,
      intervalMinutes: intervalMinutes ?? s.intervalMinutes,
      randomMin: randomMin ?? s.randomMin,
      randomMax: randomMax ?? s.randomMax,
      activeFrom: activeFrom ?? s.activeFrom,
      activeUntil: activeUntil ?? s.activeUntil,
      maxPerPopup: maxPerPopup ?? s.maxPerPopup,
      cooldownMinutes: cooldownMinutes ?? s.cooldownMinutes,
    );
  }

  Future<String?> _pickTime(String initial) async {
    final parts = initial.split(':');
    final t = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: int.tryParse(parts.first) ?? 8,
        minute: int.tryParse(parts.length > 1 ? parts[1] : '') ?? 0,
      ),
    );
    if (t == null) return null;
    return '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
  }
}

class _IntChips extends StatelessWidget {
  const _IntChips({
    required this.label,
    required this.values,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final List<int> values;
  final int selected;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelLarge),
          Wrap(
            spacing: 8,
            children: [
              for (final v in values)
                ChoiceChip(
                  label: Text('$v'),
                  selected: selected == v,
                  onSelected: (_) => onSelected(v),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
