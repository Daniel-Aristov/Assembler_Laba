Stack segment para stack 'stack'  
    Dw 128 dup('0') 
Stack ends  

Dseg segment para public 'data'  
    mas db 1,2,
        db 4,5 
    sum db 0    
    median db 0          
Dseg ends  

Cseg segment para public 'code'
    Assume cs:cseg, ds:dseg, ss:stack;  
    
    Our_prog proc far  
    Push ds
    Sub ax, ax  
    Push ax  
    Mov ax, dseg
    Mov ds, ax    
    
    mov al, mas[1]  ; поиск суммы средних двух чисел
    add sum, al
    mov al, mas[2]
    add sum, al   
    
    mov al, sum   ; поиск медианы
    mov ah, 0
    mov bl, 2
    div bl
    mov median, al
    
    Ret  
    Our_prog endp  

Cseg ends  
End our_prog





