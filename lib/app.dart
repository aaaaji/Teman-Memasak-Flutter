import 'package:flutter/material.dart';
import 'core/app_colors.dart';
import 'data/game_repository.dart';
import 'models/game.dart';
import 'screens/home_screen.dart';

class GameAtlasApp extends StatefulWidget {
  const GameAtlasApp({super.key});

  @override
  State<GameAtlasApp> createState() => _GameAtlasAppState();
}

class _GameAtlasAppState extends State<GameAtlasApp> {
  late final Future<List<Game>> _gamesFuture =
      const LocalGameRepository().fetchGames();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GameAtlas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.canvas,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.navy,
          primary: AppColors.navy,
          secondary: AppColors.yellow,
          surface: AppColors.canvas,
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.7,
            color: AppColors.ink,
          ),
          titleLarge: TextStyle(
            fontWeight: FontWeight.w800,
            color: AppColors.ink,
          ),
          titleMedium: TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.ink,
          ),
          bodyMedium: TextStyle(color: AppColors.ink),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.canvas,
          foregroundColor: AppColors.ink,
          surfaceTintColor: Colors.transparent,
        ),
      ),
      home: FutureBuilder<List<Game>>(
        future: _gamesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    'Data gagal dimuat. Periksa assets/data/games.json.\n'
                    '${snapshot.error}',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          }
          return HomeScreen(games: snapshot.data ?? const []);
        },
      ),
    );
  }
}
