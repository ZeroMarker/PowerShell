# Define the folder path you want to add to the PATH variable
$newPath = "$env:userprofile\.cargo\bin"

# Retrieve the current value of the PATH variable
$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")

# Check if the folder is already in the PATH
if ($currentPath -notlike "*$newPath*") {
    # If not, add the folder to the PATH variable
    $newPath = $currentPath + ";" + $newPath
    [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
    Write-Host "Folder added to PATH variable."
} else {
    Write-Host "Folder already exists in PATH variable."
}
