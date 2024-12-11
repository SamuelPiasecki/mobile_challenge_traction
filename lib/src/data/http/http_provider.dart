import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_challenge_traction/src/data/http/http_client.dart';

final httpClientProvider = Provider<IHttpClient>((ref) {
  return HttpClient();
});
