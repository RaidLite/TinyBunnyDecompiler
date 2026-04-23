@echo off
setlocal

set "ARCHIVE_PATH=C:\Program Files (x86)\Tiny Bunny\game\archive.rpa"
set "OUT_DIR=D:\game"

python rpatool.py -x "%ARCHIVE_PATH%" -o "%OUT_DIR%"
python -m unrpyc -c "%OUT_DIR%"

echo Removing compiled files...
for /r "%OUT_DIR%" %%f in (*.rpyc *.rpymc) do del "%%f"

echo Done!
pause