import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'core/modules/article_module.dart';


GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

Route<dynamic>? onGenerateRoute(RouteSettings settings) {


  if (settings.name?.startsWith("article/") ?? false) {
    return ArticleModule.routeFactory(settings);
  }



}
