param(
    [string]$GameDir = $env:CU_GAME_DIR
)

$ErrorActionPreference = "Stop"
$projectRoot = Split-Path -Parent $PSScriptRoot

if ([string]::IsNullOrWhiteSpace($GameDir)) {
    $GameDir = "steamapps\common\Casualties Unknown Demo"
}

$source = Join-Path $projectRoot "dist\CUCoreLib.KrokMP.SaveHotfix.dll"
$pluginsDir = Join-Path $GameDir "BepInEx\plugins"
$targetDir = Join-Path $pluginsDir "CUCoreLib.KrokMP.SaveHotfix"
$target = Join-Path $targetDir "CUCoreLib.KrokMP.SaveHotfix.dll"

if (-not (Test-Path $source)) {
    throw "找不到发布 DLL：$source。请先运行 scripts\build.ps1，或确认项目包中的 dist 文件完整。"
}
if (-not (Test-Path $pluginsDir)) {
    throw "找不到 BepInEx 插件目录：$pluginsDir"
}

# BepInEx identifies plugins by GUID and chooses among duplicate versions.
# Remove all earlier experimental/rebranded variants before installing 1.0.0.
$patterns = @(
    "CUCoreLib.KrokMP.InventoryHotfix*.dll",
    "CUCoreLib.KrokMP.PlayerSaveIsolationHotfix*.dll",
    "CUCoreLib.KrokMP.SaveSystemBypassHotfix*.dll",
    "CUCoreLib.KrokMP.SelectiveSaveHotfix*.dll",
    "CUCoreLib.KrokMP.SaveHotfix*.dll"
)
foreach ($pattern in $patterns) {
    Get-ChildItem -Path $pluginsDir -Filter $pattern -File -Recurse -ErrorAction SilentlyContinue |
        ForEach-Object {
            Write-Host "删除旧 DLL：$($_.FullName)"
            Remove-Item $_.FullName -Force
        }
}

$oldDirs = @(
    "CUCoreLib.KrokMP.InventoryHotfix",
    "CUCoreLib.KrokMP.PlayerSaveIsolationHotfix",
    "CUCoreLib.KrokMP.SaveSystemBypassHotfix",
    "CUCoreLib.KrokMP.SelectiveSaveHotfix",
    "CUCoreLib.KrokMP.SaveHotfix"
)
foreach ($name in $oldDirs) {
    $dir = Join-Path $pluginsDir $name
    if (Test-Path $dir) {
        Remove-Item $dir -Recurse -Force
    }
}

# Clear BepInEx type-loader cache so stale DLL metadata cannot be reused.
$cacheDir = Join-Path $GameDir "BepInEx\cache"
if (Test-Path $cacheDir) {
    Write-Host "清理 BepInEx 缓存：$cacheDir"
    Remove-Item $cacheDir -Recurse -Force
}

New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
Copy-Item $source $target -Force
Write-Host "安装完成：$target"
Write-Host "请确保主机和所有客户端均安装相同版本，并完全重启游戏。"
