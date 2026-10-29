import 'package:flutter_test/flutter_test.dart';
import 'package:gameatlas/models/game.dart';

void main() {
  test('Game.fromJson membaca struktur data JSON', () {
    final game = Game.fromJson({
      'id': 'test-1',
      'title': 'Game Contoh',
      'genre': 'RPG',
      'releaseDate': '2026-03-15',
      'description': 'Data dummy',
      'steamAppId': 570,
      'coverUrl': 'https://cdn.cloudflare.steamstatic.com/steam/apps/570/header.jpg',
      'rating': 4.5,
      'popularity': 90,
      'featured': true,
      'platforms': ['PC'],
      'tags': ['Adventure'],
      'iconKey': 'sword',
      'primaryColor': '#123456',
      'secondaryColor': '#654321',
      'requirements': {
        'os': 'Windows',
        'processor': 'Core i5',
        'memory': '8 GB',
        'graphics': 'GPU',
        'storage': '20 GB',
      },
    });

    expect(game.title, 'Game Contoh');
    expect(game.steamAppId, 570);
    expect(game.coverUrl, contains('/570/header.jpg'));
    expect(game.genre, 'RPG');
    expect(game.formattedReleaseDate, '15 Maret 2026');
    expect(game.requirements.memory, '8 GB');
  });
}
