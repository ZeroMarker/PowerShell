# PowerShell

PowerShell 学习与环境配置仓库：命令备忘、配置文件和使用文档。

## 教程资源

- [【微软官方】PowerShell 3.0 教程](https://www.bilibili.com/video/BV1Bx411g7gD/)
- [PowerShell For Beginners Full Course](https://www.youtube.com/watch?v=UVUd9_k9C6A)
- [Batch Script Tutorial](https://www.tutorialspoint.com/batch_script/index.htm)
- [Beginner PowerShell 7 Tutorials](https://www.youtube.com/playlist?list=PLnK11SQMNnE4vcvuAahz4KhNOS7zOfmB3)

## 项目结构

```
PowerShell/
├── profile/     # PowerShell 配置文件（$PROFILE、Add-ToUserPath 等）
├── notes/       # 命令备忘（按主题：env/file/network/system/wsl/rookie）
├── docs/        # 教程与方案：posh、kex、explorer
└── config/      # 配置文件：wslconfig（WSL2）、ssh-config（SSH 别名）
```

## 快速开始

```powershell
# 加载 PowerShell profile
. .\profile\Microsoft.PowerShell_profile.ps1
```

## 地图速查

| 想做什么 | 去哪 |
|----------|------|
| 文件批量操作 | `notes/file.md` |
| 网络诊断 / 下载 | `notes/network.md` |
| 系统工具 / 快捷键 | `notes/system.md` |
| PowerShell 入门示例 | `notes/rookie.md` |
| 美化终端 (oh-my-posh) | `docs/posh.md` |
| WSL / Kali Win-KEX | `notes/wsl.md`、`docs/kex.md` |
