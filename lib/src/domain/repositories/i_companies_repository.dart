import 'package:mobile_challenge_traction/src/data/models/company.dart';

abstract class ICompaniesRepository {
  Future<List<Company>> readCompanies();
}
