import 'dart:convert';

import 'package:mobile_challenge_traction/src/data/http/exceptions.dart';
import 'package:mobile_challenge_traction/src/data/http/http_client.dart';
import 'package:mobile_challenge_traction/src/data/models/asset.dart';
import 'package:mobile_challenge_traction/src/domain/repositories/i_assets_repository.dart';

class AssetsRepository extends IAssetsRepository {
  final IHttpClient client;

  AssetsRepository({required this.client});

  @override
  Future<List<Asset>> readAssets(String companyId) async {
    final response = await client.get(
      url: 'https://fake-api.tractian.com/companies/$companyId/assets',
    );

    if (response.statusCode == 200) {
      final List<Asset> assets = [];

      final body = jsonDecode(response.body);

      body.map((item) {
        final Asset asset = Asset.fromMap(item);
        assets.add(asset);
      }).toList();

      return assets;
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não é válida");
    } else {
      throw Exception("Não foi possível carregar os assets");
    }
  }
}
