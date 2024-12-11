import 'package:mobile_challenge_traction/src/data/models/asset.dart';

abstract class IAssetsRepository {
  Future<List<Asset>> readAssets(String companyId);
}
