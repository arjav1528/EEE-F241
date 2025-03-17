.MODEL TINY
.186
.STACK 100H
.DATA
    str DB 'assembly language', 0
    findChar DB 'a'
    replaceChar DB 'x'

.CODE
ORG 100H
START:
    MOV SI, OFFSET str
    MOV AL, findChar
    MOV BL, replaceChar

REPLACE_LOOP:
    CMP BYTE PTR [SI], 0
    JE DONE
    CMP BYTE PTR [SI], AL
    JNE SKIP
    MOV BYTE PTR [SI], BL  ; Replace character

SKIP:
    INC SI
    JMP REPLACE_LOOP

DONE:
    MOV AH, 4Ch
    INT 21H
END START
