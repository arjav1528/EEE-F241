;lets try to take the input from keyboard and output to display

.model tiny
.186
.data
	message db 'Enter a number:$'
	n dw 1 dup(?)
.code
	.startup
		;display the string
		lea dx,message
		mov ah, 09h
		int 21h
		
		call readNum
		mov ax,n
		call showNum
		mov ax,4ch
		int 21h
		readNum:
			mov bx,0
			readLoop:
				mov ah,01h
				int 21h
				cmp al,13
				je storeNum
				
				sub al,'0'
				cmp al,9
				ja readLoop
				
				mov ch,0
				mov cl,al
				mov ax,bx
				mov dx,10
				mul dx
				add ax,cx
				mov bx,ax
				jmp readLoop
			storeNum:
				mov n,bx
				ret
		
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
			
	.exit
end