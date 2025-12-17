import 'package:flutter/material.dart';

class WelcomeTitleSection extends StatelessWidget {
  const WelcomeTitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Column(
        children: [
          Text(
            "Explora el Universo",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 250, 209, 209),
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 12),
          Text(
            "Únete a miles de astrónomos y comienza tu viaje por las estrellas hoy mismo.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF93adc8), // Color secundario texto oscuro
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}