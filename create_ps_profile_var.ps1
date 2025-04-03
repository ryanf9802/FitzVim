$envPath = Join-Path $HOME "AppData\Local\nvim"
$targetLine = '$NVIM = "' + $envPath + '"'

$profilePath = $PROFILE

if (-not (Test-Path $profilePath)) {
    New-Item -ItemType File -Path $profilePath -Force | Out-Null
}

$profileContent = Get-Content $profilePath -Raw

if ($profileContent -match '^\s*\$NVIM\s*=') {
    Write-Host "`$NVIM has already been set." -ForegroundColor Yellow
} else {
    Add-Content -Path $profilePath -Value "`n$targetLine"
    Write-Host "Set `$NVIM=$envPath" -ForegroundColor Green
}

