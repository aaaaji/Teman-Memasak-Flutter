# GameAtlas

GameAtlas adalah aplikasi katalog game berbasis Flutter. Aplikasi ini dibuat untuk menampilkan informasi beberapa game dalam tampilan yang sederhana dan mudah digunakan. Pengguna dapat melihat game di beranda, mencari game berdasarkan judul, memilih kategori, serta membuka halaman detail untuk membaca informasi game yang dipilih.

Proyek ini menggunakan data lokal dalam format JSON. Data tersebut belum diambil dari server, tetapi susunan kode sudah memisahkan bagian tampilan, model, dan pengambilan data agar lebih mudah dikembangkan nantinya.

## Fitur Aplikasi

**1. Beranda**

Halaman pertama menampilkan kolom pencarian, pilihan kategori, game populer, dan game terbaru. Judul game dapat dipilih untuk membuka halaman detail. Tombol *Lihat semua* dan pilihan kategori mengarahkan pengguna ke halaman daftar game.

**2. Daftar Game**

Halaman ini menampilkan seluruh game yang tersedia. Pengguna dapat mencari judul, menyaring berdasarkan kategori, dan mengurutkan daftar berdasarkan popularitas, tanggal rilis, atau rating.

**3. Detail Game**

Halaman detail menampilkan cover, judul, genre, tanggal rilis, platform, deskripsi singkat, dan contoh spesifikasi minimum game. Tombol kembali digunakan untuk membuka halaman sebelumnya.

## Struktur Folder

```text
gameatlas_flutter/
├── lib/
│   ├── main.dart                     # Titik awal aplikasi
│   ├── app.dart                      # Pengaturan tema dan pemuatan data awal
│   ├── core/
│   │   └── app_colors.dart           # Warna yang digunakan di aplikasi
│   ├── models/
│   │   └── game.dart                 # Model data game
│   ├── data/
│   │   └── game_repository.dart      # Pembacaan data dari JSON lokal
│   ├── screens/
│   │   ├── home_screen.dart          # Halaman beranda
│   │   ├── game_list_screen.dart     # Halaman daftar dan filter game
│   │   └── game_detail_screen.dart   # Halaman detail game
│   └── widgets/
│       ├── game_cover.dart           # Widget gambar cover
│       ├── game_list_tile.dart       # Komponen item daftar game
│       └── section_heading.dart      # Judul bagian pada halaman
├── assets/
│   └── data/
│       └── games.json               # Data game sementara
├── docs/
│   ├── wireframe.png                # Rancangan tampilan
│   └── DESAIN_DAN_NAVIGASI.md        # Catatan desain dan navigasi
├── test/
│   └── game_model_test.dart          # Pengujian pembacaan data model
└── pubspec.yaml                     # Konfigurasi Flutter dan aset
```

Folder `screens` berisi tampilan untuk masing-masing halaman, sedangkan `widgets` berisi komponen yang dipakai kembali di beberapa bagian aplikasi. Pemisahan ini dilakukan supaya kode lebih mudah dibaca dan perubahan tampilan tidak harus dilakukan dalam satu file besar.

## Alur Navigasi

```text
Beranda
├── Pilih kategori / Cari / Lihat semua → Daftar Game
│                                      └── Pilih game → Detail Game
└── Pilih game populer atau terbaru ─────────────────→ Detail Game
```

Navigasi antarhalaman menggunakan `Navigator.push()` untuk membuka halaman baru dan `Navigator.pop()` untuk kembali. Game yang dipilih dikirim sebagai objek `Game` ke halaman detail sehingga informasi yang ditampilkan sesuai dengan pilihan pengguna.

## Pengelolaan Data

Data game berada di `assets/data/games.json`. Setiap game memiliki informasi seperti `id`, `title`, `genre`, `releaseDate`, `description`, `coverUrl`, `rating`, `platforms`, dan `requirements`.

Data dibaca oleh `LocalGameRepository` pada `lib/data/game_repository.dart`, kemudian diubah menjadi objek `Game` melalui `Game.fromJson()` pada `lib/models/game.dart`. Pemisahan model dan repository ini memudahkan perubahan sumber data dari file JSON lokal menjadi API pada pengembangan berikutnya.

Judul game dan gambar cover mengacu pada game yang tersedia di Steam. Gambar ditampilkan menggunakan `Image.network()` dari alamat yang tersimpan pada `coverUrl`, sehingga membutuhkan koneksi internet. **Nilai rating, popularitas, dan spesifikasi minimum dalam aplikasi masih berupa data contoh**, bukan data resmi dari Steam.

## Widget dan Tampilan

Antarmuka dibangun menggunakan widget Flutter seperti `Scaffold`, `Column`, `Row`, `Stack`, `ListView`, `CustomScrollView`, `TextField`, dan `InkWell`. Komponen kartu game dibuat terpisah agar tampilan lebih konsisten.

Warna utama aplikasi disimpan di `lib/core/app_colors.dart`. Pada beberapa halaman digunakan `ConstrainedBox` untuk membatasi lebar konten sehingga tetap nyaman dilihat pada ukuran layar yang berbeda.

Rancangan awal antarmuka dan catatan navigasi dapat dilihat pada folder `docs`.

## Menjalankan Aplikasi

Pastikan Flutter SDK, Android Studio, dan emulator atau perangkat Android sudah disiapkan. Dari terminal pada direktori proyek, jalankan:

```bash
flutter pub get
flutter run
```

Apabila folder platform `android/` belum tersedia, buat terlebih dahulu dengan:

```bash
flutter create --platforms=android .
```

Karena gambar cover diambil melalui internet, pastikan konfigurasi Android memiliki izin berikut di `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.INTERNET" />
```

## Pengujian

Pemeriksaan kode dan pengujian dapat dijalankan dengan:

```bash
flutter analyze
flutter test
```

File `test/game_model_test.dart` digunakan untuk mengecek pembacaan data JSON ke objek `Game`, termasuk judul, genre, tanggal rilis, alamat cover, dan informasi spesifikasi. Tampilan dan navigasi antarhalaman juga perlu diperiksa langsung melalui emulator.

## Rencana Pengembangan

Saat ini aplikasi berfokus pada desain antarmuka, pengolahan data lokal, dan navigasi. Pengembangan berikutnya direncanakan berupa pengambilan data melalui API sehingga daftar game tidak perlu diperbarui secara manual di file JSON.
