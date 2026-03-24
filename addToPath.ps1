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