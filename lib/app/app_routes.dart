import 'package:insurance_seguradora/presenter/pages/home/home_page.dart';
import 'package:insurance_seguradora/presenter/pages/login/login_page.dart';
import 'package:insurance_seguradora/presenter/pages/register/register_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Rota não encontrada')),
          ),
        );
    }
  }
}
