import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../models/game.dart';
import '../widgets/game_list_tile.dart';
import 'game_detail_screen.dart';

class GameListScreen extends StatefulWidget {
  const GameListScreen({
    required this.games,
    this.initialCategory,
    this.initialQuery = '',
    super.key,
  });

  final List<Game> games;
  final String? initialCategory;
  final String initialQuery;

  @override
  State<GameListScreen> createState() => _GameListScreenState();
}

class _GameListScreenState extends State<GameListScreen> {
  late final TextEditingController _search;
  String? _category;
  String _sortBy = 'Populer';

  @override
  void initState() {
    super.initState();
    _category = widget.initialCategory;
    _search = TextEditingController(text: widget.initialQuery);
    _search.addListener(_onSearchChanged);
  }

  void _onSearchChanged() => setState(() {});

  @override
  void dispose() {
    _search.removeListener(_onSearchChanged);
    _search.dispose();
    super.dispose();
  }

  List<Game> get _visibleGames {
    final query = _search.text.trim().toLowerCase();
    final result = widget.games.where((g) {
      final matchesCategory = _category == null || g.genre == _category;
      final matchesQuery = query.isEmpty ||
          g.title.toLowerCase().contains(query) ||
          g.genre.toLowerCase().contains(query) ||
          g.tags.any((tag) => tag.toLowerCase().contains(query));
      return matchesCategory && matchesQuery;
    }).toList();

    if (_sortBy == 'Terbaru') {
      result.sort((a, b) => b.releaseDate.compareTo(a.releaseDate));
    } else if (_sortBy == 'Rating') {
      result.sort((a, b) => b.rating.compareTo(a.rating));
    } else {
      result.sort((a, b) => b.popularity.compareTo(a.popularity));
    }
    return result;
  }

  void _openDetail(Game game) {
    Navigator.push<void>(
      context,
      MaterialPageRoute(builder: (_) => GameDetailScreen(game: game)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _visibleGames;
    const genres = ['Semua', 'Shooter', 'RPG', 'Balap', 'Strategi', 'Sport'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Jelajahi game',
            style: TextStyle(fontWeight: FontWeight.w900)),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 14),
                  child: TextField(
                    controller: _search,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Cari game, genre, atau tag...',
                      prefixIcon: const Icon(Icons.search_rounded,
                          color: AppColors.navy),
                      suffixIcon: _search.text.isEmpty
                          ? null
                          : IconButton(
                              tooltip: 'Hapus pencarian',
                              onPressed: _search.clear,
                              icon: const Icon(Icons.close_rounded),
                            ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 47,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: genres.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, i) {
                      final genre = genres[i];
                      final active = (_category ?? 'Semua') == genre;
                      return ChoiceChip(
                        label: Text(genre),
                        selected: active,
                        showCheckmark: false,
                        selectedColor: AppColors.navy,
                        backgroundColor: Colors.white,
                        labelStyle: TextStyle(
                          color: active ? Colors.white : AppColors.ink,
                          fontWeight: FontWeight.w700,
                        ),
                        side: BorderSide.none,
                        onSelected: (_) => setState(() {
                          _category = genre == 'Semua' ? null : genre;
                        }),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 13),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('${filtered.length} game ditemukan',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: AppColors.ink,
                            )),
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _sortBy,
                          isDense: true,
                          borderRadius: BorderRadius.circular(12),
                          icon: const Icon(Icons.keyboard_arrow_down_rounded),
                          items: ['Populer', 'Terbaru', 'Rating']
                              .map((s) => DropdownMenuItem(
                                  value: s, child: Text(s,
                                    style: const TextStyle(fontSize: 13))))
                              .toList(),
                          onChanged: (v) {
                            if (v != null) setState(() => _sortBy = v);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: filtered.isEmpty
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(28),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.search_off_rounded,
                                    size: 52, color: AppColors.muted),
                                SizedBox(height: 12),
                                Text('Game tidak ditemukan',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 17,
                                  )),
                                SizedBox(height: 5),
                                Text('Coba kata kunci atau kategori lain.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: AppColors.muted)),
                              ],
                            ),
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
                          itemCount: filtered.length,
                          itemBuilder: (context, index) => GameListTile(
                            game: filtered[index],
                            onTap: () => _openDetail(filtered[index]),
                          ),
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 11),
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
