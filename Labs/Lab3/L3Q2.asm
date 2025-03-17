;Write an ALP that does the following
;Display the string “Enter User Name” and goes to the next line
;Takes in the user entered string compares with user name value already stored in memory
;If there is no match it should exit.
;If there is a match it should display the string “Enter Password” and goes to next line
;Takes in password entered by the user and compares with password already stored in memory
;If there is no match it should exit’
;If there is a match it should display “Hello Username”
;Note:
;While the username is being entered it can be displayed but when password is being entered user
;pressed key should be displayed instead it should display “*” for every key pressed.
;The username size is fixed to 10 characters and password to 8 characters.
.model tiny

.data
msg1 db 'Enter UserName$'
msg2 db 'Hello!! $'
username db 'Choki$'
password db 'ilyChki$'
length_user db 0
length_pass db 0
maxuser db 10
countuser db 0
inputuser db 10 dup(?)

inputpass db 8 dup(?)

.code
	.startup
	
		;display msg1
		lea dx,msg1
		mov ah,09h
		int 21h
		
		call PRINTNEXTLINE
		
		;input and store the username
		lea dx,maxuser
		mov ah,0ah
		int 21h
		
		call PRINTNEXTLINE
		
		;finding the length of username
		lea bx,username		;load first address of the username from memory
		mov cl,00h
		countloop:
			mov al,[bx]
			inc bx
			inc cl
			cmp al,'$'		;iterate till encounter $
			jne countloop
		
		dec cl
		mov byte ptr length_user,cl
		
		;finding the length of password
		lea bx,password 	;load first address of the password from memory
		mov cl,00h
		cloop:
			mov al,[bx]
			inc bx
			inc cl
			cmp al,'$' 		;iterate till encounter $
			jne cloop
		
		dec cl
		mov byte ptr length_pass,cl
		
		
		;compare usernames
		cld
		lea si,username 	;load username address into si
		lea di,inputuser 	;load username that was taken as input into di
		mov cl,length_user 	;use the length of the username calculated above
		mov ch,00h 			;mumbo jumbo to convert cl -> cx
		repe cmpsb
		jne exitprog
		
		;if correct username then proceed with password checks
		
		;password input
		;taken input character by character since we have to show no echo and print a star instead of the characters
		lea bx,inputpass 		;load pointer into bx
		mov si,0h 				;load offset as 0 into si
		readloop:
		call INPUTCHARNOECHO		;take input without echo
		cmp al,13					;if enter pressed stop the input readloop
		je comparepass				;if enter pressed proceed to comparison
		mov byte ptr [bx + si],al	;move the current character entered into the pointer + offset address
		call PRINTSTAR				;print start, coz nothing will be printed on the screen (there ai'nt no echo!!)
		inc si						;loop variable increase
		cmp si,8					;maximum characters in a password is 8
		jne readloop
			
		;compare passwords
		comparepass:
		lea si, inputpass       ; Point si to input password
		lea di, password        ; Point di to predefined password
		mov cl, length_pass     ; Load length of predefined password
		mov ch, 0               ; mumbo jumbo to convert cl -> cx
		repe cmpsb              ; compare strings byte by byte
		jne exitprog            ; exit if passwords don't match
		
		; Display Welcome message if the program does not end up exiting
		
		call PRINTNEXTLINE
		
		;display msg2
		lea dx, msg2
		mov ah, 09h
		int 21h
		
		
		;print out the username
		lea dx, username
		mov ah, 09h
		int 21h
		
	
		
		;subrouting to input character without echo (character stored in al)
		INPUTCHARNOECHO:
			mov ah,08h
			int 21h
			ret
		
		
		;subroutine to print a fricking star on the screen
		PRINTSTAR:
			mov dl,'*'
			mov ah,02h
			int 21h
			ret
		
		;subroutine to print next line
		PRINTNEXTLINE:
			mov dl,10
			mov ah,02h
			int 21h
			ret
		
		;exit subroutine
		exitprog:
			mov ah,4ch
			int 21h
	.exit
end