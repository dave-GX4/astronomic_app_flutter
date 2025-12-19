import 'package:app_rest/core/router/routes.dart';
import 'package:app_rest/features/astro/domain/entities/celestial_body.dart';
import 'package:app_rest/features/astro/domain/entities/moon.dart';
import 'package:app_rest/features/astro/domain/entities/planent.dart';
import 'package:app_rest/features/astro/presentation/providers/home_provider.dart';
import 'package:app_rest/features/astro/presentation/widget/categories_section.dart';
import 'package:app_rest/features/astro/presentation/widget/celestial_card.dart';
import 'package:app_rest/features/astro/presentation/widget/feature_section.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchActive = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().loadHomeData();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _startSearch() {
    setState(() {
      _isSearchActive = true;
    });
  }

  void _stopSearch() {
    final provider = context.read<HomeProvider>();
    setState(() {
      _isSearchActive = false;
      _searchController.clear();
      provider.searchPlanets('');
    });
  }

  @override
  Widget build(BuildContext context) {
    final providerWatch = context.watch<HomeProvider>();
    final providerRead = context.read<HomeProvider>();

    if (providerWatch.isLoading) {
      return Scaffold(
        backgroundColor: Color(0xFF101622),
        body: Center(child: CircularProgressIndicator(color: Color(0xFF135bec))),
      );
    }

    if (providerWatch.errorMessage != null) {
      return Scaffold(
        backgroundColor: Color(0xFF101622),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, color: Colors.red, size: 40),
              SizedBox(height: 16),
              Text(
                providerWatch.errorMessage!,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF135bec)),
                onPressed: () => providerRead.loadHomeData(),
                child: Text("Reintentar", style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFF101622),
      appBar: _buildAppBar(providerRead),
      body: SafeArea(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            if (!_isSearchActive && providerWatch.featuredPlanet != null)
              SliverToBoxAdapter(
                child: FeaturedSection(planet: providerWatch.featuredPlanet!),
              ),

            SliverToBoxAdapter(
              child: CategoriesSection(),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  _isSearchActive 
                      ? "Resultados (${providerWatch.filteredItems.length})" 
                      : (providerWatch.selectedCategory == 'Todos' 
                          ? "Explora el Cosmos" 
                          : providerWatch.selectedCategory),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            providerWatch.filteredItems.isEmpty
                ? SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(40),
                      child: Column(
                        children: [
                          Icon(Icons.search_off, size: 50, color: Colors.grey),
                          SizedBox(height: 10),
                          Text(
                            "No se encontraron resultados",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final CelestialBody item = providerWatch.filteredItems[index];

                        String subtitle = item.category;
                        
                        if (item is Planet) {
                          subtitle = item.typePlanet;
                        } else if (item is Moon) {
                          subtitle = "Luna de ${item.planetOrbit}";
                        }

                        return Padding(
                          padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 24.0),
                          child: CelestialCard(
                            id: item.id,
                            title: item.name,
                            subtitle: subtitle,
                            description: item.description,
                            rating: "4.9",
                            imageUrl: item.image,
                          ),
                        );
                      },
                      childCount: providerWatch.filteredItems.length,
                    ),
                  ),

            SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(HomeProvider providerRead) {
    return AppBar(
      backgroundColor: Color(0xFF101622),
      elevation: 0,
      leading: _isSearchActive
          ? IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: _stopSearch,
            )
          : null,
      title: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0.2, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: _isSearchActive
            ? _buildSearchField(providerRead)
            : Text(
                'Explora el cosmos',
                key: ValueKey('Title'),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
      ),
      actions: [
        if (_isSearchActive)
          IconButton(
            icon: Icon(Icons.close, color: Colors.white),
            onPressed: () {
              if (_searchController.text.isEmpty) {
                _stopSearch();
              } else {
                _searchController.clear();
                providerRead.searchPlanets('');
              }
            },
          )
        else ...[
          IconButton(
            onPressed: _startSearch,
            icon: Icon(Icons.search_rounded, color: Colors.white),
          ),
          IconButton(
            onPressed: () {
              context.pushNamed(Routes.profile);
            },
            icon: Icon(Icons.person, color: Colors.white),
          )
        ]
      ],
    );
  }

  Widget _buildSearchField(HomeProvider provider) {
    return TextField(
      key: ValueKey('SearchField'),
      controller: _searchController,
      autofocus: true,
      style: TextStyle(color: Colors.white, fontSize: 18),
      cursorColor: Color(0xFF135bec),
      decoration: InputDecoration(
        hintText: "Buscar planeta, luna...",
        hintStyle: TextStyle(color: Colors.white54),
        border: InputBorder.none,
      ),
      onChanged: (value) {
        provider.searchPlanets(value);
      },
    );
  }
}