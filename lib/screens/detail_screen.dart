import 'package:flutter/material.dart';

import '../models/recipe.dart';
import '../theme/app_palette.dart';
import '../widgets/recipe_widgets.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.recipe,
    required this.favorites,
    required this.onFavoriteToggle,
  });

  final Recipe recipe;
  final ValueNotifier<Set<String>> favorites;
  final ValueChanged<String> onFavoriteToggle;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final Set<int> _checkedIngredients = <int>{};

  @override
  Widget build(BuildContext context) {
    final recipe = widget.recipe;
    return Scaffold(
      backgroundColor: AppPalette.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 285,
            backgroundColor: AppPalette.background,
            surfaceTintColor: Colors.transparent,
            title: const Text('Detail Resep', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: FavoriteButton(
                  recipe: recipe,
                  favorites: widget.favorites,
                  onToggle: widget.onFavoriteToggle,
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: RecipeArtwork(
                recipe: recipe,
                height: 285,
                borderRadius: 0,
                emojiSize: 113,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 760),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(21, 23, 21, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
                            decoration: BoxDecoration(
                              color: AppPalette.peach,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              recipe.category,
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppPalette.primaryDark),
                            ),
                          ),
                          const Spacer(),
                          const Icon(Icons.star_rounded, color: Color(0xFFFFB94B), size: 19),
                          const SizedBox(width: 3),
                          Text('${recipe.rating.toStringAsFixed(1)} (contoh)',
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        recipe.title,
                        style: const TextStyle(fontSize: 29, height: 1.15, fontWeight: FontWeight.w900, color: AppPalette.ink),
                      ),
                      const SizedBox(height: 9),
                      Text(recipe.description,
                          style: const TextStyle(fontSize: 14, height: 1.55, color: AppPalette.muted)),
                      const SizedBox(height: 22),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          _InfoPill(icon: Icons.schedule_rounded, label: '${recipe.durationMinutes} menit'),
                          _InfoPill(icon: Icons.people_alt_outlined, label: '${recipe.servings} porsi'),
                          _InfoPill(icon: Icons.local_fire_department_outlined, label: recipe.difficulty),
                        ],
                      ),
                      const SizedBox(height: 28),
                      Row(
                        children: [
                          const Expanded(child: _DetailHeading(title: 'Bahan-bahan', icon: Icons.shopping_basket_outlined)),
                          Text(
                            '${_checkedIngredients.length}/${recipe.ingredients.length} siap',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppPalette.primary),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      const Text('Centang bahan yang sudah kamu siapkan.',
                          style: TextStyle(color: AppPalette.muted, fontSize: 12)),
                      const SizedBox(height: 13),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: LinearProgressIndicator(
                          value: recipe.ingredients.isEmpty ? 0 : _checkedIngredients.length / recipe.ingredients.length,
                          backgroundColor: AppPalette.peach,
                          valueColor: const AlwaysStoppedAnimation<Color>(AppPalette.primary),
                          minHeight: 5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppPalette.line),
                        ),
                        child: Column(
                          children: [
                            for (var i = 0; i < recipe.ingredients.length; i++) ...[
                              if (i > 0) const Divider(height: 1, indent: 14, endIndent: 14, color: AppPalette.line),
                              CheckboxListTile(
                                value: _checkedIngredients.contains(i),
                                activeColor: AppPalette.primary,
                                controlAffinity: ListTileControlAffinity.leading,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 11),
                                visualDensity: VisualDensity.compact,
                                title: Text(
                                  recipe.ingredients[i],
                                  style: TextStyle(
                                    fontSize: 13,
                                    height: 1.35,
                                    decoration: _checkedIngredients.contains(i) ? TextDecoration.lineThrough : null,
                                    color: _checkedIngredients.contains(i) ? AppPalette.muted : AppPalette.ink,
                                  ),
                                ),
                                onChanged: (checked) => setState(() {
                                  if (checked == true) {
                                    _checkedIngredients.add(i);
                                  } else {
                                    _checkedIngredients.remove(i);
                                  }
                                }),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 29),
                      const _DetailHeading(title: 'Cara Memasak', icon: Icons.restaurant_menu_rounded),
                      const SizedBox(height: 15),
                      for (var i = 0; i < recipe.steps.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 11),
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: AppPalette.line),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 32,
                                  width: 32,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppPalette.peach,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text('${i + 1}',
                                      style: const TextStyle(color: AppPalette.primaryDark, fontWeight: FontWeight.w900)),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(
                                      recipe.steps[i],
                                      style: const TextStyle(fontSize: 13, height: 1.55, color: AppPalette.ink),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (recipe.tips.isNotEmpty) ...[
                        const SizedBox(height: 15),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: AppPalette.sage,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.lightbulb_outline_rounded, color: Color(0xFF44764B)),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Tips Memasak',
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Color(0xFF315B37))),
                                    const SizedBox(height: 5),
                                    Text(recipe.tips, style: const TextStyle(fontSize: 13, height: 1.55, color: Color(0xFF315B37))),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: 26),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Selamat! Kamu sudah mencoba resep ${recipe.title}. 🎉'),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          icon: const Icon(Icons.check_circle_outline_rounded),
                          label: const Text('Selesai Memasak', style: TextStyle(fontWeight: FontWeight.w800)),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Center(
                        child: Text('Catatan: waktu memasak bersifat perkiraan.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppPalette.muted, fontSize: 11)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailHeading extends StatelessWidget {
  const _DetailHeading({required this.title, required this.icon});
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Icon(icon, size: 23, color: AppPalette.primary),
          const SizedBox(width: 8),
          Text(title,
              style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w900, color: AppPalette.ink)),
        ],
      );
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(color: AppPalette.line),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppPalette.primary, size: 17),
            const SizedBox(width: 7),
            Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
          ],
        ),
      );
}
