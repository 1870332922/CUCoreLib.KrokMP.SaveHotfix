param(
    [string]$GameDir = $env:CU_GAME_DIR,
    [ValidateSet("Debug", "Release")]
    [string]$Configuration = "Release"
)

$ErrorActionPreference = "Stop"
$projectRoot = Split-Path -Parent $PSScriptRoot
$project = Join-Path $projectRoot "src\CUCoreLib.KrokMP.SaveHotfix\CUCoreLib.KrokMP.SaveHotfix.csproj"

if ([string]::IsNullOrWhiteSpace($GameDir)) {
    $GameDir = "steamapps\common\Casualties Unknown Demo"
}

Write-Host "GameDir: $GameDir"
Write-Host "Configuration: $Configuration"

dotnet build $project -c $Configuration -p:GameDir="$GameDir"
if ($LASTEXITCODE -ne 0) {
    throw "dotnet build 失败，退出代码：$LASTEXITCODE"
}

# Internal identity intentionally remains the tested SaveSystemBypassHotfix name.
$output = Join-Path $projectRoot "src\CUCoreLib.KrokMP.SaveHotfix\bin\$Configuration\CUCoreLib.KrokMP.SaveSystemBypassHotfix.dll"
$dist = Join-Path $projectRoot "dist\CUCoreLib.KrokMP.SaveHotfix.dll"

if (-not (Test-Path $output)) {
    throw "编译完成后未找到输出文件：$output"
}

Copy-Item $output $dist -Force
Write-Host "已生成：$dist"
