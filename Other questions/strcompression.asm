
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
.MODEL SMALL
.STACK 100H
.DATA
    input_string DB 'aaabbbcc$'     ; Input string to compress
    compressed_string DB 20 DUP('$') ; Buffer to store compressed string
    result_msg DB 'Compressed string: $'
.CODE
MAIN PROC
    MOV AX, @DATA          ; Initialize data segment
    MOV DS, AX

    ; Compress the string
    CALL COMPRESS_STRING

    ; Display the compressed string
    MOV AH, 09H
    LEA DX, result_msg
    INT 21H
    LEA DX, compressed_string
    INT 21H

    ; Exit program
    MOV AH, 4CH
    INT 21H
MAIN ENDP

; Subroutine to compress the string
COMPRESS_STRING PROC
    LEA SI, input_string   ; Point SI to input string
    LEA DI, compressed_string ; Point DI to compressed string buffer
    MOV CX, 1              ; Initialize repetition counter

COMPRESS_LOOP:
    MOV AL, [SI]           ; Load current character
    CMP AL, '$'            ; Check if end of string
    JE COMPRESS_DONE       ; If end of string, exit

    ; Compare current character with next character
    MOV BL, [SI + 1]       ; Load next character
    CMP AL, BL             ; Compare current and next character
    JNE WRITE_COMPRESSED   ; If not equal, write compressed character

    ; If characters are equal, increment repetition counter
    INC CX
    JMP NEXT_CHAR

WRITE_COMPRESSED:
    ; Write the character to compressed string
    MOV [DI], AL           ; Store character
    INC DI

    ; Write the repetition count to compressed string
    CMP CX, 1              ; Check if count is greater than 1
    JLE SKIP_COUNT         ; If count is 1, skip writing count
    ADD CX, '0'            ; Convert count to ASCII
    MOV [DI], CL           ; Store count
    INC DI
    SUB CX, '0'            ; Restore CX to numeric value

SKIP_COUNT:
    MOV CX, 1              ; Reset repetition counter

NEXT_CHAR:
    INC SI                 ; Move to next character
    JMP COMPRESS_LOOP

COMPRESS_DONE:
    RET
COMPRESS_STRING ENDP

END MAIN




                                                                                         
                                                                                       