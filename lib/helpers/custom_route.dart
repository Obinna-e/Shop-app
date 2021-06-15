import 'package:flutter/material.dart';

class CustomRoute<T> extends MaterialPageRoute<T> {
  CustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(
          builder: builder,
          settings: settings,
        );
  //all this is forwarded to the parent class by using initialiser list ':'
  //then calling super and forwarding builder and settings

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (settings.name == '/') {
      return child; //'/' refers to initial route and return child is page navigating to
    }
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}

/*added pagetransitionbuilder so that I can pass this in main.dart themedata */

class CustomPageTransitionBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (route.settings.name == '/') {
      return child; //'/' refers to initial route and return child is page navigating to
    }
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
//<T> is just added because MaterialPageRoute is a generic class
