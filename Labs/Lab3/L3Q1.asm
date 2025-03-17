;Write an ALP that will take in a string of maximum 20 characters from user and display it on the next
;line on the screen (ASCII equivalent for newline is 0Dh (enter) followed by 0Ah (next line))


.model tiny

.data
	msg1 db 'enter a string will ya:$'
	max db 20
	count db ?
	input db 20 dup(?)
	
.code
	.startup
	
		;print out msg1
		lea dx,msg1
		mov ah,09h
		int 21h
		
		
		;take input of the string (keyboard reference)
		lea dx,max
		mov ah,0ah
		int 21h
		
		;print out new line
		mov dl,10
		mov ah,02h
		int 21h
		
		
		lea dx,input 				;take the starting address of stored string in dx for printing
		mov bx,dx 					;copy the address to bx
		mov cl,count 				;copy the number of characters into cl
		mov ch,00h 					;put 00 in ch to make a proper mov cx,count
		mov si,cx 					;put the offset into si 
		MOV byte ptr [bx + si],'$' 	;move termination character $ into the last part of the string



		mov ah,09h	;print out the string
		int 21h
			
		mov ah,4ch	;exit the program without fall through to PRINTNEXTLINE (not that it will cause any issue)
		int 21h
		
		;subroutine to print next line
		PRINTNEXTLINE:
			mov dl,10
			mov ah,02h
			int 21h
			ret
	.exit
end