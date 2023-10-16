:: for /L %i in (1,1,254) do @ping -n 1 -w 1 192.168.1.%i | find "Reply"
@echo off
for /L %%i in (0,1,255) do (
    for /L %%j in (0,1,255) do (
        ping -n 1 -w 1 192.168.%%i.%%j | find "Reply" REM "来自" encoding=gbk
    )
)
