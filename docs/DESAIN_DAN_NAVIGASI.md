# Dokumentasi Desain dan Navigasi — GameAtlas

## 1. Konsep produk dan pengguna

Nama: **GameAtlas**. Sasaran: pelajar/mahasiswa atau pengguna umum yang ingin mencari referensi game secara cepat berdasarkan genre, rating dummy, dan kebutuhan perangkat. Tujuan: memudahkan pengguna menemukan katalog dan membaca detail game tanpa proses login.

## 2. Skenario pengguna (*use case*)

- Pengguna membuka beranda dan melihat game populer serta terbaru.
- Pengguna memilih kategori "RPG" untuk melihat game RPG.
- Pengguna menulis "neon" pada kolom pencarian, lalu menekan Enter/tombol panah.
- Pengguna mengubah urutan daftar berdasarkan tanggal terbaru atau rating.
- Pengguna mengetuk salah satu game dan membaca deskripsi serta spesifikasi.
- Pengguna menekan tombol kembali untuk menjelajahi game lain.

## 3. Struktur navigasi

```text
Beranda (/)
├── Pencarian ─────────────► Daftar Game (query)
├── Kategori ──────────────► Daftar Game (genre)
├── "Lihat semua" ────────► Daftar Game (semua)
├── Kartu populer ─────────► Detail Game
└── Kartu terbaru ─────────► Detail Game

Daftar Game
├── Filter / pencarian / urutan (tetap di halaman ini)
└── Kartu Game ────────────► Detail Game

Detail Game
└── Kembali ───────────────► Halaman sebelumnya
```

**Mekanisme routing:** `Navigator.push<void>(context, MaterialPageRoute(...))` dan `Navigator.pop(context)`.

## 4. Rancangan model data

Entitas **Game**:

`id: String`, `title: String`, `genre: String`, `releaseDate: DateTime`, `description: String`, `rating: double`, `popularity: int`, `featured: bool`, `platforms: List<String>`, `tags: List<String>`, `iconKey: String`, `primaryColor: Color`, `secondaryColor: Color`, `requirements: GameRequirements`.

Entitas **GameRequirements**:

`os`, `processor`, `memory`, `graphics`, `storage`: semuanya `String`.

Data disimpan sebagai **array objek JSON** dalam `assets/data/games.json`, diakses dengan `rootBundle.loadString`, lalu dipetakan lewat `Game.fromJson`. Penggantian ke API cukup mengganti implementasi `GameRepository`.

## 5. Wireframe dan purwarupa

- Lihat `wireframe.png` untuk tiga rancangan awal secara berdampingan.
- Tampilan akhir direpresentasikan secara aktual oleh widget Flutter di `lib/screens`.
- Wireframe yang disertakan adalah ilustrasi rancangan, **bukan screenshot aplikasi yang sudah dijalankan**.

## 6. Sistem desain

- **Palet:** navy `#152A34`, krem `#FFF2D0`, kuning `#FFBB35`, putih `#FFFFFF`, teks `#203038`.
- **Tipografi:** Material default sistem dengan penekanan judul tebal agar mudah dibaca.
- **Elemen antarmuka:** radius 13–29px, ruang antarelemen 8–27px, kontrol klik cukup besar, judul bisa dipotong `ellipsis` pada layar sempit.
- **Responsivitas:** `SafeArea` mencegah tabrakan dengan status bar, `ConstrainedBox(maxWidth: 760)` mencegah konten terlalu lebar di tablet, `Expanded` dan `LayoutBuilder` menangani perubahan ukuran, daftar dapat digulir.
- **Aksesibilitas dasar:** label tombol icon, kontras navy-putih, ukuran huruf standar, tidak bergantung pada gambar untuk menyampaikan informasi game.

## 7. Materi demonstrasi saat presentasi

1. Tunjukkan beranda dan jelaskan `Column`, `Row`, `ListView.horizontal`, `Stack` pada cover.
2. Klik kategori "RPG"; tunjukkan daftar hanya RPG.
3. Cari judul "Overwatch" di beranda; buktikan daftar terfilter.
4. Buka detail game dan baca minimum system requirements.
5. Kembali ke daftar; pilih sort "Terbaru", tunjukkan urutan berubah.
6. Tunjukkan `assets/data/games.json` dan `Game.fromJson` untuk menjelaskan transformasi data.
7. Tunjukkan diagram navigasi dan wireframe dalam laporan.
