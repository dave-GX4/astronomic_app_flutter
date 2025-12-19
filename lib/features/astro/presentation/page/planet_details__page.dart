import 'package:app_rest/features/astro/presentation/providers/planet_details_provider.dart';
import 'package:app_rest/features/astro/presentation/widget/action_buttons_section.dart';
import 'package:app_rest/features/astro/presentation/widget/info_section.dart';
import 'package:app_rest/features/astro/presentation/widget/moons_carousel_section.dart';
import 'package:app_rest/features/astro/presentation/widget/planet_header.dart';
import 'package:app_rest/features/astro/presentation/widget/planet_title_section.dart';
import 'package:app_rest/features/astro/presentation/widget/stats_grid_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui';

class PlanetDetailsPage extends StatefulWidget {
  final String planetId;

  const PlanetDetailsPage({super.key, required this.planetId});

  @override
  State<PlanetDetailsPage> createState() => _PlanetDetailsPageState();
}

class _PlanetDetailsPageState extends State<PlanetDetailsPage> {
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AstroItemProvider>().loadPlanetDetails(widget.planetId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AstroItemProvider>();

    if (provider.isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF101622),
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFF135bec))
        )
      );
    }

    if (provider.errorMessage != null) {
      return Scaffold(
        backgroundColor: Color(0xFF101622),
        body: Center(
          child: Text(
            "Error: ${provider.errorMessage}", 
            style: TextStyle(color: Colors.white)
          )
        )
      );
    }

    final planet = provider.planet;
    if (planet == null) return const SizedBox();

    return Scaffold(
      backgroundColor: Color(0xFF101622),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                PlanetHeader(imageUrl: planet.image),

                Transform.translate(
                  offset: Offset(0, -40),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PlanetTitleSection(planet: planet),
                        SizedBox(height: 24),
                        
                        StatsGridSection(planet: planet),
                        SizedBox(height: 24),
                        
                        InfoSection(description: planet.description),
                        SizedBox(height: 24),
                        
                        MoonsCarouselSection(moons: provider.moons),
                        SizedBox(height: 24),

                        ActionButtonsSection(),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildBlurButton(
                      Icons.arrow_back_ios_new, 
                      () => context.pop(),
                    ),
                    _buildBlurButton(
                      Icons.bookmark_border, 
                      () {
                        // Lógica futura para guardar en favoritos
                      }
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlurButton(IconData icon, VoidCallback onTap) {
    return ClipOval(
      child: Container(
        width: 44,
        height: 44,
        color: Colors.white.withOpacity(0.1),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), 
          child: IconButton(
            icon: Icon(icon, color: Colors.white, size: 20),
            onPressed: onTap,
          ),
        ),
      ),
    );
  }
}