.MODEL TINY
.186
.STACK 100H
.DATA
    str DB 'hello', 0  ; Null-terminated string

.CODE
ORG 100H
START:
    MOV SI, OFFSET str
    MOV DI, OFFSET str

FIND_END:
    CMP BYTE PTR [DI], 0
    JE REVERSE
    INC DI
    JMP FIND_END

REVERSE:
    DEC DI              ; Move DI to last char (before null)
REV_LOOP:
    CMP SI, DI
    JGE DONE            ; If pointers meet, stop
    MOV AL, [SI]        ; Swap characters
    MOV BL, [DI]
    MOV [DI], AL
    MOV [SI], BL
    INC SI
    DEC DI
    JMP REV_LOOP

DONE:
    MOV AH, 4Ch
    INT 21H
END START
