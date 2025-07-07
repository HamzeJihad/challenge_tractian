import 'package:flutter_tractian/features/presentation/pages/home_page.dart';
import 'package:flutter_tractian/features/presentation/pages/assets_tree_page.dart';
import 'package:go_router/go_router.dart';

class TreeRouters {
  static const String HOME_PAGE = '/';
  static const String ASSETS_TREE_PAGE = '/assets/:companyId';
}

class TreeRoutersPage {
  TreeRoutersPage._();

  static final List<GoRoute> router = [
    GoRoute(
      path: TreeRouters.HOME_PAGE,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: TreeRouters.ASSETS_TREE_PAGE,
      builder: (context, state) {
        final companyId = state.pathParameters['companyId']!;
        return AssetsTreePage(companyId: companyId);
      },
    ),
  ];
}
