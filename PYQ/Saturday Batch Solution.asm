.model tiny
.186
.data
str1 db 'Enter the string:$'
str2 db 'Number of vowels: $'
vowel db 'AEIOUaeiou'
disnl db 0DH,0AH,'$'

stringMaxLength db 33		; 32 characters + enter
stringLength db ?
string db 34 dup('$')     	; 32 characters + enter + '$'

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

LEA SI,string				; SI = address of string

MOV CH,00H					; CX = stringLength
MOV CL,stringLength			

MOV BL,00H					; BL = vowelCount

label1:						; iteratively check whether each charcter is a vowel
	CALL check_vowel
	CMP AL,00H
	JE iterate				; if character is not a vowel iterate
	INC BL					; else increase vowelCount
	iterate:
	INC SI
	LOOP label1

LEA DX,str2					; display "Number of vowels: "
MOV AH,09H
INT 21H

CALL hextodec				; value stored in BX is converted from hexadecimal to decimal

MOV AL,BL					; AL stores the answer
AND AL,0F0H
ROR AL,04H					; AL stores the upper decimal digit
ADD AL,'0'					; AL stores the ASCII value of the upper decimal digit

MOV DL,AL					; display the upper decimal digit
MOV AH,02H
INT 21H

MOV AL,BL					; AL stores the answer
AND AL,0FH					; AL stores the lower decimal digit
ADD AL,'0'					; AL stores the ASCII value of the lower decimal digit

MOV DL,AL					; display the lower decimal digit
MOV AH,02H
INT 21H
.exit

; Requires SI to have the address of the character
; if [SI] is a vowel then AL = 1, else AL = 0
check_vowel:
	PUSHA
	MOV AL,[SI]				; copies character to AL
	LEA BX,vowel			; BX = address of all vowels
	MOV CX,0AH				; CX = number of vowels (lowercase + uppercase) = 10
	label2:
		CMP AL,[BX]
		JE is_vowel			; if character is a vowel, AL = 01H
		INC BX
		LOOP label2
	POPA
	MOV AL,00H				; else AL = 00H
	RET
	
	is_vowel:
		POPA
		MOV AL,01H
		RET

; Converts a 8-bit hexadecimal number to decimal number
; Requires BL to contain the hexadecimal number and hexadecimal number to be less than 63H (or 99 decimal)
; Decimal answer will be stored in BL register
hextodec:
	PUSH CX
	PUSH AX
	
	MOV AL,00H
	
	MOV CH,00H
	MOV CL,BL
	AND CL,0F0H
	ROR CL,04H				; CL stores the upper decimal digit
	JCXZ next				; if upper decimal digit is 0, then skip the loop
	
	loop1:					; loop makes AL = 16 * <upper_hex_digit> (For eg: if BL = 34H then AL = 16 * 3 = 48H)
		ADD AL,16H			
		DAA					; corrects the result of addition of two packed BCD values
		SUB BL,10H
		LOOP loop1
	
	next:
	ADD AL,BL				; Add the <lower_hex_digit> to AL
	DAA						; corrects the result of addition of two packed BCD values
	
	MOV BL,AL				; stores answer back in BL
	
	POP AX
	POP CX
	RET
end