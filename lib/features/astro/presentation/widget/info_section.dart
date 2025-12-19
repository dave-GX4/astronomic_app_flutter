import 'package:flutter/material.dart';

class InfoSection extends StatelessWidget {
  final String description;

  const InfoSection({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.info_outline, color: Color(0xFF135bec), size: 20),
            SizedBox(width: 8),
            Text(
              "Información",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          description,
          style: TextStyle(
            color: Color(0xFFcbd5e1),
            fontSize: 15,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}