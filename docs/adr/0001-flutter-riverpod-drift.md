# ADR-0001: Flutter + Riverpod + drift + 轻量分层

- 状态:已接受(2026-11-13)
- 决策人:Zhao(与 agent 讨论后确认)

## 背景

Zhabit 是 Android 优先的习惯打卡工具,PRD 同时要求预留 Web 测试版;数据全部本地化(PRD §5),需要响应式 UI 与可测试的提醒调度。

## 决策

1. **状态管理:Riverpod**(编译期安全、测试友好;否决 Bloc——模板代码过重,否决 GetX——可维护性差)。
2. **数据库:drift**。Android 用原生 SQLite;**Web 测试版**用 drift 的 Web/WASM 支持。平台差异仅存在于**数据库初始化与底层存储连接**,数据模型、查询逻辑、Repository 三层全部共用。
3. **架构:轻量分层** UI → Controller(Riverpod)→ Repository → drift,按功能分目录。**不引入完整 Clean Architecture**(单人 MVP 体量下是负担)。**提醒功能必须通过平台接口抽象**暴露给业务层,Android 原生代码不得污染通用逻辑(ADR-0002)。
4. **CI:GitHub Actions 单 job**:`flutter analyze` + `flutter test` + Android debug APK 构建 + **Web 构建检查**。

## 后果

- Web 版本仅作测试用途,发布目标仍是 Android APK(GitHub Releases)。
- drift 的响应式查询使 UI 自动跟随数据变化,减少手写刷新逻辑。