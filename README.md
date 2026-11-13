# Zhabit

极简、离线、无广告的习惯打卡工具(Android 优先,Web 测试版)。

- 产品需求:`docs/PRD.md`
- 技术决策:`docs/adr/`
- 开发规范:`AGENTS.md`

## 功能

- 长期习惯:创建、每日一键打卡、撤销、连续天数、最近 7 天圆点
- 频率:每天、每周 N 次、指定星期几、每 N 天
- 月历:查看/补打卡/取消,30 天内可回补
- 短期记录:一次性任务、完成即隐藏、可撤销、7 天保留后清理
- 提醒:系统通知默认;固定间隔 / 随机区间 / 生效时段;通知上可直接完成
- Web 测试版:核心打卡流程可运行

## 构建

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test
flutter build apk --debug   # Android
flutter build web           # Web 测试版
```

### Web 集成冒烟

需要在本地先启动 chromedriver:

```bash
chromedriver --port=4444
flutter drive -d chrome \
  --browser-name=chrome \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/web_smoke_test.dart
```

## 技术栈(ADR-0001)

Flutter 3.50 · Riverpod · drift(Android 原生 SQLite / Web WASM)· 轻量分层 · GitHub Actions CI

## 隐私

无网络权限、无埋点、无账号。所有数据仅存本机;提醒通知只展示待办名称,不上传数据。