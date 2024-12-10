import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_challenge_traction/src/config/routes/routes_provider.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routeConfig = ref.watch(routesProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: routeConfig,
    );
  }
}
