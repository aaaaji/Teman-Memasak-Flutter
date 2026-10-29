# Konsep Desain UI — Teman Memasak

## Identitas

- **Nama aplikasi**: Teman Memasak
- **Konsep**: katalog resep masakan rumahan yang sederhana, ramah, dan praktis.
- **Target pengguna**: mahasiswa, pemula yang belajar memasak, dan keluarga yang butuh inspirasi menu.
- **Gaya antarmuka**: clean, hangat, ramah, dengan kartu resep dan ikon makanan.
- **Palet**: terracotta `#E96142` (utama), krem `#FFF9F4` (latar), cokelat gelap `#302923` (teks), persik `#FFE9DD` (aksen).
- **Tipografi**: font sistem Android; judul bold, label kecil konsisten, paragraf cukup renggang.
- **Ilustrasi**: emoji bahan/masakan di atas gradien warna lokal, bukan foto eksternal. Keuntungannya: aset tersedia offline.

## Alur pengguna

```text
Buka aplikasi
    |
    v
Beranda -------------+-----------------+
    |                 |                 |
    v                 v                 v
Pilih kategori     Jelajahi          Favorit
    |                 |                 |
    +------> Cari/filter resep <--------+
                      |
                      v
                 Detail Resep
                      |
             +--------+---------+
             |                  |
        Centang bahan      Tandai favorit
             |                  |
             +------ kembali ---+
```

## Rancangan per halaman

1. **Beranda**: logo/nama; banner ajakan; daftar kategori geser horizontal; kartu resep populer; satu rekomendasi utama.
2. **Jelajahi**: judul; input pencarian; filter kategori; menu pengurutan; grid kartu resep responsif.
3. **Detail Resep**: header ilustrasi; nama dan kategori; ringkasan waktu/porsi; daftar bahan interaktif; langkah bernomor; tips.
4. **Favorit**: daftar resep yang ditandai hati; keadaan kosong dengan tombol jelajahi.

## Catatan dokumentasi

`wireframe_teman_memasak.png` adalah **rancangan awal** hasil penyusunan elemen antarmuka, **bukan tangkapan layar hasil aplikasi**. Gunakan gambar itu sebagai lampiran desain awal dalam laporan, lalu tambahkan screenshot nyata dari emulator saat aplikasi berhasil dijalankan.
