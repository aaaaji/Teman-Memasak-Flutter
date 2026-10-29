import 'package:flutter/material.dart';

import 'data/recipe_repository.dart';
import 'models/recipe.dart';
import 'screens/detail_screen.dart';
import 'screens/explore_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/home_screen.dart';
import 'theme/app_palette.dart';

class TemanMemasakApp extends StatefulWidget {
  const TemanMemasakApp({super.key});

  @override
  State<TemanMemasakApp> createState() => _TemanMemasakAppState();
}

class _TemanMemasakAppState extends State<TemanMemasakApp> {
  late Future<List<Recipe>> _recipeFuture;
  final ValueNotifier<Set<String>> _favorites = ValueNotifier(<String>{});

  @override
  void initState() {
    super.initState();
    _recipeFuture = const RecipeRepository().loadRecipes();
  }

  @override
  void dispose() {
    _favorites.dispose();
    super.dispose();
  }

  void _toggleFavorite(String recipeId) {
    final updated = <String>{..._favorites.value};
    if (updated.contains(recipeId)) {
      updated.remove(recipeId);
    } else {
      updated.add(recipeId);
    }
    _favorites.value = updated;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Teman Memasak',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppPalette.primary),
        scaffoldBackgroundColor: AppPalette.background,
        textTheme: ThemeData.light().textTheme.apply(
              bodyColor: AppPalette.ink,
              displayColor: AppPalette.ink,
            ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppPalette.background,
          surfaceTintColor: Colors.transparent,
          foregroundColor: AppPalette.ink,
          elevation: 0,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: AppPalette.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
      ),
      home: FutureBuilder<List<Recipe>>(
        future: _recipeFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator(color: AppPalette.primary)),
            );
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error_outline_rounded, size: 48, color: AppPalette.primary),
                      const SizedBox(height: 12),
                      const Text('Resep belum berhasil dimuat.'),
                      const SizedBox(height: 12),
                      FilledButton(
                        onPressed: () => setState(() {
                          _recipeFuture = const RecipeRepository().loadRecipes();
                        }),
                        child: const Text('Coba lagi'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return MainShell(
            recipes: snapshot.data!,
            favorites: _favorites,
            onFavoriteToggle: _toggleFavorite,
          );
        },
      ),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({
    super.key,
    required this.recipes,
    required this.favorites,
    required this.onFavoriteToggle,
  });

  final List<Recipe> recipes;
  final ValueNotifier<Set<String>> favorites;
  final ValueChanged<String> onFavoriteToggle;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;
  String _browseCategory = 'Semua';
  String _browseQuery = '';
  int _browseVersion = 0;

  void _openExplore(String category, String query) {
    setState(() {
      _browseCategory = category;
      _browseQuery = query;
      _browseVersion++;
      _selectedIndex = 1;
    });
  }

  void _openRecipe(Recipe recipe) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => DetailScreen(
          recipe: recipe,
          favorites: widget.favorites,
          onFavoriteToggle: widget.onFavoriteToggle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomeScreen(
            recipes: widget.recipes,
            favorites: widget.favorites,
            onFavoriteToggle: widget.onFavoriteToggle,
            onRecipeTap: _openRecipe,
            onExplore: _openExplore,
          ),
          ExploreScreen(
            key: ValueKey(_browseVersion),
            recipes: widget.recipes,
            initialCategory: _browseCategory,
            initialQuery: _browseQuery,
            favorites: widget.favorites,
            onFavoriteToggle: widget.onFavoriteToggle,
            onRecipeTap: _openRecipe,
          ),
          FavoritesScreen(
            recipes: widget.recipes,
            favorites: widget.favorites,
            onFavoriteToggle: widget.onFavoriteToggle,
            onRecipeTap: _openRecipe,
            onExplore: () => _openExplore('Semua', ''),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: AppPalette.line)),
        ),
        child: NavigationBar(
          backgroundColor: Colors.white,
          indicatorColor: AppPalette.peach,
          surfaceTintColor: Colors.transparent,
          selectedIndex: _selectedIndex,
          height: 74,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          onDestinationSelected: (index) => setState(() => _selectedIndex = index),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home_rounded, color: AppPalette.primary),
              label: 'Beranda',
            ),
            NavigationDestination(
              icon: Icon(Icons.menu_book_outlined),
              selectedIcon: Icon(Icons.menu_book_rounded, color: AppPalette.primary),
              label: 'Jelajahi',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_border_rounded),
              selectedIcon: Icon(Icons.favorite_rounded, color: AppPalette.primary),
              label: 'Favorit',
            ),
          ],
        ),
      ),
    );
  }
}
