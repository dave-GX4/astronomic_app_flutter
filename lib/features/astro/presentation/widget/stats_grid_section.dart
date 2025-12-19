import 'package:app_rest/features/astro/domain/entities/planent.dart';
import 'package:flutter/material.dart';

class StatsGridSection extends StatelessWidget {
  final Planet planet;

  const StatsGridSection({super.key, required this.planet});

  @override
  Widget build(BuildContext context) {
    final cardWidth = (MediaQuery.of(context).size.width - 40 - 24) / 3;

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _buildStatItem("Radio", "${planet.radius} km", Icons.straighten, cardWidth),
        _buildStatItem("Gravedad", "${planet.gravity} m/s²", Icons.arrow_downward, cardWidth),
        _buildStatItem("Día", "${planet.dayLength} h", Icons.schedule, cardWidth),
        _buildStatItem("Lunas", "${planet.moonCount}", Icons.nights_stay, cardWidth),
        _buildStatItem("Temp.", "${planet.temperature}°C", Icons.thermostat, cardWidth),
        _buildStatItem("Categoría", planet.category, Icons.category, cardWidth),
      ],
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, double width) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Color(0xFF1A2230),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF2A3445)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Color(0xFF135bec)),
          SizedBox(height: 6),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              color: Colors.grey,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}