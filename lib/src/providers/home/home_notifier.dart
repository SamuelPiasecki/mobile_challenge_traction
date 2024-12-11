import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_challenge_traction/src/data/models/company.dart';
import 'package:mobile_challenge_traction/src/domain/usecases/read_companies_use_case.dart';
import 'package:mobile_challenge_traction/src/providers/home/home_state.dart';

class HomeNotifier extends StateNotifier<HomeState> {
  final ReadCompaniesUseCase readCompaniesUseCase;
  HomeNotifier({required this.readCompaniesUseCase}) : super(HomeState()) {
    readCompanies();
  }

  void readCompanies() async {
    state = HomeState(isLoading: true);
    try {
      List<Company> companies = await readCompaniesUseCase();
      state = HomeState(isLoading: false, companies: companies);
    } catch (e) {
      state = HomeState(isLoading: false, error: e.toString());
    }
  }
}
