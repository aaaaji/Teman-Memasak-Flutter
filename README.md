# Teman Memasak

Teman Memasak adalah aplikasi katalog resep masakan berbasis Flutter. Aplikasi ini dibuat untuk membantu pengguna menemukan ide masakan melalui tampilan yang sederhana dan mudah digunakan. Pengguna dapat melihat rekomendasi resep di beranda, mencari masakan berdasarkan nama atau bahan, memilih kategori, serta membuka halaman detail untuk membaca bahan dan langkah memasak.

Proyek ini menggunakan data lokal dalam format JSON. Data tersebut belum diambil dari server, tetapi susunan kode sudah memisahkan bagian tampilan, model, dan pengambilan data agar lebih mudah dikembangkan nantinya.

## Fitur Aplikasi

**1. Beranda**

Halaman pertama menampilkan nama aplikasi, banner pengenalan, pilihan kategori masakan, resep populer, dan rekomendasi pilihan hari ini. Tombol pencarian, tombol untuk menjelajahi resep, dan pilihan kategori mengarahkan pengguna ke halaman Jelajahi. Kartu resep dapat dipilih untuk membuka halaman detail.

**2. Daftar Resep (Jelajahi)**

Halaman ini menampilkan seluruh resep yang tersedia. Pengguna dapat mencari masakan berdasarkan judul, kategori, deskripsi, atau bahan; menyaring resep berdasarkan kategori; serta mengurutkan daftar berdasarkan rekomendasi, waktu memasak tercepat, atau urutan alfabet (A–Z).

**3. Detail Resep**

Halaman detail menampilkan ilustrasi masakan, nama resep, kategori, deskripsi, rating contoh, perkiraan waktu memasak, jumlah porsi, dan tingkat kesulitan. Pengguna dapat mencentang bahan yang sudah disiapkan, mengikuti langkah memasak secara berurutan, membaca tips, serta menekan tombol *Selesai Memasak*. Tombol kembali digunakan untuk membuka halaman sebelumnya.

**4. Favorit**

Halaman Favorit menampilkan resep yang telah ditandai menggunakan ikon hati. Pengguna dapat menambahkan atau menghapus resep dari daftar favorit dan membuka kembali detail resep yang dipilih. Penyimpanan favorit pada versi ini masih bersifat sementara selama aplikasi berjalan.

## Struktur Folder

```text
teman_memasak_flutter/
├── lib/
│   ├── main.dart                         # Titik awal aplikasi
│   ├── app.dart                          # Tema, pemuatan data awal, navigasi, dan favorit
│   ├── theme/
│   │   └── app_palette.dart              # Warna yang digunakan di aplikasi
│   ├── models/
│   │   └── recipe.dart                   # Model data resep
│   ├── data/
│   │   ├── recipe_repository.dart        # Pembacaan data dari JSON lokal
│   │   └── recipe_categories.dart        # Daftar kategori masakan
│   ├── screens/
│   │   ├── home_screen.dart              # Halaman beranda
│   │   ├── explore_screen.dart           # Halaman daftar, pencarian, dan filter resep
│   │   ├── detail_screen.dart            # Halaman detail resep
│   │   └── favorites_screen.dart         # Halaman resep favorit
│   └── widgets/
│       └── recipe_widgets.dart           # Komponen ilustrasi, kartu resep, dan tombol favorit
├── assets/
│   └── data/
│       └── recipes.json                  # Data resep sementara
├── docs/
│   ├── wireframe_teman_memasak.png       # Rancangan awal antarmuka
│   └── KONSEP_DESAIN.md                  # Catatan desain dan navigasi
├── test/
│   └── recipe_model_test.dart            # Pengujian pembacaan data model
├── tools/
│   └── set_app_name.ps1                  # Mengatur nama aplikasi pada Android
├── setup_windows.bat                     # Skrip persiapan proyek untuk Windows
├── setup_linux_mac.sh                    # Skrip persiapan untuk Linux/macOS
└── pubspec.yaml                          # Konfigurasi Flutter dan aset
```

Folder `screens` berisi tampilan masing-masing halaman, sedangkan `widgets` berisi komponen yang dapat digunakan kembali. Pemisahan ini dilakukan supaya kode lebih mudah dibaca, dikelola, dan dikembangkan tanpa harus menempatkan seluruh tampilan dalam satu file.

## Alur Navigasi

```text
Beranda
├── Pilih kategori / Cari / Jelajahi semua → Daftar Resep (Jelajahi)
│                                           └── Pilih resep → Detail Resep
├── Pilih resep populer atau pilihan hari ini ─────────────→ Detail Resep
└── Navigasi bawah → Favorit
                     └── Pilih resep ──────────────────────→ Detail Resep
```

