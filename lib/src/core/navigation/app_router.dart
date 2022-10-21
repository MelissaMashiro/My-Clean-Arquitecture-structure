import 'package:clean_arquitecture_project/src/core/core.dart';
import 'package:clean_arquitecture_project/src/presentation/features/soccerboard/soccerboard_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static RouteFactory get generatedRoutes => (RouteSettings settings) {
        ModalRoute? route;

        var argumentsMap = settings.arguments as Map<String, dynamic>?;

        switch (settings.name) {
          case NamedRoute.soccerboardHome:
            route = MaterialPageRoute(
              builder: (_) => const SoccerBoardScreen(),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
            break;
        }

        return route;
      };
}
