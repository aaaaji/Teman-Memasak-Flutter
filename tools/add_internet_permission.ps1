$ErrorActionPreference = 'Stop'
$manifest = Join-Path $PSScriptRoot '..\android\app\src\main\AndroidManifest.xml'
if (!(Test-Path $manifest)) { throw "AndroidManifest.xml tidak ditemukan: $manifest" }
$content = [System.IO.File]::ReadAllText($manifest)
if ($content -notmatch 'android.permission.INTERNET') {
  $content = [regex]::Replace($content, '<manifest\b[^>]*>', { param($m) $m.Value + "`r`n    <uses-permission android:name=`"android.permission.INTERNET`" />" }, 1)
  [System.IO.File]::WriteAllText($manifest, $content, (New-Object System.Text.UTF8Encoding $false))
  Write-Host 'Izin INTERNET ditambahkan.'
} else { Write-Host 'Izin INTERNET sudah ada.' }
