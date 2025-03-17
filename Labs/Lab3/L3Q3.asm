;Write an 8086 assembly level program that counts the number of vowels (a, e, i, o, u, A, E, I, O, U) in a
;given string using string manipulation instructions. The input string should be read through keyboard, and
;the final count should be stored in memory and displayed on the terminal.
;Constraints:
;• Use SCASB to compare each character.
;• Use REPNE or REPE to optimize scanning.
;Refer Lecture Slides 8 for instruction details



.model tiny

.data
	msg1 db 'let me count them vowels for you:$'
	msg2 db 'them $'
	msg3 db ' vowels$'
	max db 20
	count db ?
	input db 20 dup(?)
	
	vowel db 'AEIOU$'
	vowelcount dw 0

.code
	.startup
		
		;display msg1
		lea dx,msg1
		mov ah,09h
		int 21h
		
		;input the string to be checked
		lea dx,max
		mov ah,0Ah
        int 21h
		
		;terminate the string using $
		lea si,input
		mov bl,count
		mov bh,00h
		add bx,si
		mov byte ptr [bx],'$'
		
		call printNextLine
		
		lea bx,input 			;load the first character
		mainLoop:
			mov al,[bx]
			cmp al,'$' 		;iterate till you encounter $
			je exitloop
			call checkvowel ;check if the current character is vowel
			inc bx
			jmp mainLoop
		
		exitloop:
			
			
			
			;display msg2
			lea dx,msg2
			mov ah,09h
			int 21h
			
			mov ax,vowelcount 		; load vowel count from memory
			call showNum 			;print the number
			
			;display msg3
			lea dx,msg3
			mov ah,09h
			int 21h
			call exitProgram 		;exit the program
		


		checkVowel:
        	lea di, vowel 			;load the starting address of the vowel string into memory
		and al,11011111b 		; a fancy bitwise operation to convert lowercase letters to uppercase keeping the uppercase as it is
        	mov cx,5      			; counter for our REPNE
        	cld                 		;clear direction flag
        	repne scasb         		;repeat till not a vowel
        	jne notVowel
        	inc vowelcount      		;increase vowel count if a vowel
		notVowel:
			ret    			;else return normally
			
			
		
		;standard subroutine to print next line
		printNextLine:
			mov dl,10 
			mov ah,02h
			int 21h
			ret
		

		;standard subroutine to show number	
		showNum:
			mov cx,0
			mov bx, 10
			
			convertLoop:
				mov dx,0
				div bx
				push dx
				inc cx
				cmp ax,0
				jnz convertLoop
			
			
			printLoop:
				pop dx
				add dl,'0'
				mov ah,02h
				int 21h
				dec cx
				jnz printLoop
				ret
				
				
		;jump here to exit the program
		exitProgram:
			mov ah,4ch
			int 21h
			
			
		
		
	.exit
end
