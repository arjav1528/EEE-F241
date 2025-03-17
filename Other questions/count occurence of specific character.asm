.MODEL TINY
.186
.STACK 100H
.DATA
    str DB 'assembly language', 0
    char DB 'a'              ; Character to find
    count DB 0               ; Store count

.CODE
ORG 100H
START:
    MOV SI, OFFSET str
    MOV AL, char
    MOV CX, 0

L1: 
    CMP BYTE PTR [SI], 0
    JE DONE
    CMP BYTE PTR [SI], AL
    JNE SKIP
    INC CX
SKIP:
    INC SI
    JMP L1

DONE:
    MOV count, CL   ; Store result

    MOV AH, 4Ch
    INT 21H
END START
