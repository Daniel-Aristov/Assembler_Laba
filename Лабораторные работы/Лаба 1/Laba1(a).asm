TITLE EX_PROG
    
STACK segment PARA STACK 'STACK'
    dw   128  dup(0)
STACK ends

DSEG segment PARA PUBLIC 'DATA'
    source dw 0AAAAh, 0BBBBh, 0CCCCh, 0DDDDh, 0EEEEh
    dest dw 5 dup(?)
DSEG ends

CSEG segment PARA PUBLIC 'CODE'
start:
    assume cs: CSEG, ds: DSEG, ss: STACK
    
    push ds
    push ax 
    mov ax, 0
    mov ax, DSEG
    mov ds, ax
    
    mov dest,0 
    mov dest+2,0
    mov dest+4,0
    mov dest+6,0   
    mov dest+8,0
    
    mov ax, source
    mov dest+8, ax
    mov ax, source+2
    mov dest+6, ax
    mov ax, source+4
    mov dest+4, ax
    mov ax, source+6
    mov dest+2, ax
    mov ax, source+8
    mov dest, ax 

CSEG ends
end start
                       