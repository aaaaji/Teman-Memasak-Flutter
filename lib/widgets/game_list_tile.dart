import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../models/game.dart';
import 'game_cover.dart';

class GameListTile extends StatelessWidget {
  const GameListTile({required this.game, required this.onTap, super.key});

  final Game game;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(11),
          child: Row(
            children: [
              SizedBox(
                width: 83,
                height: 86,
                child: GameCover(game: game, height: 86, borderRadius: 13),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      game.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w800,
                        color: AppColors.ink,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${game.genre}  •  ${game.releaseDate.year}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12, color: AppColors.muted),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded,
                            color: AppColors.yellow, size: 17),
                        const SizedBox(width: 3),
                        Text(
                          game.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            color: AppColors.ink,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              const CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.cream,
                child: Icon(Icons.arrow_forward_rounded,
                    color: AppColors.navy, size: 17),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
