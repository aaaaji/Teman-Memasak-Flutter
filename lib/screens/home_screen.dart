import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../models/game.dart';
import '../widgets/game_cover.dart';
import '../widgets/game_list_tile.dart';
import '../widgets/section_heading.dart';
import 'game_detail_screen.dart';
import 'game_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({required this.games, super.key});

  final List<Game> games;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  static const categories = <({String name, IconData icon, Color color})>[
    (name: 'Shooter', icon: Icons.gps_fixed_rounded, color: Color(0xFFDE9D32)),
    (name: 'Balap', icon: Icons.sports_motorsports_rounded, color: Color(0xFFCF7C70)),
    (name: 'Strategi', icon: Icons.extension_rounded, color: Color(0xFF8A80C9)),
    (name: 'Sport', icon: Icons.sports_basketball_rounded, color: Color(0xFF69A4A1)),
    (name: 'RPG', icon: Icons.auto_awesome_rounded, color: Color(0xFF638CC4)),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openList({String? category, String query = ''}) {
    Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (_) => GameListScreen(
          games: widget.games,
          initialCategory: category,
          initialQuery: query,
        ),
      ),
    );
  }

  void _openDetail(Game game) {
    Navigator.push<void>(
      context,
      MaterialPageRoute(builder: (_) => GameDetailScreen(game: game)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final popular = [...widget.games]
      ..sort((a, b) => b.popularity.compareTo(a.popularity));
    final latest = [...widget.games]
      ..sort((a, b) => b.releaseDate.compareTo(a.releaseDate));
    final featured = popular.where((g) => g.featured).toList();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _buildHeader()),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Jelajahi kategori',
                          style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w900,
                            color: AppColors.ink,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 99,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            padding: const EdgeInsets.only(right: 20),
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 15),
                            itemBuilder: (context, index) {
                              final c = categories[index];
                              return InkWell(
                                onTap: () => _openList(category: c.name),
                                borderRadius: BorderRadius.circular(17),
                                child: SizedBox(
                                  width: 67,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 61,
                                        height: 61,
                                        decoration: BoxDecoration(
                                          color: c.color,
                                          borderRadius: BorderRadius.circular(19),
                                        ),
                                        child: Icon(c.icon,
                                            color: Colors.white, size: 30),
                                      ),
                                      const SizedBox(height: 9),
                                      Text(c.name,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.ink,
                                          )),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 23, 20, 13),
                    child: SectionHeading(
                      title: 'Game populer',
                      actionLabel: 'Lihat semua',
                      onAction: () => _openList(),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 210,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      scrollDirection: Axis.horizontal,
                      itemCount: featured.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 13),
                      itemBuilder: (context, index) {
                        final game = featured[index];
                        return SizedBox(
                          width: 230,
                          child: Material(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(21),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(21),
                              onTap: () => _openDetail(game),
                              child: Padding(
                                padding: const EdgeInsets.all(7),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GameCover(game: game, height: 135),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(7, 9, 7, 0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              game.title,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w800,
                                                color: AppColors.ink,
                                              ),
                                            ),
                                          ),
                                          const Icon(Icons.star_rounded,
                                              size: 16, color: AppColors.yellow),
                                          Text(game.rating.toStringAsFixed(1),
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w800,
                                              )),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 7, top: 1),
                                      child: Text(
                                        game.genre,
                                        style: const TextStyle(
                                          color: AppColors.muted, fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 27, 20, 12),
                    child: SectionHeading(
                      title: 'Game terbaru',
                      actionLabel: 'Lihat semua',
                      onAction: () => _openList(),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
                  sliver: SliverList.separated(
                    itemCount: latest.take(4).length,
                    itemBuilder: (context, index) => GameListTile(
                      game: latest[index],
                      onTap: () => _openDetail(latest[index]),
                    ),
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 23, 22, 25),
      decoration: const BoxDecoration(
        color: AppColors.navy,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(29),
          bottomRight: Radius.circular(29),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Halo, Wahyu',
                        style: TextStyle(
                          fontSize: 25, fontWeight: FontWeight.w900,
                          color: Colors.white,
                        )),
                    SizedBox(height: 5),
                    Text('Mau main game apa hari ini?',
                        style: TextStyle(color: Color(0xFFC0D3D7), fontSize: 13)),
                  ],
                ),
              ),
              Container(
                width: 49,
                height: 49,
                decoration: const BoxDecoration(
                  color: Color(0xFF45BBA2), shape: BoxShape.circle,
                ),
                child: const Icon(Icons.sports_esports_rounded,
                    color: Colors.white, size: 29),
              ),
            ],
          ),
          const SizedBox(height: 27),
          TextField(
            controller: _searchController,
            onSubmitted: (value) => _openList(query: value.trim()),
            textInputAction: TextInputAction.search,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Cari judul atau genre game...',
              hintStyle: const TextStyle(
                color: Color(0xFFC8D5D8), fontSize: 13,
              ),
              filled: true,
              fillColor: AppColors.navySoft,
              prefixIcon: const Icon(Icons.search_rounded,
                  color: AppColors.yellow),
              suffixIcon: IconButton(
                tooltip: 'Cari game',
                onPressed: () => _openList(
                    query: _searchController.text.trim()),
                icon: const Icon(Icons.arrow_forward_rounded,
                    color: AppColors.yellow),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
            ),
          ),
        ],
      ),
    );
  }
}
