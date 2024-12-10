import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_challenge_traction/src/config/routes/app_routes.dart';
import 'package:mobile_challenge_traction/src/config/routes/route_location.dart';

final routesProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      initialLocation: RouteLocation.home,
      navigatorKey: navigationKey,
      routes: appRoutes,
    );
  },
);
