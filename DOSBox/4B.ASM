ASSUME CS:TT 
TT SEGMENT 
START:

    MOV BX,0 
    MOV AX,0020H
    MOV ES,AX

    MOV AX,0FFFFH
    MOV DS,AX 

    MOV CX,12
s: 
    MOV DL,[BX]
    MOV ES:[BX],DL 
    INC BX 
    LOOP s

    MOV AX,4C00H
    INT 21H
TT ENDS 
END 
