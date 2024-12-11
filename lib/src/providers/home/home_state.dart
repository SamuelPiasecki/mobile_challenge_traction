import 'package:mobile_challenge_traction/src/data/models/company.dart';

class HomeState {
  final bool isLoading;
  final List<Company> companies;
  final String? error;

  HomeState({
    this.isLoading = false,
    this.companies = const [],
    this.error,
  });
}
