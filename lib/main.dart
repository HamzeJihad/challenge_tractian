import 'package:flutter/material.dart';
import 'package:flutter_tractian/core/dependency_injection/service_locator.dart';
import 'package:flutter_tractian/core/routers/tree_routers.dart';
import 'package:flutter_tractian/core/theme/theme_default.dart';
import 'package:go_router/go_router.dart';

void main() {
  init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
    initialLocation: TreeRouters.HOME_PAGE,
    routes: [...TreeRoutersPage.router],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Challenge Tractian',
      theme: ThemeDefault.themeData,
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
