import 'package:flutter/material.dart';

import '../models/recipe.dart';
import '../theme/app_palette.dart';

class RecipeArtwork extends StatelessWidget {
  const RecipeArtwork({
    super.key,
    required this.recipe,
    this.height = 150,
    this.borderRadius = 20,
    this.emojiSize = 76,
  });

  final Recipe recipe;
  final double height;
  final double borderRadius;
  final double emojiSize;

  @override
  Widget build(BuildContext context) {
    final tint = AppPalette.fromHex(recipe.colorHex);
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SizedBox(
        width: double.infinity,
        height: height,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [tint.withAlpha(191), tint, Color.lerp(tint, Colors.white, 0.28)!],
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: -45,
                right: -24,
                child: _Bubble(size: 145, color: Colors.white.withAlpha(54)),
              ),
              Positioned(
                bottom: -40,
                left: -25,
                child: _Bubble(size: 115, color: Colors.white.withAlpha(43)),
              ),
              Positioned(
                bottom: 12,
                right: 26,
                child: _Bubble(size: 15, color: Colors.white.withAlpha(140)),
              ),
              Container(
                width: emojiSize + 36,
                height: emojiSize + 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withAlpha(87),
                  border: Border.all(color: Colors.white.withAlpha(110), width: 2),
                ),
                child: Text(recipe.emoji, style: TextStyle(fontSize: emojiSize), textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.size, required this.color});
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      );
}

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.recipe,
    required this.favorites,
    required this.onToggle,
    this.backgroundColor = Colors.white,
  });

  final Recipe recipe;
  final ValueNotifier<Set<String>> favorites;
  final ValueChanged<String> onToggle;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Set<String>>(
      valueListenable: favorites,
      builder: (context, ids, _) {
        final isSaved = ids.contains(recipe.id);
        return Material(
          color: backgroundColor,
          shape: const CircleBorder(),
          elevation: 1,
          child: IconButton(
            tooltip: isSaved ? 'Hapus dari favorit' : 'Tambahkan ke favorit',
            onPressed: () => onToggle(recipe.id),
            icon: Icon(isSaved ? Icons.favorite_rounded : Icons.favorite_border_rounded),
            color: isSaved ? AppPalette.primary : AppPalette.ink,
            iconSize: 21,
            constraints: const BoxConstraints(minWidth: 38, minHeight: 38),
            padding: const EdgeInsets.all(7),
          ),
        );
      },
    );
  }
}

class RecipeTile extends StatelessWidget {
  const RecipeTile({
    super.key,
    required this.recipe,
    required this.onTap,
    required this.favorites,
    required this.onFavoriteToggle,
  });

  final Recipe recipe;
  final VoidCallback onTap;
  final ValueNotifier<Set<String>> favorites;
  final ValueChanged<String> onFavoriteToggle;

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
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: AppPalette.line),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  RecipeArtwork(recipe: recipe, height: 137, borderRadius: 19, emojiSize: 56),
                  Positioned(
                    top: 9,
                    right: 9,
                    child: FavoriteButton(
                      recipe: recipe,
                      favorites: favorites,
                      onToggle: onFavoriteToggle,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 11, 12, 11),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipe.category.toUpperCase(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppPalette.primary,
                          fontWeight: FontWeight.w800,
                          fontSize: 10,
                          letterSpacing: 0.65,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        recipe.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppPalette.ink,
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          height: 1.17,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(Icons.schedule_rounded, size: 14, color: AppPalette.muted),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              '${recipe.durationMinutes} menit',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 11, color: AppPalette.muted),
                            ),
                          ),
                          const Spacer(),
                          const Icon(Icons.star_rounded, size: 15, color: Color(0xFFFFB94B)),
                          const SizedBox(width: 2),
                          Text(
                            recipe.rating.toStringAsFixed(1),
                            style: const TextStyle(fontSize: 11, color: AppPalette.muted),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionHeading extends StatelessWidget {
  const SectionHeading({super.key, required this.title, this.subtitle, this.onSeeAll});
  final String title;
  final String? subtitle;
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w900,
                  color: AppPalette.ink,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 3),
                Text(subtitle!, style: const TextStyle(color: AppPalette.muted, fontSize: 13)),
              ],
            ],
          ),
        ),
        if (onSeeAll != null)
          TextButton(
            onPressed: onSeeAll,
            style: TextButton.styleFrom(foregroundColor: AppPalette.primary),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Lihat semua', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                SizedBox(width: 2),
                Icon(Icons.chevron_right_rounded, size: 16),
              ],
            ),
          ),
      ],
    );
  }
}
