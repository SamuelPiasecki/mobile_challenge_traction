import 'package:mobile_challenge_traction/src/data/models/company.dart';
import 'package:mobile_challenge_traction/src/domain/repositories/i_companies_repository.dart';

class ReadCompaniesUseCase {
  final ICompaniesRepository repository;

  ReadCompaniesUseCase({required this.repository});

  Future<List<Company>> call() {
    return repository.readCompanies();
  }
}
