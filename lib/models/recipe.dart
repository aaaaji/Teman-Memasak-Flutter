class Recipe {
  const Recipe({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.emoji,
    required this.colorHex,
    required this.durationMinutes,
    required this.servings,
    required this.difficulty,
    required this.rating,
    required this.ingredients,
    required this.steps,
    required this.tips,
    required this.isPopular,
    required this.isFeatured,
  });

  final String id;
  final String title;
  final String category;
  final String description;
  final String emoji;
  final String colorHex;
  final int durationMinutes;
  final int servings;
  final String difficulty;
  /// Rating contoh (dummy), bukan ulasan pengguna nyata.
  final double rating;
  final List<String> ingredients;
  final List<String> steps;
  final String tips;
  final bool isPopular;
  final bool isFeatured;

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      emoji: json['emoji'] as String,
      colorHex: json['colorHex'] as String,
      durationMinutes: (json['durationMinutes'] as num).toInt(),
      servings: (json['servings'] as num).toInt(),
      difficulty: json['difficulty'] as String,
      rating: (json['rating'] as num).toDouble(),
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((item) => item as String)
          .toList(growable: false),
      steps: (json['steps'] as List<dynamic>)
          .map((item) => item as String)
          .toList(growable: false),
      tips: json['tips'] as String,
      isPopular: json['isPopular'] as bool,
      isFeatured: json['isFeatured'] as bool,
    );
  }
}
