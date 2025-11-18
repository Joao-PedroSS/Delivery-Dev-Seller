import 'dart:convert';
import 'package:http/http.dart' as http;

class GeocodingService {
  static const _baseUrl = "https://nominatim.openstreetmap.org/search";

  Future<({double lat, double lon})?> getCoordinatesFromAddress(String address) async {
    final url = Uri.parse("$_baseUrl?q=$address&format=json&limit=1");

    final response = await http.get(url, headers: {
      "User-Agent": "delivery-dev-seller/1.0 (contact: yourEmail@example.com)"
    });

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      if (data.isNotEmpty) {
        return (
          lat: double.parse(data[0]["lat"]),
          lon: double.parse(data[0]["lon"]),
        );
      }
    }

    return null;
  }
}
