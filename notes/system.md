# 系统命令备忘

## 快捷键

| 操作 | 按键 |
|------|------|
| 打开终端（普通/管理员） | `Win + X` → `I` / `A` |
| 运行 | `Win + R` |
| 搜索 | `Win + C` / `S` / `Q` |
| 聚焦打开的窗口 | `Win + T` → 空格/回车 |
| 锁定 | `Win + L` |
| 设置 | `Win + I` |

## 常用程序

```powershell
code            # VS Code
wt              # Windows Terminal
psr             # 步骤记录器
notepad
mspaint
snippingtool
calc
winver
dxdiag
mstsc           # 远程桌面
wsl
msinfo32
perfmon
```

## 控制面板 & 系统工具

```powershell
ncpa.cpl        # 网络中心
chkdsk          # 磁盘检查
nslookup        # 名称解析
control         # 控制面板
dism
net session
optionalfeatures # 启用/关闭 Windows 功能
```

## 回收站

```powershell
explorer ::{645FF040-5081-101B-9F08-00AA002F954E}
# 或
explorer.exe shell:RecycleBinFolder
start shell:RecycleBinFolder
```

## 命令帮助 & 别名

```powershell
Get-Alias
gal ls

# 查看可执行文件路径
(Get-Command code).Path
(gcm code).Path
```

## 提权 & 电源

```powershell
start wt -verb runas           # 以管理员运行 Windows Terminal
start powershell -verb runas   # 以管理员运行 PowerShell
stop-computer
restart-computer
```

## 文件系统

```powershell
# 删除空文件夹（递归）
(gci "C:\dotnet-helpers\TEMP Folder" -r | ? {$_.PSIsContainer -eq $True}) | ?{$_.GetFileSystemInfos().Count -eq 0} | remove-item

# 复制目录结构
xcopy C:\Source D:\Destination /E /H

# NTFS 信息
fsutil fsInfo ntfsInfo C:
```

## 历史记录

```powershell
notepad (Get-PSReadLineOption).HistorySavePath
```

## Bash / sh

```powershell
# MinGW 或 WSL 中启动 bash
start sh.exe
bash
sh
```