Navigasi antartab Beranda, Jelajahi, dan Favorit menggunakan `NavigationBar` bersama `IndexedStack`. Halaman detail dibuka menggunakan `Navigator.push()` melalui `MaterialPageRoute`, sedangkan tombol kembali pada `AppBar` mengembalikan pengguna ke halaman sebelumnya. Resep yang dipilih dikirim sebagai objek `Recipe` agar informasi pada halaman detail sesuai dengan pilihan pengguna.

## Pengelolaan Data

Data resep berada di `assets/data/recipes.json` dan berisi **19 resep contoh** dalam enam kategori: Sarapan, Makanan Utama, Sayuran, Camilan, Minuman, dan Pencuci Mulut.

Setiap resep memiliki informasi seperti `id`, `title`, `category`, `description`, `emoji`, `colorHex`, `durationMinutes`, `servings`, `difficulty`, `rating`, `ingredients`, `steps`, `tips`, `isPopular`, dan `isFeatured`.

Data dibaca oleh `RecipeRepository` pada `lib/data/recipe_repository.dart`, kemudian diubah menjadi objek `Recipe` melalui `Recipe.fromJson()` pada `lib/models/recipe.dart`. Pemisahan model dan repository memudahkan perubahan sumber data dari file JSON lokal menjadi API pada pengembangan berikutnya.

Ilustrasi resep menggunakan emoji makanan dan gradasi warna yang dibuat langsung dengan widget Flutter, sehingga tidak memerlukan koneksi internet. **Resep dan rating pada versi ini merupakan data contoh untuk pembelajaran**, bukan hasil penilaian pengguna sungguhan. Status favorit dan centang bahan juga belum disimpan secara permanen.

## Widget dan Tampilan

Antarmuka dibuat menggunakan widget Flutter seperti `Scaffold`, `Column`, `Row`, `Stack`, `ListView`, `GridView`, `SingleChildScrollView`, `TextField`, `ChoiceChip`, `DropdownButton`, `InkWell`, `CheckboxListTile`, dan `SliverAppBar`. Kartu resep, ilustrasi masakan, dan tombol favorit dibuat sebagai komponen terpisah agar tampilan lebih konsisten.

Warna utama aplikasi disimpan di `lib/theme/app_palette.dart`. Desain menggunakan warna terracotta, krem, dan aksen pastel untuk memberikan kesan hangat dan sesuai dengan tema memasak. `ConstrainedBox` dan `LayoutBuilder` digunakan pada beberapa halaman untuk menyesuaikan lebar konten dan jumlah kolom resep pada ukuran layar yang berbeda.

Rancangan awal antarmuka dan catatan navigasi dapat dilihat pada folder `docs`.

## Menjalankan Aplikasi

Pastikan Flutter SDK, Android Studio, plugin Flutter dan Dart, serta emulator atau perangkat Android sudah disiapkan. Buka folder `teman_memasak_flutter` melalui Android Studio.

Dari terminal pada direktori proyek, jalankan:

```bash
flutter pub get
flutter run
```

Apabila folder platform `android/` belum tersedia, buat terlebih dahulu dengan:

```bash
flutter create --platforms=android --project-name teman_memasak .
flutter pub get
flutter run
```

Khusus pengguna Windows, tersedia `setup_windows.bat` untuk membuat folder Android (jika belum ada), mengatur nama aplikasi menjadi **Teman Memasak**, dan menjalankan `flutter pub get`. Pada Linux atau macOS, tersedia `setup_linux_mac.sh` untuk persiapan serupa.

Aplikasi menggunakan data dan ilustrasi lokal, sehingga tidak memerlukan izin internet khusus untuk menampilkan resep. Folder `android/` tidak disertakan dalam paket awal dan akan dibuat sesuai versi Flutter SDK yang terpasang pada komputer pengguna.

## Pengujian

Pemeriksaan kode dan pengujian dapat dijalankan dengan:

```bash
flutter analyze
flutter test
```

File `test/recipe_model_test.dart` digunakan untuk mengecek konversi data JSON contoh menjadi objek `Recipe`, termasuk judul, waktu memasak, bahan, dan langkah memasak. Pencarian, filter kategori, navigasi antartab, daftar favorit, dan tampilan responsif juga perlu diperiksa langsung melalui emulator atau perangkat Android.

**Status pengujian:** struktur kode dan data telah diperiksa secara statis, tetapi aplikasi belum diuji build atau dijalankan pada emulator di lingkungan pembuatan proyek karena Flutter SDK dan emulator tidak tersedia.

## Rencana Pengembangan

Saat ini aplikasi berfokus pada desain antarmuka, pengolahan data resep lokal, dan navigasi antarhalaman. Pengembangan berikutnya direncanakan berupa pengambilan data resep melalui API agar informasi dapat diperbarui dari server, penambahan foto masakan, serta penyimpanan favorit secara permanen.
