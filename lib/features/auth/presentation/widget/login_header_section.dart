import 'package:app_rest/features/auth/presentation/widget/rotating_planet.dart';
import 'package:flutter/material.dart';

class LoginHeaderSection extends StatelessWidget {
  const LoginHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RotatingPlanet(),
        SizedBox(height: 24),
        
        Text(
          "Explora el Cosmos",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
        ),
        
        SizedBox(height: 8),
        
        Text(
          "Ingresa tus credenciales para continuar tu viaje interestelar.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF94a3b8),
            height: 1.5,
          ),
        ),
      ],
    );
  }
}