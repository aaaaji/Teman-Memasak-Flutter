#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
if ! command -v flutter >/dev/null 2>&1; then
  echo 'Flutter belum terdeteksi dalam PATH. Pasang Flutter SDK lebih dulu.' >&2
  exit 1
fi
if [ ! -f android/app/src/main/AndroidManifest.xml ]; then
  flutter create --platforms=android --project-name teman_memasak .
fi
if [ -f android/app/src/main/AndroidManifest.xml ]; then
  sed -i.bak 's/android:label="[^"]*"/android:label="Teman Memasak"/' android/app/src/main/AndroidManifest.xml
  rm -f android/app/src/main/AndroidManifest.xml.bak
fi
flutter pub get
echo 'Setup selesai. Buka proyek di Android Studio lalu jalankan pada emulator/perangkat.'
