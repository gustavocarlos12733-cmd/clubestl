# Script para preparar o projeto para upload no GitHub
Write-Host "🧹 Limpando projeto para upload no GitHub..." -ForegroundColor Green

# Remover pastas desnecessárias
$foldersToRemove = @(
    "node_modules",
    ".next",
    ".vercel",
    "dist",
    "build",
    "out"
)

foreach ($folder in $foldersToRemove) {
    if (Test-Path $folder) {
        Write-Host "Removendo: $folder" -ForegroundColor Yellow
        Remove-Item -Recurse -Force $folder
    }
}

# Remover arquivos de cache
$cacheFiles = Get-ChildItem -Recurse -Name "*.log", "*.cache", "*.tmp", "*.temp"
foreach ($file in $cacheFiles) {
    Write-Host "Removendo arquivo de cache: $file" -ForegroundColor Yellow
    Remove-Item -Force $file -ErrorAction SilentlyContinue
}

# Remover arquivos específicos do Windows
$windowsFiles = Get-ChildItem -Recurse -Name "Thumbs.db", "desktop.ini", "*.swp", "*.swo"
foreach ($file in $windowsFiles) {
    Write-Host "Removendo arquivo do Windows: $file" -ForegroundColor Yellow
    Remove-Item -Force $file -ErrorAction SilentlyContinue
}

Write-Host "✅ Projeto limpo! Agora você pode fazer upload no GitHub." -ForegroundColor Green
Write-Host "📦 Tamanho atual do projeto:" -ForegroundColor Cyan

# Calcular tamanho do projeto
$totalSize = (Get-ChildItem -Recurse | Measure-Object -Property Length -Sum).Sum
$sizeInMB = [math]::Round($totalSize / 1MB, 2)
Write-Host "Tamanho total: $sizeInMB MB" -ForegroundColor Cyan

Write-Host "`n📋 Próximos passos:" -ForegroundColor Magenta
Write-Host "1. Faça upload dos arquivos no GitHub" -ForegroundColor White
Write-Host "2. No Vercel, conecte o repositório GitHub" -ForegroundColor White
Write-Host "3. Configure as variáveis de ambiente no Vercel" -ForegroundColor White
Write-Host "4. Faça o deploy!" -ForegroundColor White
