param(
    [string]$GameDir = $env:CU_GAME_DIR
)

$ErrorActionPreference = "Stop"
if ([string]::IsNullOrWhiteSpace($GameDir)) {
    $GameDir = "steamapps\common\Casualties Unknown Demo"
}

$targetDir = Join-Path $GameDir "BepInEx\plugins\CUCoreLib.KrokMP.SaveHotfix"
if (Test-Path $targetDir) {
    Remove-Item $targetDir -Recurse -Force
    Write-Host "已卸载：$targetDir"
} else {
    Write-Host "未找到安装目录：$targetDir"
}

$cacheDir = Join-Path $GameDir "BepInEx\cache"
if (Test-Path $cacheDir) {
    Remove-Item $cacheDir -Recurse -Force
    Write-Host "已清理 BepInEx 缓存。"
}
