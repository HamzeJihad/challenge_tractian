import 'package:flutter/material.dart';
import 'package:flutter_tractian/core/routers/tree_routers.dart';
import 'package:flutter_tractian/core/theme/theme_default.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Challenge Tractian',
      theme: ThemeDefault.themeData,
      routerConfig: GoRouter(
        initialLocation: TreeRouters.HOME_PAGE,
        routes: [
          ...TreeRoutersPage.router,
        ],
      ),
    );
  }
}