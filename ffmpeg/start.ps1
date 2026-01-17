# 1. 创建目标文件夹
New-Item -ItemType Directory -Force -Path converted_images

# 2. 批量转换所有 webp 文件
Get-ChildItem *.webp | ForEach-Object {
  ffmpeg -i $_.FullName -q:v 2 "converted_images\$($_.BaseName).jpg"
}


