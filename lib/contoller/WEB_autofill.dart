import 'dart:convert';
import 'dart:html' as html;
import 'package:http/http.dart' as http;

class WEB_AutofillController {
  static Future<String?> autofillLocation() async {
    try {
      final position = await html.window.navigator.geolocation.getCurrentPosition();
      final lat = position.coords?.latitude;
      final lon = position.coords?.longitude;

      if (lat != null && lon != null) {
        final response = await http.get(
          Uri.parse('https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=$lat&lon=$lon'),
          headers: {'User-Agent': 'FlutterWebApp'},
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final address = data['address'];
          final city = address['city'] ?? address['town'] ?? address['village'] ?? '';
          final state = address['state'] ?? '';
          final pincode = address['postcode'] ?? '';
          return '$city, $state - $pincode';
        }
      }
    } catch (e) {
      print("Web Autofill Error: $e");
    }
    return null;
  }
}
