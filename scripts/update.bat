@echo off
echo Starting backend update process...
ping 127.0.0.1 -n 4 > nul
git checkout -- . 2>nul
git pull origin master
if %ERRORLEVEL% neq 0 (
    echo [ERROR] git pull failed or encountered conflicts. Aborting update.
    exit /b %ERRORLEVEL%
)
call npm install
call npm run build
echo Restarting server...
where pm2 >nul 2>nul
if %ERRORLEVEL% equ 0 (
    pm2 restart "antigravity-backend" 2>nul || pm2 restart "antigravity-remote" 2>nul || pm2 restart "AntigravityBackend" 2>nul || start "" npm run start
) else (
    start "" npm run start
)
