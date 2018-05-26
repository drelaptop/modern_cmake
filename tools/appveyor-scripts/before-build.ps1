Set-PSDebug -Trace 1
$python = "C:\\Python27\\python.exe"

function Update-SubModule
{
    Push-Location $env:APPVEYOR_BUILD_FOLDER
    & git submodule init
    & git submodule update --recursive --depth=1
    Pop-Location
}

if ($env:build_type -like "android*") {
    & choco install ninja
    & $python -u .\tools\appveyor-scripts\setup_android.py --ndk_only
    if ($lastexitcode -ne 0) {throw}
}

