$env:Path

cd "$env:USERPROFILE\Desktop"

cd "$env:ProgramFiles"

cd "$env:windir"

%SystemRoot%

cd $env:SystemRoot

$system32 = Join-Path -Path $env:SystemRoot -ChildPath 'System32'

explorer.exe shell:RecycleBinFolder

