# 迁移任务清单（Flutter）

> 配套 `SPEC-flutter-migration.md`（**未签字前不许开工**）
> 每步：实现 → 测试门禁 → 勾选 → 再进下一步

## F0 环境搭建 ✅ 已完成（2026-09-09）

- [x] Flutter 3.47.2 → `D:\Download\Flutter\flutter`（Dart 3.13.2）
- [x] JDK 17.0.20.1+1 → `D:\Download\Java\jdk-17.0.20.1+1`，已 `flutter config --jdk-dir`
- [x] cmdline-tools → `D:\Download\Java\Android\cmdline-tools\latest`
- [x] `flutter doctor --android-licenses` 已全部接受
- [x] 门禁：`flutter doctor` → Flutter ✅ / Android toolchain ✅ / Network ✅；残留告警均为 Windows桌面、web、wmic 沙箱拦截，与 Android 无关
- [x] 真机：Redmi K50 无线 adb 可见
- [ ] 清理 `D:\Tencent\yanxin-flutter\_sdk`（2.1GB 临时 zip，F1 后删）

## F1 空壳 + 依赖（进行中）

- [x] `flutter create --platforms=android --org com.teacodeman --project-name yanxin .`
- [x] 锁定依赖版本（pub API 实测）：drift 2.34.4 / drift_flutter 0.3.1 / drift_dev 2.34.6 / build_runner 2.16.1 / flutter_riverpod 3.4.3 / go_router 18.0.1 / uuid 4.6.0 / path 1.9.1
- [ ] `flutter pub get` 通过
- [ ] `analysis_options.yaml` 收紧 lint
- [ ] lib 目录骨架 + 空白首页
- [ ] git init + 首次提交 + 远端（远端仓库需用户手动建）
- [ ] 门禁：`flutter analyze` 0 issue + `flutter build apk --debug` 成功

> **坑**：`flutter pub add` 在本机会卡死 15min+ 无输出（疑似 pub 解析器背板），改用「手查版本写 pubspec + `flutter pub get`」。
> F5 再装：excel / csv / gbk_codec / file_picker

## F2 core/utils

- [ ] `money.dart`（整数分，格式化/解析）
- [ ] `id.dart`（UUID v4）
- [ ] `fingerprint.dart`（入账指纹算法，与旧版一致）
- [ ] `date.dart`（月份边界、月初月末）
- [ ] 门禁：移植 money/id/fingerprint/date 全部用例

## F3 数据层

- [ ] drift tables：books / accounts / categories / transactions（DDL 对齐 schema v1）
- [ ] 唯一索引 `idx_tx_fingerprint`（部分索引，deleted_at IS NULL）
- [ ] migration v0→v1
- [ ] repositories：book / account / category / transaction
- [ ] `importTransaction()` 指纹幂等入账
- [ ] 门禁：移植 db + repositories 用例（软删、指纹唯一、迁移、账本隔离）

## F4 UI 基础（M1 等价）

- [ ] 首页：hero（月切换 ‹ ›，canNext 不超前当前月）+ 流水列表
- [ ] 记一笔：金额键盘 + 分类选择 + 备注 + 时间
- [ ] 分类管理 / 账本管理
- [ ] 门禁：M1 等价验收 8 项（真机）

## F5 账单导入（M2 等价）

- [ ] `gbk_codec` 验证（**第一步**，失败立刻换 charset_converter）
- [ ] CSV 解析 + 微信/支付宝 profiles 别名
- [ ] xlsx 解析（excel 包）+ Excel 序列号时间列换算
- [ ] categorize 关键词规则
- [ ] importer：单事务 + 指纹去重
- [ ] 导入页 UI（选文件 → 预览 → 可取消单条 → 确认导入）
- [ ] 门禁：移植 bill-import 用例 + **真实件对拍，与旧版逐行一致**

## F6 验收收尾

- [ ] M2 等价验收 8 项（真机）
- [ ] README / CHANGELOG / HANDOFF 建立
- [ ] 旧仓库 README 顶部加「已迁移至 yanxin-flutter」说明
