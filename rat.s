# Rat - A minimal Linux x86-64 "cat clone" in x86_64 Assembly.
# Copyright (C) 2025 Pavle Dzakula
# See LICENSE

.intel_syntax noprefix

.global _start

.data
    buffer: .space 4096
    error_msg: .asciz "Rat can't read that!\n"
    .equ ERR_LEN, . - error_msg -1

.text
_start:
    mov rax, [rsp]
    cmp rax, 2
    jl error

    mov rsi, [rsp + 16]
    mov rdi, rsi
    xor rsi, rsi
    mov rax, 2
    syscall
    cmp rax, 0
    jl error

    mov rbx, rax
read_loop:
    mov rax, 0
    mov rdi, rbx 
    lea rsi, [buffer]
    mov rdx, 4096 
    syscall
    cmp rax, 0
    jle done

    mov rdx, rax 
    mov rax, 1
    mov rdi, 1
    lea rsi, [buffer]
    syscall
    jmp read_loop

done:
    mov rax, 60
    xor rdi, rdi
    syscall

error:
    mov rax, 1
    mov rdi, 2
    lea rsi, [error_msg]
    mov rdx, ERR_LEN
    syscall
    mov rax, 60
    mov rdi, 1
    syscall
