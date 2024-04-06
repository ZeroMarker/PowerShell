@echo off&setlocal EnableDelayedExpansion 
set a=1 
for /f "delims=" %%i in ('dir /b *.c') do ( 
    if not "%%~ni"=="%~n0" ( 
        if !a! LSS 10 (ren "%%i" "0!a!.c") else ren "%%i" "!a!.c" 
        set/a a+=1 
    ) 
)