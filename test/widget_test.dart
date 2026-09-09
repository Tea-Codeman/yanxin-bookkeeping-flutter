// 冒烟测试：App 能构建并渲染占位首页。
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:yanxin/app.dart';

void main() {
  testWidgets('应用可启动并显示标题', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: YanxinApp()));

    expect(find.text('颜芯记账'), findsOneWidget);
    expect(find.text('颜芯记账 · Flutter 迁移中'), findsOneWidget);
  });
}
