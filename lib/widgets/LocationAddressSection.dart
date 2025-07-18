import 'package:flutter/material.dart';
import 'package:flutter_application_1/Utilits/constants/colorconstant.dart';
import 'package:flutter_application_1/Utilits/constants/text_constants.dart';

class LocationAddressSection extends StatelessWidget {
  final TextEditingController locationController;
  final TextEditingController addressController;
  final VoidCallback onDetectLocation;

  const LocationAddressSection({
    required this.locationController,
    required this.addressController,
    required this.onDetectLocation,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(TextConstants.locat, style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TextFormField(
          controller: locationController,
          readOnly: true,
          decoration: InputDecoration(
            labelText: "Your current location",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
          validator: (v) => v == null || v.isEmpty ? 'Unavailable' : null,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: onDetectLocation,
              child: const Text(
                'Re-detect',
                style: TextStyle(color: Colorconstants.primaryblue),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: onDetectLocation,
              icon: const Icon(Icons.my_location, size: 18),
              label: const Text("Detect Location"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colorconstants.primaryblue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                textStyle: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(TextConstants.addres, style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TextFormField(
          controller: addressController,
          decoration: InputDecoration(
            labelText: "Street, Building, etc.",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
          validator: (value) => value == null || value.trim().isEmpty ? 'Please enter your address' : null,
        ),
      ],
    );
  }
}
