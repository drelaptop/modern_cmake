Set-PSDebug -Trace 1

$env:ANDROID_NDK_HOME=$env:APPVEYOR_BUILD_FOLDER + "\..\android-ndk-r16b"
$env:NDK_ROOT=$env:APPVEYOR_BUILD_FOLDER + "\..\android-ndk-r16b"
$env:ANDROID_NDK_ROOT=$env:APPVEYOR_BUILD_FOLDER + "\..\android-ndk-r16b"

$env:ANDROID_SDK_ROOT=$env:APPVEYOR_BUILD_FOLDER + "\..\android-sdk"
$env:ANDROID_HOME=$env:APPVEYOR_BUILD_FOLDER + "\..\android-sdk"


Write-Host "PATH"
Write-Host "$env:PATH"

If ($env:build_type -eq "android_lib") {
    & mkdir $env:APPVEYOR_BUILD_FOLDER\build
    # if ($lastexitcode -ne 0) {throw}
    Push-Location $env:APPVEYOR_BUILD_FOLDER\build
    & cmake .. -DCMAKE_TOOLCHAIN_FILE="$env:APPVEYOR_BUILD_FOLDER\tools\android_arm_toolchain.cmake" -G Ninja
    if ($lastexitcode -ne 0) {throw}
    & cmake --build .
    if ($lastexitcode -ne 0) {throw}
    Pop-Location
} elseif ($env:build_type -eq "android_game12") {
    Push-Location $env:APPVEYOR_BUILD_FOLDER\game1\android
    & ./gradlew assembleRelease
    if ($lastexitcode -ne 0) {throw}

    Push-Location $env:APPVEYOR_BUILD_FOLDER\game2\android
    & ./gradlew assembleRelease
    if ($lastexitcode -ne 0) {throw}

} Else {
    & mkdir $env:APPVEYOR_BUILD_FOLDER\build
    # if ($lastexitcode -ne 0) {throw}
    Push-Location $env:APPVEYOR_BUILD_FOLDER\build
    & cmake ..
    if ($lastexitcode -ne 0) {throw}
    & cmake --build .
    if ($lastexitcode -ne 0) {throw}
    Pop-Location
    
}




