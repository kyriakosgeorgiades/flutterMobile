import 'package:flutter/material.dart';
import 'package:georgiadek_sem2_flutter/routes/register_page.dart';
import 'package:georgiadek_sem2_flutter/routes/singleGame_page.dart';


import 'games_page.dart';
import 'home_page.dart';
import 'login_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePageWidget());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginWidget());
      case '/games':
        return MaterialPageRoute(builder: (_) => GamesWidget());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterWidget());
      case '/games/review/':
        return MaterialPageRoute(builder: (_) => SingleGameVeiwWidget());
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
