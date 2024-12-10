import 'package:flutter/material.dart';
import 'package:mobile_challenge_traction/src/app/my_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}
