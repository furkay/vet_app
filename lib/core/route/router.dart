import 'package:flutter/material.dart';
import 'package:vet_app/core/route/routes.dart';
import 'package:vet_app/screens/auth/auth_control_page.dart';
import 'package:vet_app/screens/home/test.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) {
        switch (settings.name) {
          case Routes.controlPage:
            return AuthControl();
          case Routes.homePage:
            return Test();
          default:
            return Scaffold(
              body: Center(child: Text('Sayfa Bulunamadı ${settings.name}')),
            );
        }
      },
    );
  }
}
