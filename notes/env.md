# 环境变量

## 查看与导航

```powershell
$env:Path

cd "$env:USERPROFILE\Desktop"
cd "$env:ProgramFiles"
cd "$env:windir"
cd $env:SystemRoot
%SystemRoot%

$system32 = Join-Path -Path $env:SystemRoot -ChildPath 'System32'

$env:APPDATA\Docker\settings.json

%USERPROFILE%
```

## 编辑

```powershell
# 打开系统环境变量编辑器
rundll32 sysdm.cpl,EditEnvironmentVariables
```

## 持久化设置

```powershell
# 添加路径到用户级 PATH
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\bin", "User")
```

## 参考脚本

```powershell
# scripts/env/add-path.ps1
# 检查路径是否已在用户 PATH，不存在则追加（带幂等保护）
$newPath = "$env:userprofile\.cargo\bin"
$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($currentPath -notlike "*$newPath*") {
    $newPath = $currentPath + ";" + $newPath
    [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
    Write-Host "Folder added to PATH variable."
} else {
    Write-Host "Folder already exists in PATH variable."
}
```

## 参考文件

- `profile/addToPath.ps1` — `Add-ToUserPath` 函数（带路径校验、幂等、`-Force` 覆盖）