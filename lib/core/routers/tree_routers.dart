import 'package:flutter_tractian/features/presentation/pages/home_page.dart';
import 'package:go_router/go_router.dart';

class TreeRouters {
  static const String HOME_PAGE = '/';
}

class TreeRoutersPage {
  TreeRoutersPage._();

  static final List<GoRoute> router = [
    GoRoute(path: TreeRouters.HOME_PAGE, builder: (context, state) => const HomePage()),
  ];
}
