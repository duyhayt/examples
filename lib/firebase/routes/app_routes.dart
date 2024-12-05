import 'package:auto_route/auto_route.dart';
import 'package:testkey/firebase/routes/app_routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: DemoFirebaseRoute.page, 
          initial: true),
        AutoRoute(page: FirstRoute.page),
        AutoRoute(page: SecondRoute.page),
        AutoRoute(page: ThirdRoute.page),
      ];
}
