# 设置source文件夹路径
# Get-Location $sourceFolder.Path.Length
$sourceFolder = "C:\Users\ttft3\Downloads\马世梅-转正材料"

# 设置target文件夹路径
$targetFolder = "D:\Users\ttft3\Desktop\target"

# 在开始时创建target文件夹
New-Item -ItemType Directory -Path $targetFolder -Force | Out-Null

# 递归遍历source文件夹
Get-ChildItem -Path $sourceFolder -Recurse | ForEach-Object {
    # 构建目标路径
    $relativePath = $_.FullName.Substring($sourceFolder.Length)
    $targetPath = Join-Path $targetFolder $relativePath

    if ($_.PSIsContainer) {
        # 如果是文件夹，递归创建目标文件夹
        New-Item -ItemType Directory -Path $targetPath -Force | Out-Null
    } else {
        # 如果是文件，生成空白txt文件
        $newTxtFile = $targetPath + ".txt"
        New-Item -ItemType File -Path $newTxtFile -Force
    }
}
