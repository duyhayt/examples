// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:testkey/firebase/main.dart' as _i1;
import 'package:testkey/firebase/pages/first_page.dart' as _i2;
import 'package:testkey/firebase/pages/second_page.dart' as _i3;
import 'package:testkey/firebase/pages/third_page.dart' as _i4;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    DemoFirebaseRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.DemoFirebasePage(),
      );
    },
    FirstRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.FirstPage(),
      );
    },
    SecondRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.SecondPage(),
      );
    },
    ThirdRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.ThirdPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.DemoFirebasePage]
class DemoFirebaseRoute extends _i5.PageRouteInfo<void> {
  const DemoFirebaseRoute({List<_i5.PageRouteInfo>? children})
      : super(
          DemoFirebaseRoute.name,
          initialChildren: children,
        );

  static const String name = 'DemoFirebaseRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i2.FirstPage]
class FirstRoute extends _i5.PageRouteInfo<void> {
  const FirstRoute({List<_i5.PageRouteInfo>? children})
      : super(
          FirstRoute.name,
          initialChildren: children,
        );

  static const String name = 'FirstRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.SecondPage]
class SecondRoute extends _i5.PageRouteInfo<void> {
  const SecondRoute({List<_i5.PageRouteInfo>? children})
      : super(
          SecondRoute.name,
          initialChildren: children,
        );

  static const String name = 'SecondRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i4.ThirdPage]
class ThirdRoute extends _i5.PageRouteInfo<void> {
  const ThirdRoute({List<_i5.PageRouteInfo>? children})
      : super(
          ThirdRoute.name,
          initialChildren: children,
        );

  static const String name = 'ThirdRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}
