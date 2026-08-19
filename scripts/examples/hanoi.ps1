function Hanoi-Tower {
    param (
        [int]$n,
        [string]$source,
        [string]$target,
        [string]$auxiliary
    )

    if ($n -eq 1) {
        Write-Output "Move disk 1 from $source to $target"
        return
    }

    Hanoi-Tower -n ($n - 1) -source $source -auxiliary $target -target $auxiliary
    Write-Output "Move disk $n from $source to $target"
    Hanoi-Tower -n ($n - 1) -source $auxiliary -target $target -auxiliary $source
}

# Example usage
Hanoi-Tower -n 3 -source "A" -target "C" -auxiliary "B"
