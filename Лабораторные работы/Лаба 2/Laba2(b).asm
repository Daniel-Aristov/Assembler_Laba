stack segment para stack 'stack'
    db 64 dup(0)
stack ends

dseg segment para public 'data'
    source dw 1,2,3,4,5,6,7,8
    dest dw 8 dup(?)
dseg ends

cseg segment para public 'code'
    assume cs:cseg, ds:dseg, ss:stack;
    
    our_prog proc far
    
    push ds 
    mov ax, 0
    push ax
    mov ax, dseg
    mov ds, ax
   
    mov di, offset dest 
    mov bx, offset source 
    
    mov [di], 0 
    mov [di+2], 0 
    mov [di+4], 0 
    mov [di+6], 0 
    mov [di+8], 0   
    mov [di+10], 0
    mov [di+12], 0
    
    mov ax, [bx+2] 
    mov [di], ax 
    mov ax, [bx+6] 
    mov [di+4], ax 
    mov ax, [bx+10] 
    mov [di+8], ax 
    mov ax, [bx+14] 
    mov [di+12], ax  
   
    ret
    
    our_prog endp
cseg ends

    end our_prog




