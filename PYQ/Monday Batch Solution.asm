.model tiny
.186
.data
str1 db 'Enter the string:$'
str2 db 'This is a palindrome$' 
str3 db 'This is not a palindrome$' 
disnl db 0DH,0AH,'$'

stringMaxLength db 33		; 32 characters + enter
stringLength db ?
string db 34 dup('$')     	; 32 characters + enter + '$'

revString db 34 dup('$')     ; 32 characters + enter + '$'
.code
.startup

LEA DX,str1					; display "Enter the string:"
MOV AH,09H
INT 21H

LEA DX,disnl				; display newline
MOV AH,09H
INT 21H

LEA DX,stringMaxLength		; input string
MOV AH,0AH
INT 21H

LEA DX,disnl				; display newline
MOV AH,09H
INT 21H

LEA BX,string				; BX = address of (string)
CALL is_palindrome			; CALL is_palindrome subroutine

CMP AL,00H
JE print_not_pal

LEA DX,str2					; display "This is a palindrome"
MOV AH,09H
INT 21H
.exit

print_not_pal:
	LEA DX,str3					; display "This is not a palindrome"
	MOV AH,09H
	INT 21H
.exit

; if string is palindrome, AL = 01H else AL = 00H
; Requires BX to have address of string
; Subroutine creates a reversed string (revString) and checks whether (string == revString)
is_palindrome:
MOV CH,00H
MOV CL,stringLength		; CX = stringLength

LEA SI,revString		; SI stores the address of (revString + stringLength - 1)
ADD SI,CX
DEC SI

loop1:
	MOV DL,[BX]
	MOV [SI],DL
	INC BX
	DEC SI
	LOOP loop1			; revString stores reversed string

MOV CH,00H
MOV CL,stringLength		; CX = stringLength

CLD						; Direction Flag = 0
LEA SI,revString		
LEA DI,string
REPE CMPSB				; Compare whether (string == revString)

JCXZ palindrome			; if (string == revString) jump to palindrome
MOV AL,00H				; else AL = 00H
RET

palindrome:				; if (string == revString) AL = 01H
	MOV AL,01H		
	RET
end