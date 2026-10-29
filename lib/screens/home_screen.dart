import 'package:flutter/material.dart';

import '../data/recipe_categories.dart';
import '../models/recipe.dart';
import '../theme/app_palette.dart';
import '../widgets/recipe_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.recipes,
    required this.favorites,
    required this.onFavoriteToggle,
    required this.onRecipeTap,
    required this.onExplore,
  });

  final List<Recipe> recipes;
  final ValueNotifier<Set<String>> favorites;
  final ValueChanged<String> onFavoriteToggle;
  final ValueChanged<Recipe> onRecipeTap;
  final void Function(String category, String query) onExplore;

  @override
  Widget build(BuildContext context) {
    final popular = recipes.where((recipe) => recipe.isPopular).take(7).toList();
    final featured = recipes.where((recipe) => recipe.isFeatured).toList();
    final today = featured.isNotEmpty ? featured.first : recipes.first;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 28),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1050),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Container(
                        width: 47,
                        height: 47,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppPalette.peach,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text('👩‍🍳', style: TextStyle(fontSize: 27)),
                      ),
                      const SizedBox(width: 11),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Halo, Chef! 👋', style: TextStyle(fontSize: 12, color: AppPalette.muted)),
                            SizedBox(height: 2),
                            Text(
                              'Teman Memasak',
                              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900, color: AppPalette.ink),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: AppPalette.line),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: IconButton(
                          tooltip: 'Cari resep',
                          onPressed: () => onExplore('Semua', ''),
                          icon: const Icon(Icons.search_rounded, color: AppPalette.ink),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 23),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _WelcomeBanner(onExplore: () => onExplore('Semua', '')),
                ),
                const SizedBox(height: 28),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SectionHeading(
                    title: 'Mau masak apa?',
                    subtitle: 'Cari inspirasi sesuai seleramu',
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  height: 115,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.horizontal,
                    itemCount: recipeCategories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final category = recipeCategories[index];
                      return InkWell(
                        borderRadius: BorderRadius.circular(19),
                        onTap: () => onExplore(category.name, ''),
                        child: Container(
                          width: 105,
                          padding: const EdgeInsets.fromLTRB(8, 12, 8, 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: AppPalette.line),
                            borderRadius: BorderRadius.circular(19),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: 57,
                                height: 57,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(color: category.color, shape: BoxShape.circle),
                                child: Text(category.emoji, style: const TextStyle(fontSize: 30)),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                category.name,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 27),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SectionHeading(
                    title: 'Resep populer 🔥',
                    subtitle: 'Ide favorit untuk masak hari ini',
                    onSeeAll: () => onExplore('Semua', ''),
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  height: 264,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: popular.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 13),
                    itemBuilder: (context, index) => SizedBox(
                      width: 202,
                      child: RecipeTile(
                        recipe: popular[index],
                        onTap: () => onRecipeTap(popular[index]),
                        favorites: favorites,
                        onFavoriteToggle: onFavoriteToggle,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 27),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SectionHeading(
                    title: 'Pilihan hari ini ✨',
                    subtitle: 'Satu resep sederhana untuk dicoba',
                  ),
                ),
                const SizedBox(height: 14),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _FeaturedRecipe(recipe: today, onTap: () => onRecipeTap(today)),
                ),
                const SizedBox(height: 24),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: Text(
                    'Resep dan rating pada versi ini adalah data contoh untuk pembelajaran.',
                    style: TextStyle(fontSize: 11, color: AppPalette.muted),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WelcomeBanner extends StatelessWidget {
  const _WelcomeBanner({required this.onExplore});

  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 210),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: const LinearGradient(
          colors: [Color(0xFFE46A49), Color(0xFFC64E35)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            right: -38,
            top: -65,
            child: Container(
              width: 230,
              height: 230,
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withAlpha(26)),
            ),
          ),
          Positioned(
            right: 0,
            bottom: -25,
            child: Text('🍲', style: TextStyle(fontSize: 132, color: Colors.white.withAlpha(204))),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 23, 130, 23),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('MASAK JADI LEBIH SERU',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1.3, color: Color(0xFFFFE7D8))),
                const SizedBox(height: 12),
                const Text(
                  'Ada ide masak\nuntuk hari ini?',
                  style: TextStyle(fontSize: 26, height: 1.12, fontWeight: FontWeight.w900, color: Colors.white),
                ),
                const SizedBox(height: 11),
                const Text('Temukan resep enak, mudah, dan praktis.',
                    style: TextStyle(fontSize: 12, color: Colors.white, height: 1.4)),
                const SizedBox(height: 15),
                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppPalette.primaryDark,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    minimumSize: const Size(0, 39),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: onExplore,
                  icon: const Icon(Icons.search_rounded, size: 18),
                  label: const Text('Cari resep', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeaturedRecipe extends StatelessWidget {
  const _FeaturedRecipe({required this.recipe, required this.onTap});
  final Recipe recipe;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppPalette.line),
            borderRadius: BorderRadius.circular(22),
          ),
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              SizedBox(
                width: 123,
                child: RecipeArtwork(recipe: recipe, height: 128, emojiSize: 52, borderRadius: 17),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(recipe.category.toUpperCase(),
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: AppPalette.primary)),
                    const SizedBox(height: 7),
                    Text(recipe.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 17, height: 1.15, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 8),
                    Text('${recipe.durationMinutes} menit  •  ${recipe.difficulty}',
                        style: const TextStyle(fontSize: 12, color: AppPalette.muted)),
                    const SizedBox(height: 12),
                    const Row(
                      children: [
                        Text('Lihat resep',
                            style: TextStyle(fontWeight: FontWeight.w800, color: AppPalette.primary, fontSize: 12)),
                        Icon(Icons.arrow_forward_rounded, color: AppPalette.primary, size: 16),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
