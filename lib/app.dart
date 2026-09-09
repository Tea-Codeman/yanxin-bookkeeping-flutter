import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 应用根：MaterialApp.router + go_router。
///
/// 路由表随 F4（UI 基础）逐步补齐；F1 仅放一个占位首页验证链路。
final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>
          const _PlaceholderPage(title: '颜芯记账'),
    ),
  ],
);

class YanxinApp extends StatelessWidget {
  const YanxinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '颜芯记账',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE91E63)),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

/// F1 占位页：验证「能编译、能起进程、能渲染」。F4 替换为首页流水列表。
class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: const Center(
        child: Text('颜芯记账 · Flutter 迁移中', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
