import 'package:flutter/material.dart';

class RecipeCategory {
  const RecipeCategory(this.name, this.emoji, this.color);

  final String name;
  final String emoji;
  final Color color;
}

const recipeCategories = <RecipeCategory>[
  RecipeCategory('Sarapan', '🍳', Color(0xFFFFE8C9)),
  RecipeCategory('Makanan Utama', '🍛', Color(0xFFFFDACF)),
  RecipeCategory('Sayuran', '🥬', Color(0xFFE5F0DA)),
  RecipeCategory('Camilan', '🥟', Color(0xFFFFE5BD)),
  RecipeCategory('Minuman', '🥤', Color(0xFFDFF0F5)),
  RecipeCategory('Pencuci Mulut', '🍮', Color(0xFFF0E2F8)),
];
