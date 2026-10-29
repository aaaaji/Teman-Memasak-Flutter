@echo off
setlocal
cd /d "%~dp0"
echo [1/4] Membuat folder Android Flutter...
call flutter create . --platforms=android
if errorlevel 1 goto failed
echo [2/4] Menambahkan izin INTERNET pada AndroidManifest.xml...
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0tools\add_internet_permission.ps1"
if errorlevel 1 goto failed
echo [3/4] Mengambil dependencies...
call flutter pub get
if errorlevel 1 goto failed
echo [4/4] Selesai. Jalankan flutter run.
pause
exit /b 0
:failed
echo Setup gagal. Cek Flutter SDK dan gunakan terminal Android Studio.
pause
exit /b 1
