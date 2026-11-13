# Zhabit

极简、离线、无广告的习惯打卡工具(Android 优先,Web 测试版)。

- 产品需求:`docs/PRD.md`
- 技术决策:`docs/adr/`
- 开发规范:`AGENTS.md`

## 构建

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test
flutter build apk --debug   # Android
flutter build web           # Web 测试版
```

## 技术栈(ADR-0001)

Flutter 3.50 · Riverpod · drift(Android 原生 SQLite / Web WASM)· 轻量分层 · GitHub Actions CI

## 隐私

无网络权限、无埋点、无账号。所有数据仅存本机。