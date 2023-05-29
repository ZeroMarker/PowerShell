# Get-Service
# Get-Process

function Hello {
    param (
        
    )
    Write-Host "Hello, PowerShell World!"
}
Hello

function Variables {
    param (
        
    )
    $var = 'hello'

    $number = 1

    $numbers = 1,3,5,8

    "$var"

    "$number"

    "$numbers"
}
Variables

function loop {
    param (
        
    )
    for ($i = 0; $i -lt $array.Count; $i++) {
        FunctionName
    }
}
loop
