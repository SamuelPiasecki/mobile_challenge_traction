import 'package:mobile_challenge_traction/src/data/models/asset.dart';
import 'package:mobile_challenge_traction/src/domain/repositories/i_assets_repository.dart';

class ReadAssetsUseCase {
  final IAssetsRepository repository;
  ReadAssetsUseCase({required this.repository});

  Future<List<Asset>> call(String companyId) {
    return repository.readAssets(companyId);
  }
}
