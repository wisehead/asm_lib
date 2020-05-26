ASSUME CS:TT 
TT SEGMENT 
START:
    MOV BX,0 

    MOV CX,12
s:  MOV AX,0FFFFH
    MOV DS,AX 
    MOV DL,[BX]

    MOV AX,0020H
    MOV DS,AX 
    MOV [BX],DL 
    INC BX 
    LOOP s

    MOV AX,4C00H
    INT 21H
TT ENDS 
END 
