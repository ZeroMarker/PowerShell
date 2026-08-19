# 文件操作命令备忘

## 基础操作

```powershell
# 打开（Invoke-Item）
ii file

# 创建 & 编辑（New-Item）
ni script.ts

# 查找（-s = -Recurse）
gci './path*/' -s -Include 'name*'
ls './path*/' -s -Include 'name*'
```

## 删除

```powershell
# 递归强制删除
Remove-Item Threads -Recurse -Force
rm .\Douyin\ -r -fo
```

## 移动

```powershell
# 递归移动某类文件到目标目录
Get-ChildItem -Path . -Recurse -Filter *.jpg | Move-Item -Destination C:\Path\To\Your\Destination\Folder
```

## 重定向

```powershell
cd . > hello.java
type nul > hello.java
echo nul > hello.java
```

## 编码

```powershell
chcp                    # 更改代码页
intl.cpl                # 区域设置
```

## 文件信息

```powershell
# Git Bash / WSL: file 命令
file *                  # 查看文件类型
file --mime-encoding *  # 查看文件编码
```

## 图片

```powershell
magick identify your-icon.ico   # ImageMagick 识别图片信息
```

## 压缩

在 `scripts/file/zip.ps1` 中定义了别名：

```powershell
Set-Alias zip Compress-Archive
Set-Alias unzip Expand-Archive
zip store store.zip
```

## 一次性任务示例

将 `sourceFolder` 的目录结构递归复制到 `targetFolder`，文件生成同名 `.txt`（非拷贝内容）：

```powershell
$sourceFolder = "C:\Users\ttft3\Downloads\马世梅-转正材料"
$targetFolder = "D:\Users\ttft3\Desktop\target"

New-Item -ItemType Directory -Path $targetFolder -Force | Out-Null

Get-ChildItem -Path $sourceFolder -Recurse | ForEach-Object {
    $relativePath = $_.FullName.Substring($sourceFolder.Length)
    $targetPath = Join-Path $targetFolder $relativePath

    if ($_.PSIsContainer) {
        New-Item -ItemType Directory -Path $targetPath -Force | Out-Null
    } else {
        $newTxtFile = $targetPath + ".txt"
        New-Item -ItemType File -Path $newTxtFile -Force
    }
}
```

WSL bash 版同理（`xcopy.sh`，已并入本文档）：`find` + `mkdir`/`touch`。