import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_challenge_traction/src/data/http/http_provider.dart';
import 'package:mobile_challenge_traction/src/data/repositories/companies_repository.dart';
import 'package:mobile_challenge_traction/src/domain/repositories/i_companies_repository.dart';
import 'package:mobile_challenge_traction/src/domain/usecases/read_companies_use_case.dart';
import 'package:mobile_challenge_traction/src/providers/home/home_notifier.dart';
import 'package:mobile_challenge_traction/src/providers/home/home_state.dart';

final companiesRepository = Provider<ICompaniesRepository>((ref) {
  final client = ref.read(httpClientProvider);
  return CompaniesRepository(client: client);
});

final readCompaniesUseCase = Provider<ReadCompaniesUseCase>((ref) {
  final repository = ref.read(companiesRepository);
  return ReadCompaniesUseCase(repository: repository);
});

final homeNotifierProvider = StateNotifierProvider<HomeNotifier, HomeState>(
  (ref) {
    return HomeNotifier(readCompaniesUseCase: ref.read(readCompaniesUseCase));
  },
);
