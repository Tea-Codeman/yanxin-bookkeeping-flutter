# 颜芯记账（Flutter 版）

本地优先的个人记账 App。Flutter 3.47.2 / Dart 3.13.2，当前目标平台 **Android**。

> 这是 uni-app 版的**重写**。旧仓库 `Tea-Codeman/yanxin-bookkeeping`（uni-app Vue3 + Vite）已归档为只读，不再开发。

## 为什么要重写

| 旧栈痛点 | Flutter 后 |
|---|---|
| `plus.android` 桥接地狱（运行时 Java 实例须 `invoke` 直调） | `file_picker` 插件一行拿字节 |
| `plus.sqlite` **无参数绑定**，所有值手工转义（旧 ADR-5） | drift 编译期生成参数绑定 |
| HBuilderX 手工打包，无 CI | `flutter build apk` + CI 自动化 |
| x86_64 模拟器必然白屏，只能真机 | 官方模拟器可用 |
| 自研 `xlsx.js`（fflate + 手写解码） | `excel` 包 |

## 技术选型

| 关注点 | 选型 |
|---|---|
| 数据库 | **drift** + `drift_flutter`（编译期参数绑定，类型安全） |
| 状态管理 | Riverpod 3 |
| 路由 | go_router |
| 金额 | `int` 分（ADR-2） |
| 主键 | UUID v4，客户端发号（ADR-1） |

## 目录结构

```
lib/
  core/
    db/          drift database / tables / migrations
    utils/       money / id / fingerprint / date
    constants/   preset_categories
  data/
    repositories/
  features/
    ledger/  record/  category/  book/  import/
  app.dart  main.dart
test/
```

## 本地开发

每次开终端先设环境（Windows / Git Bash）：

```bash
export PATH="/d/Download/Flutter/flutter/bin:$PATH"
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
export JAVA_HOME="D:\\Download\\Java\\jdk-17.0.20.1+1"   # 必须是 17，勿用 JDK 25
export ANDROID_HOME="D:\\Download\\Java\\Android"
export ANDROID_SDK_ROOT="D:\\Download\\Java\\Android"
unset CODEBUDDY_SESSION_ID CLAUDE_SESSION_ID   # safe-delete shim 会拦 Dart/Gradle 的临时文件删除
```

常用命令：

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # drift 代码生成
flutter analyze
flutter test
flutter build apk --debug
```

## 迁移进度

见 [`SPEC-flutter-migration.md`](SPEC-flutter-migration.md) 与 [`tasks/todo-flutter.md`](tasks/todo-flutter.md)。

| 阶段 | 内容 | 状态 |
|---|---|---|
| F0 | 环境搭建 | ✅ |
| F1 | 空壳 + 依赖 | 🟨 |
| F2 | core/utils | ⬜ |
| F3 | 数据层（drift schema v1 + repositories） | ⬜ |
| F4 | UI 基础（M1 等价） | ⬜ |
| F5 | 账单导入（M2 等价） | ⬜ |
| F6 | 真机验收 + 文档收尾 | ⬜ |

## 架构红线

- ❌ 手写 SQL 字符串拼接（一律走 drift 生成的参数绑定）
- ❌ 用浮点表示或计算金额（一律 `int` 分）
- ❌ 物理 DELETE 业务数据（一律软删 `deleted_at`）
- ❌ 绕过 `importTransaction()` 直接写 `transactions` 表
