Stack segment para stack 'stack'  
    DW 128 dup('0') 
Stack ends  

Dseg segment para public 'data'  
    MAS DB 2 dup(?)
        DB 2 dup(?) 
    MAX DB -128    
    COUNT_MAX DW 0
    
    STRING DB 5, 4 dup(?) 
    N DB ?
    KOD DB 4 DUP(?)
    
    MESS0 DB "Enter 4 elements in the array using numbers in the range from -128 to 127: ", 0DH,0AH, "$"
    MESS1 DB 0DH,0AH,"Maximum array element: $"
    MESS2 DB 0DH,0AH,"Count maximum elements of the array: $"
    
    MESS_END DB 0DH,0AH,"Press any key to exit... $"
    MESS_ERR DB "Error! Wrong number. Try again...", 0DH,0AH, "$"          
Dseg ends  

Cseg segment para public 'code'
    Assume cs:cseg, ds:dseg, ss:stack;  
    
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
     
    LEA SI, STRING+2
    CMP [SI], 13
    JE ERR
    
    CMP BYTE PTR [SI], "-"
    JNE POSITIVE
    MOV DI, 1
    INC SI
    
POSITIVE: 
    XOR AX, AX
    MOV BL, 10

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
    CMP DI, 1
    JNE END_VALID_NUM
    NEG AL

END_VALID_NUM:
    LEA SI, MAS
    ADD SI, BP
    MOV [SI], AL
    INC BP     
LOOP READ

   
;онхяй люйяхлслю б люяяхбе     
XOR SI, SI
MOV CX, 4
CYCLE:
    MOV AL, MAX
    CMP MAS[SI], AL 
    JG isMAX
    JMP NEXT_EL
 
isMAX:
    MOV AL, MAS[SI] 
    MOV MAX, AL
   
NEXT_EL:
    INC SI 
    
LOOP CYCLE 

;онхяй йнкхвеярбю люйяхлюкэмшу щкелемрнб
MOV CX, 4
XOR SI, SI 
FIND_COUNT_MAX:
    MOV AL, MAS[SI]
    CMP AL, MAX
    JE INCREMENT
    JMP NEXT
 
INCREMENT:
	INC COUNT_MAX
 
NEXT:
    INC SI
	
LOOP FIND_COUNT_MAX


;бшбнд пегскэрюрю
PRINT_RESULT:
    LEA DX, MESS1
    MOV AH, 09h
    INT 21H
    
    MOV AL, MAX
	MOV N, AL
	CALL PRINT_NUM 
     
    LEA DX, MESS2
    MOV AH, 09h
    INT 21H
    
    MOV AX, COUNT_MAX     
    MOV N, AL
    MOV KOD, 0
	CALL PRINT_NUM
    JMP OUT	

PRINT_NUM:
    CMP N, 0
    JGE NUM_SET

    NEG N
    MOV KOD, '-'

NUM_SET: 
    MOV BL, 10
    MOV AL, N
    MOV AH, 0
    DIV BL
   
    ADD AH, '0'
    MOV KOD+3, AH
    MOV AH, 0
    DIV BL
    
    ADD AX, '00'
    MOV KOD+2, AH
    MOV KOD+1, AL

    CMP KOD, '-'
    JNE POS
    MOV DL, KOD
    MOV AH, 02h
    INT 21H
    
    INC SI

POS:
	MOV SI, 1
	MOV CX, 3
isZERO:
    CMP KOD+SI, '0'
    JNE WRITE_NUM             
    INC SI  
LOOP isZERO


MOV CX, 3
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





