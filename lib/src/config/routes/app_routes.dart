import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_challenge_traction/src/config/routes/route_location.dart';
import 'package:mobile_challenge_traction/src/pages/asset_page.dart';
import 'package:mobile_challenge_traction/src/pages/home_page.dart';

final navigationKey = GlobalKey<NavigatorState>();

final appRoutes = [
  GoRoute(
    path: RouteLocation.home,
    parentNavigatorKey: navigationKey,
    builder: HomePage.builder,
  ),
  GoRoute(
    path: RouteLocation.asset,
    parentNavigatorKey: navigationKey,
    builder: AssetPage.builder,
  ),
];
