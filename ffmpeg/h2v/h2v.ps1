# 横屏转竖屏，支持偏移量参数
# 用法: .\h2v.ps1 [偏移量]  偏移量: 0.0(最左) ~ 1.0(最右)，默认0.5(居中)

param(
    [double]$Offset = 0.5
)

if ($Offset -lt 0 -or $Offset -gt 1) {
    Write-Error "偏移量必须在 0.0 到 1.0 之间"
    exit 1
}

mkdir -p vertical

for ($i = 0; $i -lt $args.Count; $i++) {
    # skip if not a file
}

foreach ($f in Get-ChildItem -Filter *.mp4) {
    Write-Host "处理: $($f.Name) (偏移: $Offset)"
    ffmpeg -i $f.FullName -vf "scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920:(in_w-1080)*${Offset}:(in_h-1920)/2" -c:a copy "vertical/$($f.BaseName)_竖屏.mp4"
}
