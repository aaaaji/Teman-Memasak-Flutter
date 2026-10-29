import 'package:flutter_test/flutter_test.dart';
import 'package:teman_memasak/models/recipe.dart';

void main() {
  test('Model Recipe membaca data JSON dan bahan/step dengan benar', () {
    final recipe = Recipe.fromJson({
      'id': 'contoh',
      'title': 'Masakan Contoh',
      'category': 'Sarapan',
      'description': 'Deskripsi',
      'emoji': '🍳',
      'colorHex': '#FFDDBB',
      'durationMinutes': 15,
      'servings': 2,
      'difficulty': 'Mudah',
      'rating': 4.5,
      'ingredients': ['2 butir telur'],
      'steps': ['Kocok telur.'],
      'tips': 'Sajikan hangat.',
      'isPopular': true,
      'isFeatured': false,
    });
    expect(recipe.title, 'Masakan Contoh');
    expect(recipe.durationMinutes, 15);
    expect(recipe.ingredients.single, '2 butir telur');
    expect(recipe.steps.length, 1);
  });
}
