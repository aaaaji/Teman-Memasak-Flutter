import 'package:flutter/material.dart';

/// Model terpisah dari tampilan agar kelak mudah menerima data dari API.
class Game {
  const Game({
    required this.id,
    required this.title,
    required this.genre,
    required this.releaseDate,
    required this.description,
    required this.coverUrl,
    required this.steamAppId,
    required this.rating,
    required this.popularity,
    required this.featured,
    required this.platforms,
    required this.tags,
    required this.iconKey,
    required this.primaryColor,
    required this.secondaryColor,
    required this.requirements,
  });

  final String id;
  final String title;
  final String genre;
  final DateTime releaseDate;
  final String description;
  final String coverUrl;
  final int steamAppId;
  final double rating;
  final int popularity;
  final bool featured;
  final List<String> platforms;
  final List<String> tags;
  final String iconKey;
  final Color primaryColor;
  final Color secondaryColor;
  final GameRequirements requirements;

  factory Game.fromJson(Map<String, dynamic> json) => Game(
        id: json['id'] as String,
        title: json['title'] as String,
        genre: json['genre'] as String,
        releaseDate: DateTime.parse(json['releaseDate'] as String),
        description: json['description'] as String,
        coverUrl: json['coverUrl'] as String,
        steamAppId: (json['steamAppId'] as num).toInt(),
        rating: (json['rating'] as num).toDouble(),
        popularity: (json['popularity'] as num).toInt(),
        featured: json['featured'] as bool,
        platforms: List<String>.from(json['platforms'] as List),
        tags: List<String>.from(json['tags'] as List),
        iconKey: json['iconKey'] as String,
        primaryColor: _parseColor(json['primaryColor'] as String),
        secondaryColor: _parseColor(json['secondaryColor'] as String),
        requirements: GameRequirements.fromJson(
          json['requirements'] as Map<String, dynamic>,
        ),
      );

  static Color _parseColor(String value) {
    final hex = value.replaceFirst('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }

  String get formattedReleaseDate {
    const months = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
    ];
    return '${releaseDate.day} ${months[releaseDate.month - 1]} ${releaseDate.year}';
  }
}

class GameRequirements {
  const GameRequirements({
    required this.os,
    required this.processor,
    required this.memory,
    required this.graphics,
    required this.storage,
  });

  final String os;
  final String processor;
  final String memory;
  final String graphics;
  final String storage;

  factory GameRequirements.fromJson(Map<String, dynamic> json) =>
      GameRequirements(
        os: json['os'] as String,
        processor: json['processor'] as String,
        memory: json['memory'] as String,
        graphics: json['graphics'] as String,
        storage: json['storage'] as String,
      );
}
