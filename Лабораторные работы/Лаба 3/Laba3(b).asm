stack segment para stack 'stack'
    db 64 dup('stack ')
stack ends

dseg segment para public 'data'
    Mas dw 5,2,0,4,0,-6,2,1,0,0,-9,8
    Sch_0 db 0 ;������� ������� ��������� �������
    Sch_notZero db 0 ;������� ��������� ��������� �������
dseg ends

cseg segment para public 'code'
    assume cs:cseg, ds:dseg, ss:stack;
    
    our_prog proc far
    
    push ds ;������������� �������� ������ 
    mov ax, 0
    push ax
    mov ax, dseg
    mov ds, ax
    
    Mov cx, 12 ;������������� �������� �����
    Xor si, si ;������������� ���������� ��������
    
    Cycl: cmp mas[si], 0 ;���������� ������� ������� � 0
        Jz zero ;������� �������� ������� � ����� zero
        Jg notZero ;�������� > 0 ������� � ����� notZero    
        Inc Sch_notZero ;����������� ������� ��������� < 0
        Jmp kon_cycl
    
    Zero: Inc Sch_0 ;����������� ������� ������� ���������
    Jmp kon_cycl
    
    notZero: Inc Sch_notZero ;����������� ������� ��������� > 0
   
    kon_cycl: inc si ;��������� � ���������� �������� �������  
    loop cycl ;��������� ����.
    
    ret
    
    our_prog endp
cseg ends

    end our_prog



