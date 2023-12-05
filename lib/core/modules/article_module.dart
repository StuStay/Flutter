
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../../app/article/presentation/screens/article_details_widget.dart';
import '../../app/article/presentation/screens/article_list_widget.dart';
import '../../injection.dart';
import '../services/navigation_service.dart';

class ArticleModule {
  static RouteFactory get routeFactory => (RouteSettings settings) {
    WidgetBuilder builder;
    switch (settings.name) {
      case 'article/articleList':
        builder = (BuildContext context) => ArticleListWidget();
        var route = MaterialPageRoute<bool>(
            builder: builder, settings: settings);
        return route;
      case 'article/articleDetails':
        builder = (BuildContext context) => const ArticleDetailsWidget();
        var route = MaterialPageRoute<bool>(
            builder: builder, settings: settings);
        return route;
      default:
        throw Exception('Invalid route: ${settings.name}');
    }
  };
}

enum ArticleModuleRoute { articleList , articleDetails}

extension ArticleModuleRouteExtension on ArticleModuleRoute {
  String get name {
    switch (this) {
      case ArticleModuleRoute.articleList:
        return 'article/articleList';

      case ArticleModuleRoute.articleDetails:
        return 'article/articleDetails';
    }
  }

  Future<T?> push<T extends Object?>({Object? args}) =>
      locator<NavigationService>().navigateTo<T>(name, arguments: args);

  Future pushReplacement<T extends Object?>({Object? args}) {
    return locator<NavigationService>()
        .navigateToAndReplace(name, arguments: args);
  }
}
