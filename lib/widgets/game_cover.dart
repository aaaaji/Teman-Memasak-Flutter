import 'package:flutter/material.dart';
import '../models/game.dart';

/// Menampilkan cover resmi dari CDN gambar Steam (perlu internet).
/// Dua host disediakan sebagai fallback untuk variasi CDN.
class GameCover extends StatelessWidget {
  const GameCover({
    required this.game,
    this.height = 140,
    this.borderRadius = 20,
    this.showTitle = false,
    super.key,
  });

  final Game game;
  final double height;
  final double borderRadius;
  final bool showTitle;

  @override
  Widget build(BuildContext context) {
    final alternativeUrl =
        'https://shared.steamstatic.com/store_item_assets/steam/apps/'
        '${game.steamAppId}/header.jpg';

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              game.coverUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return _CoverFallback(game: game, loading: true);
              },
              errorBuilder: (context, error, stackTrace) => Image.network(
                alternativeUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _CoverFallback(game: game),
              ),
            ),
            if (showTitle)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(15, 25, 15, 13),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Color(0xC9000000)],
                    ),
                  ),
                  child: Text(
                    game.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      shadows: [Shadow(blurRadius: 8, color: Colors.black87)],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _CoverFallback extends StatelessWidget {
  const _CoverFallback({required this.game, this.loading = false});
  final Game game;
  final bool loading;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [game.primaryColor, game.secondaryColor],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  loading ? Icons.hourglass_empty_rounded
                      : Icons.sports_esports_rounded,
                  color: Colors.white,
                  size: 30,
                ),
                const SizedBox(height: 6),
                Text(
                  loading ? 'Memuat cover...' : 'Cover tidak tersedia',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
