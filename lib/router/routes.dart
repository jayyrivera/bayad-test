import 'package:auto_route/auto_route.dart';
import 'package:bayad_test/router/routes.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: MovieListScreen.page,
          initial: true,
        ),
        AutoRoute(
          path: '/movie-data-screen',
          page: MovieDataScreen.page,
        ),
      ];
}
