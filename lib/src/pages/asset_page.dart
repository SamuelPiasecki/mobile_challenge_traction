import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AssetPage extends ConsumerWidget {
  static AssetPage builder(BuildContext context, GoRouterState state) =>
      const AssetPage();

  const AssetPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text("Asset Page"),
      ),
    );
  }
}
