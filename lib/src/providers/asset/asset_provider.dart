import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_challenge_traction/src/data/http/http_provider.dart';
import 'package:mobile_challenge_traction/src/data/repositories/assets_repository.dart';
import 'package:mobile_challenge_traction/src/data/repositories/locations_repository.dart';
import 'package:mobile_challenge_traction/src/domain/repositories/i_assets_repository.dart';
import 'package:mobile_challenge_traction/src/domain/repositories/i_locations_repository.dart';
import 'package:mobile_challenge_traction/src/domain/usecases/read_assets_use_case.dart';
import 'package:mobile_challenge_traction/src/domain/usecases/read_locations_use_case.dart';
import 'package:mobile_challenge_traction/src/providers/asset/asset_notifier.dart';
import 'package:mobile_challenge_traction/src/providers/asset/asset_state.dart';

final locationsRepository = Provider<ILocationsRepository>((ref) {
  final client = ref.read(httpClientProvider);
  return LocationsRepository(client: client);
});

final assetsRepository = Provider<IAssetsRepository>((ref) {
  final client = ref.read(httpClientProvider);
  return AssetsRepository(client: client);
});

final readLocationsUseCase = Provider<ReadLocationsUseCase>((ref) {
  final repository = ref.read(locationsRepository);
  return ReadLocationsUseCase(repository: repository);
});

final readAssetsUseCase = Provider<ReadAssetsUseCase>((ref) {
  final repository = ref.read(assetsRepository);
  return ReadAssetsUseCase(repository: repository);
});

final assetNotifierProvider = StateNotifierProvider<AssetNotifier, AssetState>(
  (ref) {
    return AssetNotifier(
      readLocationsUseCase: ref.read(readLocationsUseCase),
      readAssetsUseCase: ref.read(readAssetsUseCase),
    );
  },
);
