# WSL 命令备忘

## 基础管理

```powershell
wsl --install
wsl --update
wsl --shutdown
wsl --status
wsl --version
```

## 配置

`config/wslconfig`（即 `~/.wslconfig`）：

```ini
[wsl2]
networkingMode=mirrored
dnsTunneling=true
firewall=true
autoProxy=true
```

## 访问 Windows 文件

```
\\wsl$          # 资源管理器访问 WSL 文件
```

## WSLg

```bash
# WSLg 内置支持 X11/Wayland，GUI 应用直接运行，例如：
firefox
```