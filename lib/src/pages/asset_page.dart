import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AssetPage extends ConsumerWidget {
  final String companyId;

  static AssetPage builder(BuildContext context, GoRouterState state) {
    final companyId = state.extra as String;
    return AssetPage(
      companyId: companyId,
    );
  }

  const AssetPage({super.key, required this.companyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assets'),
        centerTitle: true,
      ),
      body: Center(
        child: Text("Asset Page: $companyId"),
      ),
    );
  }
}
