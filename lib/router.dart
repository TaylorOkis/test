import 'package:flutter/material.dart';
import 'package:todoapp/screens/home_screen.dart';
import 'package:todoapp/screens/login_screen.dart';
import 'package:todoapp/screens/register_screen.dart';
import 'package:todoapp/wrapper.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name) {
      case '/wrapper':
        return MaterialPageRoute(builder: (_) => const Wrapper());
      case '/login_screen':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/register_screen':
        return MaterialPageRoute(builder: (_) => const RegistrationScreen());
      case '/home_screen':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
            title: const Text('Error'),
            centerTitle: true,
        ),
        body: const Center(
          child: Text('Page not found!'),
        )
      );
    });
  }
}