.MODEL TINY
.186
.STACK 100H
.DATA
    str1 DB 'hello', 0
    str2 DB 'hello', 0
    result DB 0  ; 1 if equal, 0 if not

.CODE
ORG 100H
START:
    MOV SI, OFFSET str1
    MOV DI, OFFSET str2

COMPARE_LOOP:
    MOV AL, [SI]
    MOV BL, [DI]
    CMP AL, 0
    JE END_COMPARE
    CMP AL, BL
    JNE NOT_EQUAL
    INC SI
    INC DI
    JMP COMPARE_LOOP

END_COMPARE:
    CMP [DI], 0
    JNE NOT_EQUAL
    MOV result, 1
    JMP DONE

NOT_EQUAL:
    MOV result, 0

DONE:
    MOV AH, 4Ch
    INT 21H
END START
