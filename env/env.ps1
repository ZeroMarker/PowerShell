$env:Path

cd "$env:USERPROFILE\Desktop"

cd "$env:ProgramFiles"

cd "$env:windir"

%SystemRoot%

cd $env:SystemRoot

$system32 = Join-Path -Path $env:SystemRoot -ChildPath 'System32'

explorer.exe shell:RecycleBinFolder

$env:APPDATA\Docker\settings.json

%USERPROFILE%

[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\bin", "User")