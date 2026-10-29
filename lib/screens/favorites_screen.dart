import 'package:flutter/material.dart';

import '../models/recipe.dart';
import '../theme/app_palette.dart';
import '../widgets/recipe_widgets.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({
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
  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ValueListenableBuilder<Set<String>>(
        valueListenable: favorites,
        builder: (context, ids, _) {
          final saved = recipes.where((recipe) => ids.contains(recipe.id)).toList();
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1050),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Resep Favorit ❤️',
                        style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900, color: AppPalette.ink)),
                    const SizedBox(height: 5),
                    Text(
                      saved.isEmpty ? 'Simpan resep yang ingin kamu coba nanti.' : '${saved.length} resep telah ditandai favorit.',
                      style: const TextStyle(fontSize: 13, color: AppPalette.muted),
                    ),
                    const SizedBox(height: 26),
                    if (saved.isEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 50),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: AppPalette.line),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 110,
                              width: 110,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(color: AppPalette.peach, shape: BoxShape.circle),
                              child: const Text('💌', style: TextStyle(fontSize: 60)),
                            ),
                            const SizedBox(height: 18),
                            const Text('Belum ada resep favorit',
                                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 19)),
                            const SizedBox(height: 9),
                            const Text(
                              'Tekan ikon hati pada resep yang kamu suka. Resep tersebut akan tampil di sini.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: AppPalette.muted, height: 1.5),
                            ),
                            const SizedBox(height: 23),
                            FilledButton.icon(
                              onPressed: onExplore,
                              icon: const Icon(Icons.menu_book_rounded),
                              label: const Text('Jelajahi resep'),
                            ),
                          ],
                        ),
                      )
                    else
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final width = constraints.maxWidth;
                          final columns = width >= 870 ? 4 : width >= 600 ? 3 : width < 340 ? 1 : 2;
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: saved.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: columns,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              mainAxisExtent: 264,
                            ),
                            itemBuilder: (context, index) {
                              final recipe = saved[index];
                              return RecipeTile(
                                recipe: recipe,
                                onTap: () => onRecipeTap(recipe),
                                favorites: favorites,
                                onFavoriteToggle: onFavoriteToggle,
                              );
                            },
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
