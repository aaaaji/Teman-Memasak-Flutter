import 'dart:convert';

import 'package:flutter/services.dart';
import '../models/game.dart';

/// Kontrak pengambilan data. Kelak LocalGameRepository dapat diganti
/// dengan ApiGameRepository tanpa mengubah layar-layar aplikasi.
abstract class GameRepository {
  Future<List<Game>> fetchGames();
}

class LocalGameRepository implements GameRepository {
  const LocalGameRepository();

  @override
  Future<List<Game>> fetchGames() async {
    final raw = await rootBundle.loadString('assets/data/games.json');
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((item) => Game.fromJson(item as Map<String, dynamic>))
        .toList(growable: false);
  }
}
