import 'package:app_rest/core/utils/app_resources.dart';
import 'package:app_rest/features/astro/domain/entities/planent.dart';
import 'package:flutter/material.dart';

class PlanetTitleSection extends StatelessWidget {
  final Planet planet;

  const PlanetTitleSection({super.key, required this.planet});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          planet.name,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.0,
          ),
        ),
        SizedBox(height: 8),
        Text(
          _buildSubtitle(),
          style: TextStyle(
            color: Color(0xFF135bec),
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  String _buildSubtitle() {
    final nameLower = planet.name.toLowerCase();
    
    if (AppResources.solarSystemPlanets.contains(nameLower)) {
      return "${planet.typePlanet} • ${planet.planetNumber}º Planeta del Sol";
    } 
    
    else if (planet.planetNumber == 0) {
      if (AppResources.solarSystemPlanetsLittle.contains(nameLower)){
        return "${planet.typePlanet} • Cuerpo Menor / Enano";
      } else {
        return "${planet.typePlanet} • Sistema Externo";
      }
    }
    
    return "${planet.typePlanet} • Exoplaneta / Externo"; 
  }
}