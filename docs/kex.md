# Kali Win-KEX

Win-KEX (Windows Kali Desktop Experience) 用于在 WSL2 中运行 Kali Linux 桌面环境。

## 安装

```bash
sudo apt update && sudo apt install kali-win-kex
```

## 三种模式

### Window 模式（默认）

独立窗口中运行完整桌面。

```bash
kex
```

### Seamless 模式

Kali 应用无缝集成到 Windows 桌面，类似本地应用。

```bash
kex --sl
```

### Enhanced Session Mode (ESM)

基于 RDP 的增强会话，支持音频、剪贴板共享等。

```bash
kex --esm
```

## 常用参数

| 参数 | 说明 |
| ---|---|
| `--sl` | Seamless 模式 |
| `--esm` | Enhanced Session Mode |
| `--sound` | 启用音频（ESM 默认开启） |
| `--ip <addr>` | 指定监听 IP |
| `-s <resolution>` | 设置分辨率，如 `1920x1080` |
| `--kill` | 终止 KEX 会话 |

## 首次使用

```bash
kex --win -s 1920x1080
```

首次启动会要求设置 VNC 密码。

## 常见问题

- WSLg 已内置支持 X11/Wayland，简单 GUI 应用可直接运行，无需 KEX
- KEX 适合需要完整桌面环境的场景
- ESM 模式需要 Windows 上安装 FreeRDP（通常已自动处理）
