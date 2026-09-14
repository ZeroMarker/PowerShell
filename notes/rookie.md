# PowerShell 入门命令备忘

## 版本与系统信息

```powershell
$PSVersionTable.PSVersion
Get-Service
Get-Date
Get-Command -Noun Service
```

## 常用函数示例

```powershell
function Hello {
    Write-Host "Hello, PowerShell World!"
}
Hello

function Variables {
    $var = 'hello'
    $number = 1
    $numbers = 1,3,5,8

    "$var"     # 打印变量
    "$number"
    "$numbers"
}
Variables

function loop {
    for ($i = 0; $i -lt $array.Count; $i++) {
        FunctionName
    }
}
loop
```

## 示例

本文件中的函数示例可直接复制到 PowerShell 中练习。
