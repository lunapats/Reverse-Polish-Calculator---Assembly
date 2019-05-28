%include "io.inc"

%define MAX_INPUT_SIZE 4096

section .bss
	expr: resb MAX_INPUT_SIZE

section .text
global CMAIN
CMAIN:
        mov ebp, esp; for correct debugging

	GET_STRING expr, MAX_INPUT_SIZE
        xor edx, edx
        xor ecx, ecx

	; your code goes here
        
Operations:
        ; makes the necessary jumps for every operation
        cmp ebx, '+'
        je addition
        cmp ebx, '-'
        je check_if_negative        ;checks the actual meaning of the minus character
        cmp ebx, '*'
        je multiply
        cmp ebx, '/'
        je division
        
Space:
        ; adds number to stack so as to be used later
        push eax
        xor eax, eax
        
Again:
        xor ebx, ebx
        mov bl, byte[expr + ecx]    ; reads character by character
        inc ecx                     ; counter, used for reading
        cmp bl, 0                   ; checks if end of file has been reached
        je print
        cmp bl, ' '                 ; checks if it found a space
        je Space
        cmp eax, 0                  ; checks if the number is just a digit or something bigger
        jne big_number
        cmp bl, 48                  ; checks if the character is an operation sign
        jl Operations
        mov eax, ebx
        sub eax, 48                 ; transforms the digit into the number it represents
        jmp Again
        
check_if_negative:
        ; checks to see the meaning of the minus sign
        mov bl, byte[expr + ecx]    ; reads the next character 
        inc ecx  
        cmp bl, ' '                 ; if it is a space of EOF, it means that "-" represents substraction
        je subtract
        cmp bl, 0
        je subtract
        sub ebx, 48                 ; otherwise, it signifies the number is negative
        xor eax, eax                ; it transforms ebx into an int, negates it and stores it into eax
        sub eax, ebx
        jmp Again
        
addition:
        ; computes the addition between the last two stored numbers and saves the result
        pop ebx
        pop eax
        add eax, ebx               
        push eax
        jmp Again
       
subtract:
        ; computes the subtraction between the last two stored numbers and saves the result
        pop ebx
        pop eax
        sub eax, ebx
        push eax
        xor eax, eax
        jmp Again
        
big_number:
        ; creates numbers bigger than one digit by multiplying the previous number by 10 and adding the new one
        sub ebx, 48
        mov edx, 10
        mul edx
        add eax, ebx
        jmp Again
        
multiply:
        ; computes the multiplication between the last two stored numbers and saves the result
        pop ebx
        pop eax
        imul ebx
        push eax
        jmp Again
        
division:
        ; computes the division between the last two stored numbers and saves the result
        pop ebx
        pop eax
        cdq
        idiv ebx
        push eax
        jmp Again

print:
        pop eax
        PRINT_DEC 4, eax        ; prints the last saved number as the result of the expression
	pop ebp

	ret
