# Get-Alias
gal ls

# which
(Get-Command code).Path
(gcm code).Path

# Remove empty Folders recursively
(gci "C:\dotnet-helpers\TEMP Folder" -r | ? {$_.PSIsContainer -eq $True}) | ?{$_.GetFileSystemInfos().Count -eq 0} | remove-item

xcopy C:\Source D:\Destination /E /H

