// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:bayad_test/model/data_model.dart' as _i5;
import 'package:bayad_test/movie_data_screen.dart' as _i1;
import 'package:bayad_test/movie_list_screen.dart' as _i2;
import 'package:flutter/material.dart' as _i4;

abstract class $AppRouter extends _i3.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    MovieDataScreen.name: (routeData) {
      final args = routeData.argsAs<MovieDataScreenArgs>();
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.MovieDataScreen(
          key: args.key,
          model: args.model,
        ),
      );
    },
    MovieListScreen.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.MovieListScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.MovieDataScreen]
class MovieDataScreen extends _i3.PageRouteInfo<MovieDataScreenArgs> {
  MovieDataScreen({
    _i4.Key? key,
    required _i5.DataModel model,
    List<_i3.PageRouteInfo>? children,
  }) : super(
          MovieDataScreen.name,
          args: MovieDataScreenArgs(
            key: key,
            model: model,
          ),
          initialChildren: children,
        );

  static const String name = 'MovieDataScreen';

  static const _i3.PageInfo<MovieDataScreenArgs> page =
      _i3.PageInfo<MovieDataScreenArgs>(name);
}

class MovieDataScreenArgs {
  const MovieDataScreenArgs({
    this.key,
    required this.model,
  });

  final _i4.Key? key;

  final _i5.DataModel model;

  @override
  String toString() {
    return 'MovieDataScreenArgs{key: $key, model: $model}';
  }
}

/// generated route for
/// [_i2.MovieListScreen]
class MovieListScreen extends _i3.PageRouteInfo<void> {
  const MovieListScreen({List<_i3.PageRouteInfo>? children})
      : super(
          MovieListScreen.name,
          initialChildren: children,
        );

  static const String name = 'MovieListScreen';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}
