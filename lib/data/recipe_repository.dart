import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/recipe.dart';

/// Berbasis JSON lokal. Kelak loadRecipes() dapat diganti dengan request API
/// tanpa mengubah model dan sebagian besar UI.
class RecipeRepository {
  const RecipeRepository();

  Future<List<Recipe>> loadRecipes() async {
    final raw = await rootBundle.loadString('assets/data/recipes.json');
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((item) => Recipe.fromJson(item as Map<String, dynamic>))
        .toList(growable: false);
  }
}
