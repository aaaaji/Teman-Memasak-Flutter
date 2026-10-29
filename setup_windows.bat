@echo off
setlocal
cd /d "%~dp0"
where flutter >nul 2>nul
if errorlevel 1 (
  echo [ERROR] Flutter belum terdeteksi di PATH.
  echo Install Flutter SDK dan aktifkan Flutter plugin di Android Studio.
  pause
  exit /b 1
)
if not exist "android\app\src\main\AndroidManifest.xml" (
  echo Membuat folder android sesuai Flutter SDK di komputer ini...
  call flutter create --platforms=android --project-name teman_memasak .
  if errorlevel 1 (
    echo Gagal membuat konfigurasi Android.
    pause
    exit /b 1
  )
)
powershell -NoProfile -ExecutionPolicy Bypass -File "tools\set_app_name.ps1"
call flutter pub get
if errorlevel 1 (
  echo Gagal mengambil dependensi Flutter.
  pause
  exit /b 1
)
echo.
echo Setup berhasil. Buka proyek di Android Studio, pilih emulator, lalu klik Run.
pause
