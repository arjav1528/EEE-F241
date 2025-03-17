;1. Your program should store first 1000 even numbers in memory using a loop
;2. Print the following message on the screen to accept a number from the user "Enter the number to search:"
;   You can assume the user enters a positive number that can fit using 16-bits
;3. Write a subroutine that searches for an unsigned number in an array. If the number is found, it should return the 
;   position number where the number is found, else should return -1. You can assume the maximum array size will be less 
;than 65535
;4. If the number entered by the user is present in the array of even numbers, print
;   "Number is present at position " and the position number found using the subroutine
;   Else print "Number not found"
;


.model tiny
.186

.data
	message db 'Enter the number to search:$'
	arr dw 1000 dup(?)
	len dw 1000
	key dw 1 dup(?)
.code
	.startup
	
		;initial setup for the storage loop
		mov ax,0
		mov cx,len
		sub cx,1
		lea si,arr
		mov word ptr [si],ax
		
		;loop to store elements
		storeloop:
			add ax,2
			add si,2
			mov word ptr [si],ax
			dec cx
			jnz storeloop
		
		;printing the enter number message
		lea dx,message
		mov ah,09h
		int 21h
		call readNum
		call search
		
		;if the search returns a -1 just exit without printing anything
		cmp ax,-1
		je exit
		
		;else print out the number and exit the program
		call showNum
		mov ah, 4ch
		int 21h
		
		
		;subroutine to readnumber from the keyboard
		readNum:
			mov bx,0
			readloop:
				mov ah,01h
				int 21h
				cmp al,13
				je storeNum
				
				sub al,'0'
				cmp al,9
				ja readloop
				
				mov ch,0
				mov cl,al
				mov ax,bx
				mov dx,10
				mul dx
				add ax,cx
				mov bx,ax
				jmp readloop
			storeNum:
				mov key, bx
				ret
	
		;subroutine which returns -1 if the number is not found and the index of the number if it is found
		;returns are passed through the ax register
		search:
			;initial variables setup
			mov cx,len	;control variable
			shl cx,1	;make it double as the array is dw
			mov ax,-1	;default return value of a (if the element is not found in the array)
			mov si,0	;loop variable
			lea bx,arr	;base address of the array
			mov dx,key	;the key to be searched
			
			searchloop:
				cmp dx,[bx+si]	;compare the current element i.e base + index with key
				jne notfound	;if not equal then jump to the next iteration
				shr si,1		;else if equal then divide the index by 2 (since it is a word array) and store it in ax for return 
				mov ax,si
				ret	 ;return point if the element is found 
				notfound:
					add si,2	;move on to next index
					cmp si,cx	;check for end of array
					jne searchloop		
			ret ;return point if the element is not found

				
			
		
		;subroutine to print out a number on the display
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
				
		
		exit:		
	.exit
end