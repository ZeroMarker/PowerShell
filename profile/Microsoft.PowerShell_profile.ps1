oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\atomic.omp.json" | Invoke-Expression
#f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

Import-Module -Name Microsoft.WinGet.CommandNotFound
#f45873b3-b655-43a6-b217-97c00aa0db58

function get-meta-info {
    param(
        [Parameter(ValueFromRemainingArguments=$true)]
        $Arguments
    )
    
    # 您的脚本逻辑
    Write-Host "正在获取元信息..."
    
    # 示例：获取文件或系统信息
    $path = if ($Arguments) { $Arguments[0] } else { "." }
    
    Get-ChildItem $path | Select-Object Name, Length, LastWriteTime, Extension
}

function arch {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [string]$Path
    )

    begin {
        # begin 块在这里不需要检查 $Path，因为 Mandatory=$true 已经确保有值
    }

    process {
        # 获取完整路径并规范化
        $fullPath = Resolve-Path -LiteralPath $Path -ErrorAction SilentlyContinue
        if (-not $fullPath) {
            Write-Host "❌ 找不到文件: $Path" -ForegroundColor Red
            return
        }

        $item = Get-Item -LiteralPath $fullPath
        if (-not $item -or $item.PSIsContainer) {
            Write-Host "❌ 不是文件或文件不存在: $Path" -ForegroundColor Red
            return
        }

        # 获取所在目录
        $directory = $item.DirectoryName

        # 把路径转成 点号分隔的风格
        # C:\Users\xxx\Desktop\test.txt → C.Users.xxx.Desktop.test.txt
        $drive = $item.PSDrive.Name
        $relative = $item.FullName.Substring($item.PSDrive.Root.Length).TrimStart('\')
        $dottedPath = $relative -replace '\\', '.'

        # 新文件名 = 盘符 + 路径各层 + 原文件名（包含扩展名）
        # 注意：这里不需要再加扩展名，因为 $dottedPath 已经包含了文件名
        $newName = "${drive}.${dottedPath}"
        $newFullPath = Join-Path $directory $newName

        # 检查目标是否已存在
        if (Test-Path -LiteralPath $newFullPath) {
            $confirm = Read-Host "⚠️  文件已存在: $newName`n是否覆盖? (y/N)"
            if ($confirm -ne 'y') {
                Write-Host "❌ 操作已取消" -ForegroundColor Yellow
                return
            }
        }

        # 执行复制（保留元数据）
        try {
            Copy-Item -LiteralPath $item.FullName -Destination $newFullPath -Force
            Write-Host "✅ 已创建: " -NoNewline -ForegroundColor Green
            Write-Host "$newName" -ForegroundColor Cyan
            Write-Host "   位置: $directory" -ForegroundColor Gray
        }
        catch {
            Write-Host "❌ 复制失败: $($_.Exception.Message)" -ForegroundColor Red
        }
    }

    end {
        # 可选：批量处理后的总结
    }
}
# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

function Add-ToUserPath {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Path,
        
        [switch]$Force
    )
    
    $resolvedPath = (Resolve-Path $Path -ErrorAction SilentlyContinue).Path
    if (!$resolvedPath) {
        Write-Error "路径不存在: $Path"
        return
    }
    
    $userPath = [Environment]::GetEnvironmentVariable("Path", "User")
    
    if ($userPath -like "*$resolvedPath*" -and !$Force) {
        Write-Host "✓ 路径已存在: $resolvedPath" -ForegroundColor Yellow
        return
    }
    
    [Environment]::SetEnvironmentVariable("Path", "$userPath;$resolvedPath", "User")
    $env:Path += ";$resolvedPath"
    Write-Host "✓ 已添加到用户Path: $resolvedPath" -ForegroundColor Green
}

# 使用示例:
# Add-ToUserPath "C:\Users\ttft3\AppData\Local\UniGetUI\Chocolatey\lib\elixir\tools\bin"
# Add-ToUserPath "C:\tools" -Force

(&mise activate pwsh) | Out-String | Invoke-Expression

function cut {
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$InputFile,

        [Parameter(Mandatory=$true, Position=1)]
        [string]$StartTime,

        [Parameter(Mandatory=$true, Position=2)]
        [string]$EndTime
    )

    $outputName = "$([System.IO.Path]::GetFileNameWithoutExtension($InputFile))_cut_$($StartTime.Replace(':', ''))-$($EndTime.Replace(':', ''))$([System.IO.Path]::GetExtension($InputFile))"

    ffmpeg -i $InputFile -ss $StartTime -to $EndTime -c copy $outputName
}
