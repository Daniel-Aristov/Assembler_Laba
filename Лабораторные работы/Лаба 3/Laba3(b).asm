stack segment para stack 'stack'
    db 64 dup('stack ')
stack ends

dseg segment para public 'data'
    Mas dw 5,2,0,4,0,-6,2,1,0,0,-9,8
    Sch_0 db 0 ;счетчик нулевых элементов вектора
    Sch_notZero db 0 ;счетчик ненулевых элементов вектора
dseg ends

cseg segment para public 'code'
    assume cs:cseg, ds:dseg, ss:stack;
    
    our_prog proc far
    
    push ds ;инициализация сегмента данных 
    mov ax, 0
    push ax
    mov ax, dseg
    mov ds, ax
    
    Mov cx, 12 ;инициализация счетчика цикла
    Xor si, si ;инициализация индексного регистра
    
    Cycl: cmp mas[si], 0 ;сравниваем элемент вектора с 0
        Jz zero ;нулевые элементы считаем в блоке zero
        Jg notZero ;элементы > 0 считаем в блоке notZero    
        Inc Sch_notZero ;увеличиваем счетчик элементов < 0
        Jmp kon_cycl
    
    Zero: Inc Sch_0 ;увеличиваем счетчик нулевых элементов
    Jmp kon_cycl
    
    notZero: Inc Sch_notZero ;увеличиваем счетчик элементов > 0
   
    kon_cycl: inc si ;переходим к следующему элементу вектора  
    loop cycl ;завершаем цикл.
    
    ret
    
    our_prog endp
cseg ends

    end our_prog



