import 'dart:convert';

import 'package:mobile_challenge_traction/src/data/http/exceptions.dart';
import 'package:mobile_challenge_traction/src/data/http/http_client.dart';
import 'package:mobile_challenge_traction/src/data/models/company.dart';
import 'package:mobile_challenge_traction/src/domain/repositories/i_companies_repository.dart';

class CompaniesRepository extends ICompaniesRepository {
  final IHttpClient client;

  CompaniesRepository({required this.client});

  @override
  Future<List<Company>> readCompanies() async {
    final response = await client.get(
      url: 'https://fake-api.tractian.com/companies',
    );

    if (response.statusCode == 200) {
      final List<Company> companies = [];

      final body = jsonDecode(response.body);

      body.map((item) {
        final Company company = Company.fromMap(item);
        companies.add(company);
      }).toList();

      return companies;
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não é válida");
    } else {
      throw Exception("Não foi possível carregar as companias");
    }
  }
}
