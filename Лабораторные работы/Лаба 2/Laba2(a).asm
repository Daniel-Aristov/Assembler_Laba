stack segment para stack 'stack'
    db 64 dup('stack ')
stack ends

dseg segment para public 'data'
    source db 1,2,3,4,5,6,7,8
    dest db 8 dup(?)
dseg ends

cseg segment para public 'code'
    assume cs:cseg, ds:dseg, ss:stack;
    
    our_prog proc far
    
    push ds 
    mov ax, 0
    push ax
    mov ax, dseg
    mov ds, ax
    
    mov dest, 0 
    mov dest+1, 0
    mov dest+2, 0
    mov dest+3, 0
    mov dest+4, 0
    mov dest+5, 0
    mov dest+6, 0
    mov dest+7, 0
   
    mov al, source+1
    mov dest, al
    mov al, source+3
    mov dest+2, al
    mov al, source+5
    mov dest+4, al
    mov al, source+7
    mov dest+6, al
    
    ret
    
    our_prog endp
cseg ends

    end our_prog






