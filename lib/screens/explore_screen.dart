import 'package:flutter/material.dart';

import '../data/recipe_categories.dart';
import '../models/recipe.dart';
import '../theme/app_palette.dart';
import '../widgets/recipe_widgets.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({
    super.key,
    required this.recipes,
    required this.initialCategory,
    required this.initialQuery,
    required this.favorites,
    required this.onFavoriteToggle,
    required this.onRecipeTap,
  });

  final List<Recipe> recipes;
  final String initialCategory;
  final String initialQuery;
  final ValueNotifier<Set<String>> favorites;
  final ValueChanged<String> onFavoriteToggle;
  final ValueChanged<Recipe> onRecipeTap;

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late TextEditingController _searchController;
  late String _selectedCategory;
  String _sort = 'Rekomendasi';

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
    _searchController = TextEditingController(text: widget.initialQuery);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Recipe> get _filteredRecipes {
    final query = _searchController.text.trim().toLowerCase();
    final filtered = widget.recipes.where((recipe) {
      final matchesCategory = _selectedCategory == 'Semua' || recipe.category == _selectedCategory;
      final matchesQuery = query.isEmpty ||
          recipe.title.toLowerCase().contains(query) ||
          recipe.category.toLowerCase().contains(query) ||
          recipe.description.toLowerCase().contains(query) ||
          recipe.ingredients.any((ingredient) => ingredient.toLowerCase().contains(query));
      return matchesCategory && matchesQuery;
    }).toList();

    if (_sort == 'Tercepat') {
      filtered.sort((a, b) => a.durationMinutes.compareTo(b.durationMinutes));
    } else if (_sort == 'A-Z') {
      filtered.sort((a, b) => a.title.compareTo(b.title));
    } else {
      filtered.sort((a, b) => b.rating.compareTo(a.rating));
    }
    return filtered;
  }

  void _resetFilters() {
    setState(() {
      _selectedCategory = 'Semua';
      _sort = 'Rekomendasi';
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final result = _filteredRecipes;
    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1050),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Jelajahi Resep',
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900, color: AppPalette.ink)),
                const SizedBox(height: 5),
                const Text('Cari inspirasi masakan untuk setiap suasana.',
                    style: TextStyle(fontSize: 13, color: AppPalette.muted)),
                const SizedBox(height: 22),
                TextField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: 'Cari nama, bahan, atau kategori...',
                    hintStyle: const TextStyle(color: AppPalette.muted, fontSize: 13),
                    prefixIcon: const Icon(Icons.search_rounded, color: AppPalette.primary),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            tooltip: 'Hapus pencarian',
                            icon: const Icon(Icons.close_rounded),
                            onPressed: () => setState(() => _searchController.clear()),
                          )
                        : null,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(17),
                      borderSide: const BorderSide(color: AppPalette.line),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(17),
                      borderSide: const BorderSide(color: AppPalette.line),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(17),
                      borderSide: const BorderSide(color: AppPalette.primary, width: 1.5),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                const Text('Kategori',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: AppPalette.ink)),
                const SizedBox(height: 12),
                SizedBox(
                  height: 42,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: recipeCategories.length + 1,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final category = index == 0 ? 'Semua' : recipeCategories[index - 1].name;
                      final selected = category == _selectedCategory;
                      return ChoiceChip(
                        label: Text(category),
                        selected: selected,
                        showCheckmark: false,
                        onSelected: (_) => setState(() => _selectedCategory = category),
                        backgroundColor: Colors.white,
                        selectedColor: AppPalette.peach,
                        side: BorderSide(color: selected ? AppPalette.primary : AppPalette.line),
                        labelStyle: TextStyle(
                          color: selected ? AppPalette.primaryDark : AppPalette.ink,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${result.length} resep ditemukan',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                      ),
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _sort,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppPalette.primary),
                        style: const TextStyle(color: AppPalette.muted, fontSize: 12, fontWeight: FontWeight.w700),
                        items: const [
                          DropdownMenuItem(value: 'Rekomendasi', child: Text('Rekomendasi')),
                          DropdownMenuItem(value: 'Tercepat', child: Text('Tercepat')),
                          DropdownMenuItem(value: 'A-Z', child: Text('A-Z')),
                        ],
                        onChanged: (value) {
                          if (value != null) setState(() => _sort = value);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                if (result.isEmpty)
                  _EmptySearch(onReset: _resetFilters)
                else
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.maxWidth;
                      final columns = width >= 870 ? 4 : width >= 600 ? 3 : width < 340 ? 1 : 2;
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: result.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columns,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          mainAxisExtent: 264,
                        ),
                        itemBuilder: (context, index) {
                          final recipe = result[index];
                          return RecipeTile(
                            recipe: recipe,
                            onTap: () => widget.onRecipeTap(recipe),
                            favorites: widget.favorites,
                            onFavoriteToggle: widget.onFavoriteToggle,
                          );
                        },
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptySearch extends StatelessWidget {
  const _EmptySearch({required this.onReset});
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 44),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            const Text('🔎', style: TextStyle(fontSize: 54)),
            const SizedBox(height: 10),
            const Text('Resep belum ditemukan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
            const SizedBox(height: 7),
            const Text('Coba kata kunci atau kategori lain.',
                style: TextStyle(color: AppPalette.muted), textAlign: TextAlign.center),
            const SizedBox(height: 14),
            OutlinedButton(onPressed: onReset, child: const Text('Atur ulang pencarian')),
          ],
        ),
      );
}
