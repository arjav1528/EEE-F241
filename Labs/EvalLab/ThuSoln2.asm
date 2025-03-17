;You need to write an 8086 ALP that takes a number from keyboard and prints whether the 
;"number is a palindrome" (Eg:12321) or "number is not a palindrome" (Eg:1234). You can 
;assume the number is always positive and at most will contain 10 digits. There is no 
;constraints on how the data is stored in the memory. You can assume the user always 
;enters a valid input and no error checking is required.

.model tiny


.data
	;msg1 db "Enter a number:$"
	success db "number is a palindrome$"
	fail db "number is not a palindrome$"
	max db 11
	count db ?
	input db 11 dup(?)

.code
	.startup
		;print out the msg1
		;lea dx,msg1
		;call PRINTSTRING
		;take input of the string (keyboard reference)
		lea dx,max
		mov ah,0ah
		int 21h
		
		call PRINTNEXTLINE ;print next line
		call ADDTERMINATION ;add termination to the inputted string so that it is convenient to print it out
		call CHECKPALINDROME ;check if the string is palindrome
		

		CHECKPALINDROME:
			lea si,input 	;load the start of the string into input
			lea bx,input	;load the start of the string into bx
			mov cl,count	;initialize the count to length
			mov ch,00h		;make cl -> cx
			add bx,cx 		;add the count to reach the dollar position
			dec bx			;decrement one to reach the last character of the string
			mov di,bx		;move the bx address to di (for convenience in the loop)
			shr cx,1		;divide the length by two by right shifting it one time
			equalityloop:
				mov dl,[si]	;move the value pointed by si into dl
				mov bl,[di]	;move the value pointed by di int  bl
				cmp bl,dl	;compare if both are same
				je continue	;continue onto the next loop if both are same
				call NOTPALINDROME	;else it is not a palindrome and print out fail message and exit
				continue:
					inc si	;increase si to point to next character
					dec di	;decrease di to point to the previous character
					dec cx	;decrease the loop counter
					cmp cx,00h	;if loop counter exhausted then end the loop and print out the success message
					jnz equalityloop
			
			call PALINDROME
		
		;subroutine to print next line
		PRINTNEXTLINE:
			mov dl,10
			mov ah,02h
			int 21h
			ret
			
		;subroutine to add termination into 	
		ADDTERMINATION:
			lea bx,input 				;copy the address to bx
			mov cl,count 				;copy the number of characters into cl
			mov ch,00h 					;put 00 in ch to make a proper mov cx,count
			mov si,cx 					;put the offset into si 
			mov byte ptr [bx + si],'$'	;move termination character $ into the last part of the string
			ret
		
		;add what to print into dx register
		PRINTSTRING:
			mov ah,09h	;print out the string
			int 21h
			ret
			
		PALINDROME:
			;lea dx,input
			;call PRINTSTRING	;print out the number
			lea dx,success
			call PRINTSTRING	;print out the message
			mov ah,4ch
			int 21h
		
		NOTPALINDROME:
			;lea dx,input
			;call PRINTSTRING	;print out the number
			lea dx,fail
			call PRINTSTRING	;print out the message
			mov ah,4ch
			int 21h
			
		;subroutine to print out a character (character is moved into AH)
		PRINTCHAR:
			mov ah,02h
			int 21h
			ret		
		
	.exit
end
