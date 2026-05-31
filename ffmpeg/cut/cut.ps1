# 视频裁剪工具
# 用法: .\cut.ps1 <输入文件> <开始时间> <结束时间>
# 示例: .\cut.ps1 video.mp4 00:01:30 00:03:45

param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$InputFile,

    [Parameter(Mandatory=$true, Position=1)]
    [string]$StartTime,

    [Parameter(Mandatory=$true, Position=2)]
    [string]$EndTime
)

if (-not (Test-Path $InputFile)) {
    Write-Error "文件不存在: $InputFile"
    exit 1
}

$dir = [System.IO.Path]::GetDirectoryName($InputFile)
$name = [System.IO.Path]::GetFileNameWithoutExtension($InputFile)
$ext = [System.IO.Path]::GetExtension($InputFile)
$startClean = $StartTime.Replace(':', '')
$endClean = $EndTime.Replace(':', '')

$outputName = if ($dir) { "$dir\${name}_cut_${startClean}-${endClean}${ext}" } else { "${name}_cut_${startClean}-${endClean}${ext}" }

Write-Host "裁剪: $InputFile"
Write-Host "时间: $StartTime -> $EndTime"
Write-Host "输出: $outputName"

ffmpeg -i $InputFile -ss $StartTime -to $EndTime -c copy $outputName
