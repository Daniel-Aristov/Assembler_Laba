Stack segment para stack 'stack'  
    DW 128 dup('0') 
Stack ends  

Dseg segment para public 'data'  
    MAS DW 2 dup(?)
        DW 2 dup(?) 
    MIN DW 32767    
    COUNT_MIN DW 0
    
    STRING DB 15, 16 dup(?) 
    N DW ?
    KOD DB 6 DUP(?)
    
    MESS0 DB "Enter 4 elements in the array using numbers in the range from -32768 to 32767: ", 0DH,0AH, "$"
    MESS1 DB 0DH,0AH,"Minimum array element: $"
    MESS2 DB 0DH,0AH,"Count minimum elements of the array: $"
    
    MESS_END DB 0DH,0AH,"Press any key to exit... $"
    MESS_ERR DB "Error! Wrong number. Try again...", 0DH,0AH, "$"          
Dseg ends  

Cseg segment para public 'code'
    Assume cs:cseg, ds:dseg, ss:stack  
    
START:
    MOV AX, DSEG
    MOV DS, AX
    MOV ES, AX    
    
    MOV CX, 4 
    XOR SI, SI
    
    LEA DX, MESS0
    MOV AH, 09H
    INT 21H

;явхршбюмхе щкелемрнб х днаюбкемхе б люяяхб    
READ:
    MOV DI, 0
    LEA DX, STRING
    MOV AH, 0ah
    INT 21h
    MOV DL, 0ah
    MOV AH, 2
    INT 21h
    MOV DL, 0dh
    MOV AH, 2
    INT 21h
     
    LEA SI, STRING+4
    CMP [SI], 13
    JE ERR
    
    CMP BYTE PTR [SI], "-"
    JNE POSITIVE
    MOV DI, 1
    INC SI
    
POSITIVE: 
    XOR AX, AX
    MOV BX, 10
    PUSH CX
isNum:
    MOV DL, [SI]
    
    CMP DL, 13
    JE END_NUM
    
    CMP DL, '0'
    JB ERR
    
    CMP DL, '9'
    JA ERR     
     
    SUB DL, '0'
    MUL BL
    ADD AL, DL
    INC SI
    JMP isNum

END_NUM:
    POP CX
    CMP DI, 1
    JNE END_VALID_NUM
    NEG AX

END_VALID_NUM:
    LEA SI, MAS
    ADD SI, BP
    MOV [SI], AX
    ADD BP, 2     
LOOP READ

   
;онхяй люйяхлслю б люяяхбе     
XOR SI, SI
MOV CX, 4
CYCLE:
    MOV AX, MIN
    CMP MAS[SI], AX 
    JL isMIN
    JMP NEXT_EL
 
isMIN:
    MOV AX, MAS[SI] 
    MOV MIN, AX
   
NEXT_EL:
    ADD SI, 2 
    
LOOP CYCLE 

;онхяй йнкхвеярбю люйяхлюкэмшу щкелемрнб
MOV CX, 4
XOR SI, SI 
FIND_COUNT_MIN:
    MOV AX, MAS[SI]
    CMP AX, MIN
    JE INCREMENT
    JMP NEXT
 
INCREMENT:
	INC COUNT_MIN
 
NEXT:
    ADD SI, 2
	
LOOP FIND_COUNT_MIN


;бшбнд пегскэрюрю
PRINT_RESULT:
    LEA DX, MESS1
    MOV AH, 09h
    INT 21H
    
    MOV AX, MIN
	MOV N, AX
	CALL PRINT_NUM 
     
    LEA DX, MESS2
    MOV AH, 09h
    INT 21H
    
    MOV AX, COUNT_MIN     
    MOV N, AX
    MOV KOD, 0
	CALL PRINT_NUM
    JMP OUT	

PRINT_NUM:
    CMP N, 0
    JGE NUM_SET

    NEG N
    MOV KOD, "-"

NUM_SET: 
    MOV BX, 10
    MOV DX, 0
    MOV AX, N
    
    DIV BX
    ADD DL, '0'
    MOV KOD+5, DL
    MOV DL, 0
	
    DIV BX
	ADD DL, '0'
	MOV KOD+4, DL
	MOV DL, 0
	
	DIV BX
	ADD DL, '0'
	MOV KOD+3, DL
	MOV DL, 0
	
	DIV BX
    ADD DL, '0'
	ADD AL, '0'
    MOV KOD+2, DL
    MOV KOD+1, AL

    CMP KOD, '-'
    JNE POS
    MOV DL, KOD
    MOV AH, 02h
    INT 21H
    INC SI

POS:
	MOV SI, 1
	MOV CX, 5
isZERO:
    CMP KOD+SI, '0'
    JNE WRITE_NUM             
    INC SI  
LOOP isZERO


MOV CX, 6
SUB CX, SI
WRITE_NUM:
    MOV DL, KOD+SI
    MOV AH, 02h
    INT 21H
    INC SI
LOOP WRITE_NUM
RET    


ERR:
    LEA DX,  MESS_ERR
    MOV AH, 09h
    INT 21H
    JMP START


OUT:
    LEA DX,  MESS_END
    MOV AH, 09h
    INT 21H
	
    MOV AH, 0h
    INT 16H
    MOV AX, 4c00h
    INT 21H
    

Cseg ends  
End START




