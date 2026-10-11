@echo off
setlocal
where node >nul 2>nul
if errorlevel 1 (
  echo Node.js 18+ is required. Install it yourself, then reopen this launcher.
  echo No software or system settings have been changed.
  pause
  exit /b 1
)
node -e "process.exit(Number(process.versions.node.split('.')[0]) >= 18 ? 0 : 1)"
if errorlevel 1 (
  echo Node.js 18+ is required.
  pause
  exit /b 1
)
node "%~dp0serve.cjs" %*
pause
