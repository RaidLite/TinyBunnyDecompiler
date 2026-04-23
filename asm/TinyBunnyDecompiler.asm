default rel

section .data
    menu_text db "--- TinyBunnyDecompiler ---", 10, 13, \
                "1. Install unrpyc", 10, 13, \
                "2. Decompile", 10, 13, \
                "Select (1-2): ", 0
    menu_len  equ $ - menu_text
    bat_install   db "install_unrpyc.bat", 0
    bat_decompile db "decompile.bat", 0
    err_msg    db "Invalid choice!", 10, 13, 0
    err_len    equ $ - err_msg

section .bss
    stdin_h    resq 1
    stdout_h   resq 1
    buffer     resb 8
    bytes_read resd 1

section .text
    extern GetStdHandle
    extern WriteFile
    extern ReadFile
    extern WinExec
    extern ExitProcess
    global main

main:
    sub rsp, 40
    
    mov rcx, -11
    call GetStdHandle
    mov [stdout_h], rax
    
    mov rcx, -10
    call GetStdHandle
    mov [stdin_h], rax

show_menu:
    mov rcx, [stdout_h]
    lea rdx, [menu_text]
    mov r8d, menu_len
    lea r9, [bytes_read]
    mov qword [rsp + 32], 0
    call WriteFile

    mov rcx, [stdin_h]
    lea rdx, [buffer]
    mov r8d, 2
    lea r9, [bytes_read]
    mov qword [rsp + 32], 0
    call ReadFile

    lea rax, [buffer]
    mov al, [rax]
    
    cmp al, '1'
    je run_install
    cmp al, '2'
    je run_decompile
    
    mov rcx, [stdout_h]
    lea rdx, [err_msg]
    mov r8d, err_len
    lea r9, [bytes_read]
    mov qword [rsp + 32], 0
    call WriteFile
    jmp show_menu

run_install:
    lea rcx, [bat_install]
    mov edx, 1
    call WinExec
    jmp exit_prog

run_decompile:
    lea rcx, [bat_decompile]
    mov edx, 1
    call WinExec
    jmp exit_prog

exit_prog:
    xor rcx, rcx
    call ExitProcess
    add rsp, 40
    ret