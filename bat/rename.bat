@echo off

REM Set the directory path where .md files are located
set "path=D:\coding\root"

REM Output a message indicating the start of the renaming process
echo start rename files

REM Loop through all .md files recursively in the specified directory and its subdirectories
for /r "%path%" %%a in (*.md) do (
    REM Rename each .md file to .json format
    ren "%%a" "%%~na.json"
    REM filename without extension
)

REM Output a message indicating the end of the renaming process
echo end!

REM Pause the script to keep the console window open so you can review the messages
pause
