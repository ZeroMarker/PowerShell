# PowerShell 自动计算时长分割 TS 文件
# 使用方法: .\this.ps1 [-InputFile] "input.ts" [-c "00:00:30,00:01:00"]
param(
    [Alias("f")]
    [Parameter(Mandatory = $true, Position = 0, HelpMessage = "输入视频文件路径")]
    [ValidateScript({ if (Test-Path $_) { $true } else { throw "找不到输入文件: $_" } })]
    [string]$InputFile,
   
    [Alias("c")]
    [Parameter(Mandatory = $false, HelpMessage = "截断点时间戳（逗号分隔，支持 HH:MM:SS 或秒数）")]
    [string]$CutPoints = ""
)

# ==================== 配置 ====================
# 截断点时间戳（格式 HH:MM:SS 或秒数），用逗号分隔
$cutPointArray = if ($CutPoints) { $CutPoints -split ',' | ForEach-Object { $_.Trim() } } else { @() }

# ==================== 主程序 ====================
# 生成输出前缀（原文件名 + _clip）
$baseName = [System.IO.Path]::GetFileNameWithoutExtension($InputFile)
$outputPrefix = "${baseName}_clip"

# 获取视频总时长（秒，使用 ffprobe 以提高准确性）
Write-Host "正在分析视频文件: $InputFile" -ForegroundColor Cyan
$ffprobeCmd = "ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 '$InputFile'"
$totalSeconds = Invoke-Expression $ffprobeCmd
if ($totalSeconds) {
    $totalSeconds = [math]::Round([double]$totalSeconds)
    $durationSpan = [timespan]::FromSeconds($totalSeconds)
    Write-Host "视频总时长: $($durationSpan.ToString('hh\:mm\:ss')) ($totalSeconds 秒)" -ForegroundColor Green
} else {
    Write-Host "警告: 无法获取视频时长，最后一个片段可能不准确" -ForegroundColor Yellow
    $totalSeconds = 86400 # 默认24小时
}

# 转换时间戳为秒数（支持小数秒）
function Convert-ToSeconds {
    param([string]$timeStr)
    if ($timeStr -match "^\d+(\.\d+)?$") {
        return [double]$timeStr
    }
    $parts = $timeStr -split ":"
    $seconds = 0.0
    if ($parts.Length -eq 3) {
        $seconds = [double]$parts[0] * 3600 + [double]$parts[1] * 60 + [double]$parts[2]
    } elseif ($parts.Length -eq 2) {
        $seconds = [double]$parts[0] * 60 + [double]$parts[1]
    } elseif ($parts.Length -eq 1) {
        $seconds = [double]$parts[0]
    } else {
        throw "无效的时间格式: $timeStr"
    }
    return $seconds
}

# 构建分段数组（排序并去重）
$cutPointsInSeconds = @($cutPointArray | Where-Object { $_ } | ForEach-Object { Convert-ToSeconds $_ } | Sort-Object -Unique)
$segmentStarts = @(0) + $cutPointsInSeconds
$segmentEnds = $cutPointsInSeconds + @($totalSeconds)

# 验证切割点递增
for ($i = 1; $i -lt $cutPointsInSeconds.Count; $i++) {
    if ($cutPointsInSeconds[$i] -le $cutPointsInSeconds[$i-1]) {
        Write-Error "错误: 切割点必须递增且唯一"
        exit 1
    }
}

# 处理每个片段
for ($i = 0; $i -lt $segmentStarts.Count; $i++) {
    $startSeconds = $segmentStarts[$i]
    $endSeconds = $segmentEnds[$i]
    $duration = $endSeconds - $startSeconds
   
    # 跳过无效片段
    if ($duration -le 0) {
        Write-Host "警告: 第 $($i+1) 片段时长无效，跳过" -ForegroundColor Yellow
        continue
    }
   
    $outputFile = "{0}{1:D3}.mp4" -f $outputPrefix, ($i + 1)
   
    Write-Host "`n[$($i+1)/$($segmentStarts.Count)] 分割: $outputFile" -ForegroundColor Yellow
    Write-Host " 开始: $([timespan]::FromSeconds($startSeconds).ToString('hh\:mm\:ss'))" -ForegroundColor Gray
    Write-Host " 结束: $([timespan]::FromSeconds($endSeconds).ToString('hh\:mm\:ss'))" -ForegroundColor Gray
    Write-Host " 时长: $([math]::Round($duration))秒" -ForegroundColor Gray
   
    # 执行 ffmpeg（添加错误处理）
    $ffmpegArgs = @(
        "-i", $InputFile,
        "-ss", $startSeconds,
        "-t", $duration,
        "-c:v", "libx264",
        "-c:a", "aac",
        "-preset", "medium",
        "-avoid_negative_ts", "make_zero",
        $outputFile
    )
    $process = Start-Process ffmpeg -ArgumentList $ffmpegArgs -NoNewWindow -Wait -PassThru -RedirectStandardError "ffmpeg_error.txt"
   
    if ($process.ExitCode -eq 0 -and (Test-Path $outputFile)) {
        $size = [math]::Round((Get-Item $outputFile).Length / 1MB, 2)
        Write-Host " ✓ 完成: $size MB" -ForegroundColor Green
    } else {
        Write-Host " ✗ 失败。检查 ffmpeg_error.txt 获取详情" -ForegroundColor Red
    }
}

Write-Host "`n✅ 全部分割完成！" -ForegroundColor Cyan