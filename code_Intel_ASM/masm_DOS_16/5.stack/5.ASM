ASSUME CS:TT,DS:DATA,SS:STACK  

DATA SEGMENT  
    DW 0123H,0456H,0789H,0ABCH,0DEFH,0FEDH,0CBAH,0987H ;数据段原始数据
DATA ENDS 

STACK SEGMENT
    DW 0,0,0,0,0,0,0,0 
STACK ENDS 

TT SEGMENT 
START:       ; CS:IP pointer here 
    MOV AX,STACK 
    MOV SS,AX 
    MOV SP,16 ;栈顶指针指向 16（2*8） 

    MOV AX,DATA
    MOV DS,AX 

    MOV BX,0
    MOV CX,8 
tag:PUSH [BX]
    ADD  BX,2
    LOOP tag 

    MOV BX,0
    MOV CX,8
s:  POP [BX]
    ADD BX,2
    LOOP s

    MOV AX,4C00H
    INT 21H
    TT ENDS 
END START 
