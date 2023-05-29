@echo off

path=D:\coding\root

echo start rename files

for /r "%path%" %%a in (*.md)do ren "%%a" "*.json"

echo end!

pause 