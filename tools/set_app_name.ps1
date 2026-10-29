$manifest = Join-Path (Split-Path -Parent $PSScriptRoot) 'android\app\src\main\AndroidManifest.xml'
if (Test-Path $manifest) {
    $content = [System.IO.File]::ReadAllText($manifest)
    $content = $content -replace 'android:label="[^"]*"', 'android:label="Teman Memasak"'
    [System.IO.File]::WriteAllText($manifest, $content, (New-Object System.Text.UTF8Encoding($false)))
    Write-Host 'Nama aplikasi Android disetel menjadi Teman Memasak.'
}
