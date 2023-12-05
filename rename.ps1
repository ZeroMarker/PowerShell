# Specify the path to the directory containing the folders
$directoryPath = Get-Location

# Get a list of folders in the directory
$folders = Get-ChildItem -Path $directoryPath -Directory

foreach ($folder in $folders) {
    # Get the current folder name
    $currentName = $folder.Name

    # Create the new folder name by converting to lowercase
    $newName = $currentName.ToLower()

    # Construct the new path
    $newPath = Join-Path $directoryPath $newName

    # Rename the folder
    Rename-Item -Path $folder.FullName -NewName $newName

    # Output the new folder path
    Write-Host "Folder renamed to: $newPath"
}
