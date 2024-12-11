import 'package:mobile_challenge_traction/src/data/models/location.dart';
import 'package:mobile_challenge_traction/src/domain/repositories/i_locations_repository.dart';

class ReadLocationsUseCase {
  final ILocationsRepository repository;

  ReadLocationsUseCase({required this.repository});

  Future<List<Location>> call(String companyId) {
    return repository.readLocations(companyId);
  }
}
