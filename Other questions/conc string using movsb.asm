.MODEL TINY
.186
.STACK 100H
.DATA
    str1 DB 'Hello ', 0
    str2 DB 'World!', 0
    result DB 30 DUP(0)  ; Buffer to store result

.CODE
ORG 100H
START:
    MOV SI, OFFSET str1
    MOV DI, OFFSET result

COPY_FIRST:
    MOV AL, [SI]
    CMP AL, 0
    JE COPY_SECOND
    MOV [DI], AL
    INC SI
    INC DI
    JMP COPY_FIRST

COPY_SECOND:
    MOV SI, OFFSET str2

COPY_LOOP:
    MOV AL, [SI]
    CMP AL, 0
    JE DONE
    MOV [DI], AL
    INC SI
    INC DI
    JMP COPY_LOOP

DONE:
    MOV AH, 4Ch
    INT 21H
END START
