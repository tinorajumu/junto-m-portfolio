@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

cd /d "%~dp0"

echo ============================================
echo  junto-m-portfolio - GitHub Pages deploy
echo ============================================

where git >nul 2>nul
if errorlevel 1 (
  echo [ERROR] git not found in PATH.
  pause
  exit /b 1
)

where gh >nul 2>nul
if errorlevel 1 (
  echo [ERROR] GitHub CLI ^(gh^) not found in PATH.
  pause
  exit /b 1
)

echo.
echo Switching GitHub account to tinorajumu...
gh auth switch --hostname github.com --user tinorajumu
if errorlevel 1 (
  echo [ERROR] Could not switch to tinorajumu account. Run "gh auth login" first.
  pause
  exit /b 1
)

git status --short
echo.
set COMMIT_MSG=Update portfolio - %date% %time%
echo Commit message: %COMMIT_MSG%

git add -A
git commit -m "%COMMIT_MSG%"
if errorlevel 1 (
  echo No changes to commit, or commit failed. Continuing to push anyway...
)

git push origin main
if errorlevel 1 (
  echo [ERROR] git push failed.
  pause
  exit /b 1
)

echo.
echo ============================================
echo  Deployed. GitHub Pages may take a minute:
echo  https://tinorajumu.github.io/junto-m-portfolio/
echo ============================================
pause
