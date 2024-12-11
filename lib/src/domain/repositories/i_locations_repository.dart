import 'package:mobile_challenge_traction/src/data/models/location.dart';

abstract class ILocationsRepository {
  Future<List<Location>> readLocations(String companyId);
}
