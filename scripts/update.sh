#!/bin/bash
echo "Starting backend update process..."
sleep 3
git checkout -- . 2>/dev/null
git pull origin master || { echo "[ERROR] git pull failed. Aborting update."; exit 1; }
npm install
npm run build
echo "Restarting server..."
if command -v pm2 &> /dev/null; then
    pm2 restart "antigravity-backend" 2>/dev/null || pm2 restart "antigravity-remote" 2>/dev/null || pm2 restart "AntigravityBackend" 2>/dev/null || nohup npm run start >/dev/null 2>&1 &
else
    nohup npm run start >/dev/null 2>&1 &
fi
