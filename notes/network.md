# 网络命令备忘

## 基础诊断

```powershell
hostname

ipconfig

netstat -a -n        # 查看端口监听
```

## 路由

```powershell
route add 192.168.2.0 mask 255.255.255.0 192.168.8.7 -p
```

## 追踪

```powershell
tracert 192.168.2.7
tracert baidu.com
```

## 下载

```powershell
# PowerShell
$source = 'http://speedtest.tele2.net/10MB.zip'
$destination = '.\download\10MB.zip'
Invoke-WebRequest -Uri $source -OutFile $destination

# curl / wget 亦可
curl -O https://baidu.com/01.jpg
wget
curl
```

## HTTP 调试

```powershell
curl https://missing.csail.mit.edu | findstr "StatusCode"
curl -i http://localhost:8080/api/v1/movies
```

## SSH

```bash
# 服务器别名见 config/ssh-config（gcp、ali）
ssh ali
```

> ⚠️ 注意：原 `network/ssh-ali.ps1` 中包含明文 SSH 密码，已从仓库移除跟踪。
> 如需免密登录，请改用 `ssh-keygen` + `ssh-copy-id` 配置公钥。