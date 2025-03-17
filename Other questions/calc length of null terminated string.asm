.MODEL TINY
.186
.STACK 100H
.DATA
    str DB 'Hello, World!', 0  ; Null-terminated string
    len DB 0                   ; Store length

.CODE
ORG 100H
START:
    MOV SI, OFFSET str   ; SI points to the start of the string
    MOV CX, 0            ; Counter for length

L1: 
    CMP BYTE PTR [SI], 0 ; Check for null terminator
    JE DONE
    INC SI               ; Move to next character
    INC CX               ; Increment count
    JMP L1

DONE:
    MOV len, CL          ; Store length in memory

    MOV AH, 4Ch
    INT 21H              ; Exit program
END START
