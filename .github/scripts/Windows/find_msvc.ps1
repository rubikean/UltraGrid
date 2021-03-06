#Set-PSDebug -Trace 1

# Find VS
$vswhere = "${Env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"
$installDir = & $vswhere -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath
if (-Not $installDir) {
  throw "Vswhere failed"
}
$path = join-path $installDir 'VC\Auxiliary\Build\Microsoft.VCToolsVersion.default.txt'
$pathPresent = test-path $path
if (-Not $pathPresent) {
  throw "MSVS not found"
}
$version = gc -raw $path
if (-Not $version) {
  throw "Cannot get MSVS version"
}
$version = $version.Trim()
echo "$installDir\VC\Tools\MSVC\$version\bin\HostX64\x64" >> ${env:GITHUB_PATH} # cl
echo "$installDir\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin" >> ${env:GITHUB_PATH}
echo "$installDir\MSBuild\Current\Bin" >> ${env:GITHUB_PATH}

