import 'package:flutter/material.dart';
import 'package:flutter_application_1/Utilits/constants/colorconstant.dart';

class StatusItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color iconColor;

  const StatusItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
    this.iconColor = Colors.blueAccent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: iconColor, size: 28),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Colorconstants.primarygrey,
          ),
        ),
      ],
    );
  }
}
