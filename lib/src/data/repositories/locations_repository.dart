import 'dart:convert';

import 'package:mobile_challenge_traction/src/data/http/exceptions.dart';
import 'package:mobile_challenge_traction/src/data/http/http_client.dart';
import 'package:mobile_challenge_traction/src/data/models/location.dart';
import 'package:mobile_challenge_traction/src/domain/repositories/i_locations_repository.dart';

class LocationsRepository extends ILocationsRepository {
  final IHttpClient client;

  LocationsRepository({required this.client});

  @override
  Future<List<Location>> readLocations(String companyId) async {
    final response = await client.get(
      url: 'https://fake-api.tractian.com/companies/$companyId/locations',
    );

    if (response.statusCode == 200) {
      final List<Location> locations = [];

      final body = jsonDecode(response.body);

      body.map((item) {
        final Location location = Location.fromMap(item);
        locations.add(location);
      }).toList();

      return locations;
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não é válida");
    } else {
      throw Exception("Não foi possível carregar as localizações");
    }
  }
}
