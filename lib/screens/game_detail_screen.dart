import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../models/game.dart';
import '../widgets/game_cover.dart';

class GameDetailScreen extends StatelessWidget {
  const GameDetailScreen({required this.game, super.key});

  final Game game;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: ListView(
              children: [
                Stack(
                  children: [
                    GameCover(
                      game: game,
                      height: 288,
                      borderRadius: 0,
                      showTitle: true,
                    ),
                    Positioned(
                      left: 17,
                      top: 17,
                      child: Material(
                        color: AppColors.navy.withOpacity(.75),
                        shape: const CircleBorder(),
                        child: IconButton(
                          tooltip: 'Kembali',
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back_rounded,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 23, 20, 35),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(game.title,
                                    style: const TextStyle(
                                      fontSize: 25,
                                      height: 1.15,
                                      fontWeight: FontWeight.w900,
                                      color: AppColors.ink,
                                    )),
                                const SizedBox(height: 7),
                                Text('${game.genre}  •  ${game.formattedReleaseDate}',
                                    style: const TextStyle(
                                      fontSize: 12, color: AppColors.muted,
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 9,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.cream,
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.star_rounded,
                                    color: Color(0xFFE6A008), size: 21),
                                const SizedBox(width: 4),
                                Text(game.rating.toStringAsFixed(1),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 19),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ...game.platforms.map((p) => _InfoTag(label: p)),
                          ...game.tags.take(2).map((tag) => _InfoTag(label: tag)),
                        ],
                      ),
                      const SizedBox(height: 27),
                      const _Subtitle('Tentang game'),
                      const SizedBox(height: 10),
                      Text(
                        game.description,
                        style: const TextStyle(
                          color: Color(0xFF5A6A70),
                          height: 1.65,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 26),
                      const _Subtitle('Minimum system requirements'),
                      const SizedBox(height: 13),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.fromLTRB(17, 7, 17, 7),
                        child: Column(
                          children: [
                            _SpecRow('OS', game.requirements.os),
                            _SpecRow('Processor', game.requirements.processor),
                            _SpecRow('Memory', game.requirements.memory),
                            _SpecRow('Graphics', game.requirements.graphics),
                            _SpecRow('Storage', game.requirements.storage,
                                hasDivider: false),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      const _Subtitle('Sampul game'),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: GameCover(game: game, height: 138),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: GameCover(game: game, height: 138,
                                showTitle: true),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      const Row(
                        children: [
                          Icon(Icons.info_outline_rounded,
                              size: 17, color: AppColors.muted),
                          SizedBox(width: 7),
                          Expanded(
                            child: Text(
                              'Gambar sampul berasal dari CDN Steam (memerlukan internet). '
                              'Rating, popularitas, dan spesifikasi bersifat data dummy untuk tugas.',
                              style: TextStyle(
                                  color: AppColors.muted, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ],
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

class _Subtitle extends StatelessWidget {
  const _Subtitle(this.title);
  final String title;

  @override
  Widget build(BuildContext context) => Text(title,
      style: const TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 19,
        color: AppColors.ink,
      ));
}

class _InfoTag extends StatelessWidget {
  const _InfoTag({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.cream,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(label,
            style: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.w700,
                color: AppColors.navy)),
      );
}

class _SpecRow extends StatelessWidget {
  const _SpecRow(this.label, this.value, {this.hasDivider = true});
  final String label;
  final String value;
  final bool hasDivider;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
          border: hasDivider
              ? const Border(bottom: BorderSide(color: AppColors.line))
              : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: Text(label,
                  style: const TextStyle(
                    color: AppColors.muted,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  )),
            ),
            Expanded(
              child: Text(value,
                  style: const TextStyle(
                    color: AppColors.ink,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  )),
            ),
          ],
        ),
      );
}
