function cut {
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$InputFile,

        [Parameter(Mandatory=$true, Position=1)]
        [string]$StartTime,

        [Parameter(Mandatory=$true, Position=2)]
        [string]$EndTime
    )

    # 文件名中用 start/end 替代时间码
    $ssLabel = if ($StartTime -eq 'start') { 'start' } else { $StartTime.Replace(':', '') }
    $toLabel = if ($EndTime -eq 'end') { 'end' } else { $EndTime.Replace(':', '') }
    $outputName = "$([System.IO.Path]::GetFileNameWithoutExtension($InputFile))_cut_${ssLabel}-${toLabel}$([System.IO.Path]::GetExtension($InputFile))"

    # 检测原始视频编码，选择合适的编码器
    $codec = & ffprobe -v error -select_streams v:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 $InputFile
    $venc = switch ($codec) {
        'h264'  { 'libx264'; break }
        'hevc'  { 'libx265'; break }
        'h265'  { 'libx265'; break }
        default { 'libx264' }
    }
    $crf = if ($venc -eq 'libx264') { 23 } else { 28 }

    # 拼接 ffmpeg 参数
    $ss = if ($StartTime -eq 'start') { '0' } else { $StartTime }
    $argsList = @('-y', '-ss', $ss, '-i', $InputFile)
    if ($EndTime -ne 'end') { $argsList += '-to'; $argsList += $EndTime }
    $argsList += '-c:v'; $argsList += $venc
    $argsList += '-crf'; $argsList += $crf
    $argsList += '-preset'; $argsList += 'fast'
    $argsList += '-c:a'; $argsList += 'aac'
    $argsList += $outputName

    Write-Host "裁剪: $InputFile"
    Write-Host "时间: $StartTime -> $EndTime"
    Write-Host "编码: $venc (crf=$crf)"
    Write-Host "输出: $outputName"

    & ffmpeg $argsList
}
