.MODEL TINY
.186
.STACK 100H
.DATA
    num DW 1234
    str DB 6 DUP(0)   ; Buffer for result (max 5 digits + null)

.CODE
ORG 100H
START:
    MOV AX, num
    MOV SI, OFFSET str + 4  ; Point to last position (for reverse storing)
    MOV CX, 10

CONVERT_LOOP:
    MOV DX, 0
    DIV CX         ; AX / 10, remainder in DX
    ADD DL, '0'    ; Convert to ASCII
    DEC SI
    MOV [SI], DL
    CMP AX, 0
    JNE CONVERT_LOOP

DONE:
    MOV AH, 4Ch
    INT 21H
END START
