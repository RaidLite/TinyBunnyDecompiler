@echo off
set REPO_URL=https://github.com/CensoredUsername/unrpyc.git
set TEMP_DIR=unrpyc_build

echo [DEBUG] Checking environment...
where git >nul 2>nul || (echo [ERROR] Git not found & pause & exit /b)
where pip >nul 2>nul || (echo [ERROR] Pip not found & pause & exit /b)

echo [DEBUG] Cloning repository: %REPO_URL%
git clone %REPO_URL% %TEMP_DIR%

echo [DEBUG] Installing package...
cd %TEMP_DIR%
pip install .

echo [DEBUG] Cleaning up...
cd ..
rd /s /q %TEMP_DIR%

echo [DEBUG] Done.
pause