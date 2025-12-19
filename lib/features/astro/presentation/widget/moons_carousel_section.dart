import 'package:app_rest/features/astro/domain/entities/moon.dart';
import 'package:flutter/material.dart';

class MoonsCarouselSection extends StatelessWidget {
  final List<Moon> moons;

  const MoonsCarouselSection({super.key, required this.moons});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            // Mostramos la cantidad si hay lunas
            "Lunas Principales ${moons.isNotEmpty ? '(${moons.length})' : ''}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),

        // LÓGICA PRINCIPAL:
        // Si la lista NO está vacía -> Carrusel
        // Si la lista ESTÁ vacía -> Animación de "Sin resultados"
        if (moons.isNotEmpty)
          _buildCarousel()
        else
          _buildEmptyState(),
      ],
    );
  }

  Widget _buildCarousel() {
    return Column(
      children: [
        if (moons.length > 4)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: const Text("Ver todas", style: TextStyle(color: Color(0xFF135bec))),
            ),
          ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: moons.length,
            itemBuilder: (context, index) {
              final moon = moons[index];
              return _MoonItem(name: moon.name, imageUrl: moon.image);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF192233).withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          // Tu animación personalizada
          _SearchingSatelliteAnimationLoop(),
          
          const SizedBox(height: 16),
          
          const Text(
            "Sin lunas descubiertas",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Por el momento no se han descubierto lunas para este cuerpo celeste.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF92a4c9),
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ANIMACIÓN
class _SearchingSatelliteAnimationLoop extends StatefulWidget {
  @override
  State<_SearchingSatelliteAnimationLoop> createState() => _SearchingSatelliteAnimationLoopState();
}

class _SearchingSatelliteAnimationLoopState extends State<_SearchingSatelliteAnimationLoop> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 5 * _controller.value), 
          child: Opacity(
            opacity: 0.5 + (0.5 * _controller.value), 
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF135bec).withOpacity(0.1),
                border: Border.all(color: const Color(0xFF135bec).withOpacity(0.3)),
              ),
              child: const Icon(
                Icons.travel_explore, // Icono de búsqueda/satélite
                size: 40,
                color: Color(0xFF64b5f6),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ITEM INDIVIDUAL (CARD DE LUNA)
class _MoonItem extends StatelessWidget {
  final String name;
  final String imageUrl;

  const _MoonItem({required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white10, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                )
              ],
            ),
            child: ClipOval(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[800],
                    child: const Icon(Icons.nightlight_round, color: Colors.white54),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 72,
            child: Text(
              name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Color(0xFFcbd5e1),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}