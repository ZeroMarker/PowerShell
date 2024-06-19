@echo off

:: Commented out lines for user input and directory creation
REM ::set /p path=please enter the folder of file that you want to delete:
REM ::md "%path%"

echo file deleting . . .

set "path=D:\BaiduNetdiskDownload"

for /r "%path%" %%a in (*) do del "%%a"

echo delete end!

pause
