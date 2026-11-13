# ADR-0003: 提醒实现方案(基于 #9 预研,待真机项已标注)

- 状态:**方向已接受,基线实现落地;4 项真机验证未完成(issue #9 保持开放)**
- 决策人:Zhao(与 agent 讨论确认)

## 决策

1. **默认提醒:系统通知**,调度用 **flutter_local_notifications**(MIT,社区事实标准):
   - 固定/随机间隔用"一次性精确闹钟批量预排":设置变更或 App 启动时,把未来 24 小时内所有触发点(生效时段内,按固定或随机间隔)以 `zonedSchedule(exactAllowWhileIdle)` 批量排入 AlarmManager。这比依赖单条闹钟的"触发后再排"更抗进程死亡。
   - 通知操作按钮"完成"直接写打卡(payload 携带目标类型与 id)。
2. **重启恢复**:flutter_local_notifications 的已排通知在设备重启后**不会**自动恢复(插件无内建持久化)。方案:原生 Kotlin BootReceiver 在开机后调用 Dart 侧重排(经 method channel 触发 `RescheduleService`),**待真机验证**;若插件版本已提供等价能力则直接采用。
3. **浮窗(灵动岛式,可选增强)**:基线候选 **flutter_overlay_window**(SYSTEM_ALERT_WINDOW + 独立 isolate)。浮窗内"完成"打卡需要跨 isolate 通信(background isolate → 主 isolate / 数据库)。**方案可行性与交互待真机验证**,不阻塞通知路径(#7)。
4. **权限退化链**(全部待真机验证):
   - 通知权限(Android 13+ POST_NOTIFICATIONS)被拒 → 设置页给出开启指引,不再排通知
   - 精确闹钟(Android 12+ SCHEDULE_EXACT_ALARM)被拒 → 退化为 inexact(允许 ≤15 分钟漂移)
   - 悬浮窗权限被拒 → 通知路径照常(#10 的浮窗仅是增强)

## 预研验证矩阵(issue #9)

| 项 | 结论 |
|---|---|
| 后台定时提醒 | 基线成立(AlarmManager exact);**真机:App 被杀后 24h 批量预排是否全部触发** |
| 重启恢复 | 需 BootReceiver;**真机:重启后通知是否恢复** |
| 浮窗显示与交互 | 候选 flutter_overlay_window;**真机:样式与浮窗内打卡** |
| 权限退化 | 逻辑已实现;**真机:三种权限分别拒绝后的行为** |

## 后果

- #7 按本 ADR 实现通知路径与设置页;#10 浮窗在真机验证通过后实施。
- 业务层仅依赖 ReminderPlatform 接口(ADR-0001),实现替换不影响业务逻辑。