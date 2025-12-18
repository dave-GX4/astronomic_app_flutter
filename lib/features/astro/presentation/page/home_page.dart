import 'package:app_rest/core/router/routes.dart';
import 'package:app_rest/features/astro/presentation/providers/home_provider.dart';
import 'package:app_rest/features/astro/presentation/widget/categories_section.dart';
import 'package:app_rest/features/astro/presentation/widget/celestial_list_section.dart';
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
    final providerRead = context.read<HomeProvider>();

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      providerRead.loadHomeData();
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
    final providerSearch = context.read<HomeProvider>();
    setState(() {
      _isSearchActive = false;
      _searchController.clear();
      providerSearch.searchPlanets('');
    });
  }

  @override
  Widget build(BuildContext context) {
    final providerWatch = context.watch<HomeProvider>();
    final providerRead = context.read<HomeProvider>();

    if (providerWatch.isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (providerWatch.errorMessage != null) {
       return Scaffold(body: Center(child: Text("Error: ${providerWatch.errorMessage}")));
    }if (providerWatch.errorMessage != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(providerWatch.errorMessage!, style: TextStyle(color: Colors.red)),
              ElevatedButton(
                onPressed: () => context.read<HomeProvider>().loadHomeData(),
                child: Text("Reintentar"),
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF101622),
        elevation: 0,
        leading: _isSearchActive ? IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: _stopSearch,
        ) : null,
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
          child: _isSearchActive ? _buildSearchField(providerRead) : Text(
            'Explora el cosmos',
            key: ValueKey('Title'),
            style: TextStyle(
              fontSize: 24, 
              fontWeight: FontWeight.bold, 
              color: Colors.white
            ),
          ),
        ),
        
        actions: [
          if (_isSearchActive)
             IconButton(
              icon: Icon(Icons.close),
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
              icon: Icon(Icons.search_rounded)
            ),
            IconButton(
              onPressed: (){
                context.pushNamed(Routes.profile);
              }, 
              icon: Icon(Icons.person)
            )
          ]
        ],
      ),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _isSearchActive ? "Resultados (${providerWatch.filteredPlanets.length})" : "${providerWatch.selectedCategory}", 
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            providerWatch.filteredPlanets.isEmpty ? SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Center(child: Text("No hay resultados en esta categoría", style: TextStyle(color: Colors.grey))),
              ),
            ) : SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final planet = providerWatch.filteredPlanets[index];
                    return Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 24.0), 
                      child: CelestialCard(
                        title: planet.name,
                        subtitle: planet.typePlanet,
                        description: planet.description,
                        rating: "4.8",
                        imageUrl: planet.image,
                      ),
                    );
                  },
                  childCount: providerWatch.filteredPlanets.length,
                ),
              ),
              
              SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
      ),
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
        hintText: "Buscar planeta, estrella...",
        hintStyle: TextStyle(color: Colors.white54),
        border: InputBorder.none,
      ),
      onChanged: (value) {
        provider.searchPlanets(value);
      },
    );
  }
}