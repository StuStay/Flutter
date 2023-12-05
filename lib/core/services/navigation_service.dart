import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class NavigationService {
  final GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  void pop({dynamic args}) {
    _navigationKey.currentState!.pop(args);
  }

  void popUntilFirstRoute() {
    _navigationKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future<T?> navigateTo<T extends Object?>(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<T?> navigateToAndReplace<T extends Object?>(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateToAndPop(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState!
        .popAndPushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> popAllAndNavigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState!.pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => false,
        arguments: arguments);
  }

  Future<dynamic> navigateToAndPopUntil(String routeName, String routeToPop,
      {dynamic arguments}) {
    return _navigationKey.currentState!.pushNamedAndRemoveUntil(
        routeName, ModalRoute.withName(routeToPop),
        arguments: arguments);
  }
}
