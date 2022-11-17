import 'package:flutter/material.dart';
import 'package:peliculas/screens/screens.dart';

class AppRoutes {
  static const initialRoute = 'home';

  // static Map<String, Widget Function(BuildContext)> getAppRoutes() {
  //   Map<String, Widget Function(BuildContext)> appRoutes = {};

  //   appRoutes.addAll({'home': (context) => const HomeScreen()});

  //   for (final option in menuOption) {
  //     appRoutes.addAll({option.route: (context) => option.widget});
  //   }

  //   return appRoutes;
  // }

  static Map<String, Widget Function(BuildContext)> routes = {
    'home': (context) => const HomeScreen(),
    'details': (context) => const DetailsScreen(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const HomeScreen(),
    );
  }
}
