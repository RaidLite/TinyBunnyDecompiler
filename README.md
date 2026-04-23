# `TinyBunnyDecompiler`

A tool for decompiling the game `TinyBunny`, including scripts and assets.

## `Requirements`
- `Python 3.10+` (tested on 3.14, but it must work on a lower version)
- A `D:\` drive on your system (If you don’t have one, modify `decompile.bat` accordingly)
- `Git`
- `Windows 10+`

## `Compiling`
To compile programm, you need to install NASM and add it to your system's PATH and run `compile.bat`

## `Usage`
### Variant 1: With console programm
1. Make sure the game is installed at:  
   `C:\Program Files (x86)\Tiny Bunny\game\`  
   If not, edit `TinyBunnyDecompiler.exe` and set the correct path in the same format.

2. Run `TinyBunnyDecompiler.exe` and choose install unrpyc or decompile (you can read second variant where is it all written down).  
   Decompiled files will be available at: `D:\game`

### Variant 2: With batch files
1. Make sure the game is installed at:  
   `C:\Program Files (x86)\Tiny Bunny\game\`  
   If not, edit `decompile.bat` and set the correct path in the same format.

2. Run `install_unrpyc.bat` (only once) to install **unrpyc**, which is required for script decompilation.

3. Run `decompile.bat`, wait for the process to finish, then press Enter.  
   Decompiled files will be available at: `D:\game`

#