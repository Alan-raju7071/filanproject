import 'dart:convert';



import 'package:http/http.dart' as http;
import 'package:location/location.dart';







class AutofillController {
  static Future<String?> autofillLocation() async {
    try {
      final location = Location();
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) return null;
      }

      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) return null;
      }

      final locData = await location.getLocation();
      final response = await http.get(
        Uri.parse('https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=${locData.latitude}&lon=${locData.longitude}'),
        headers: {'User-Agent': 'FlutterApp'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final address = data['address'];
        final city = address['city'] ?? address['town'] ?? address['village'] ?? '';
        final state = address['state'] ?? '';
        final pincode = address['postcode'] ?? '';
        return '$city, $state - $pincode';
      }
    } catch (e) {
      print("Mobile Autofill Error: $e");
    }

    return null;
  }
}

