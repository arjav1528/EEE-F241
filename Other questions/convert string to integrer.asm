.MODEL TINY
.186
.STACK 100H
.DATA
    str DB '1234', 0
    result DW 0          ; Store integer result

.CODE
ORG 100H
START:
    MOV SI, OFFSET str
    MOV AX, 0
    MOV CX, 10           ; Multiplier (base 10)

CONVERT_LOOP:
    MOV BL, [SI]
    CMP BL, 0
    JE DONE
    SUB BL, '0'          ; Convert ASCII to digit
    MUL CX               ; Multiply AX by 10
    ADD AX, BX           ; Add new digit
    INC SI
    JMP CONVERT_LOOP

DONE:
    MOV result, AX

    MOV AH, 4Ch
    INT 21H
END START
