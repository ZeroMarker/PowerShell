# PowerShell

PowerShell 学习与工具脚本仓库：命令备忘、可直接运行的工具脚本、配置文件。

## 教程资源

- [【微软官方】PowerShell 3.0 教程](https://www.bilibili.com/video/BV1Bx411g7gD/)
- [PowerShell For Beginners Full Course](https://www.youtube.com/watch?v=UVUd9_k9C6A)
- [Batch Script Tutorial](https://www.tutorialspoint.com/batch_script/index.htm)
- [Beginner PowerShell 7 Tutorials](https://www.youtube.com/playlist?list=PLnK11SQMNnE4vcvuAahz4KhNOS7zOfmB3)

## 项目结构

```
PowerShell/
├── profile/     # PowerShell 配置文件（$PROFILE、Add-ToUserPath 等）
├── scripts/     # 可执行工具脚本
│   ├── file/      # 文件操作：rename（批量小写化）、zip（压缩别名）
│   ├── git/       # git 批量提交
│   ├── env/       # 环境变量：add-path（幂等添加 PATH）
│   └── examples/  # 学习示例：hanoi（汉诺塔）、meta（语法练习）
├── notes/       # 命令备忘（按主题：env/file/network/system/wsl/rookie）
├── docs/        # 教程与方案：posh、kex、explorer
└── config/      # 配置文件：wslconfig（WSL2）、ssh-config（SSH 别名）
```

## 快速开始

```powershell
# 加载全部 profile 工具
. .\profile\Microsoft.PowerShell_profile.ps1

# 批量重命名当前目录文件夹为小写
.\scripts\file\rename.ps1

# 幂等添加目录到用户 PATH
.\scripts\env\add-path.ps1
```

## 地图速查

| 想做什么 | 去哪 |
|----------|------|
| 文件批量操作 | `scripts/file/`、`notes/file.md` |
| 网络诊断 / 下载 | `notes/network.md` |
| 系统工具 / 快捷键 | `notes/system.md` |
| PowerShell 入门示例 | `scripts/examples/`、`notes/rookie.md` |
| 美化终端 (oh-my-posh) | `docs/posh.md` |
| WSL / Kali Win-KEX | `notes/wsl.md`、`docs/kex.md` |