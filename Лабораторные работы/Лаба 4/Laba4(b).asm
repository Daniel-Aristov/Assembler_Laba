Stack segment para stack 'stack'  
    Dw 128 dup('0') 
Stack ends  

Dseg segment para public 'data'  
    mas dw 1,2,
        dw 4,5 
    sum dw 0    
    average dw 0          
Dseg ends  

Cseg segment para public 'code'
    Assume cs:cseg, ds:dseg, ss:stack;  
    
    Our_prog proc far  
    Push ds
    Sub ax, ax  
    Push ax  
    Mov ax, dseg
    Mov ds, ax    
    
    Mov cx, 4
    Xor si, si
    
    
    Cycl: mov ax, mas[si]  ; цикл поиска суммы элементов
    add sum, ax
    Jmp kon_cycl
    kon_cycl: inc si
                inc si
    loop cycl
    
    mov ax, sum   ; поиск среднего арифметического
    mov cx, 0
    mov bl, 4
    div bl
    mov average, ax
    
    Ret  
    Our_prog endp  

Cseg ends  
End our_prog




