@echo off
nasm -f win64 ./asm/TinyBunnyDecompiler.asm -o TinyBunnyDecompiler.obj
gcc TinyBunnyDecompiler.obj -o TinyBunnyDecompiler.exe -mconsole
del TinyBunnyDecompiler.obj