import 'package:flutter/material.dart';
import 'package:soytul/src/presentation/sections/settings/settings_view.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
      case "/home":
        return MaterialPageRoute(
          builder: (context) => SettingsView(),
        );
        break;
      default:
        return MaterialPageRoute(
          builder: (context) => SettingsView(),
        );
    }
  }
}
