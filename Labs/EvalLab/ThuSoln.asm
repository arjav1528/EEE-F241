;8086 inherently does not support numbers with fractional part.
;You need to write a program, which accepts 2 unsigned numbers 
;with fractional parts from user adds them displays the result. 
;An example case when your program executes is given below (all numbers are in decimal)
;Enter First number:13.54
;Enter Second number:12.85
;Sum is: 26.39
;You can make the follwing assumptions
;1. The integer portion of the number can fit using 16-bits
;2. The fractional portion will be always specified using 2 digits
;Hint: Why not store integer and fractional parts in separate variables and add them?


.model tiny

.data
msg db 'THURSDAY EVAL LAB 1 SOLUTION$'
msg1 db 'Enter your First number:$'
msg2 db 'Enter your Second number:$'
msg3 db 'Your First number:$'
msg4 db 'your Second number:$'
msg5 db 'sum=$'



num1i dw 1 dup(0)
num2i dw 1 dup(0)
num1f dw 1 dup(0)
num2f dw 1 dup(0)
sumi dw 1 dup(0)
sumf dw 1 dup(0)

flag dw 1 dup(0)
needtoprintzero db 1 dup(0)


.code
	.startup
	
	;print out signature
	lea dx,msg
	mov ah,09h
	int 21h
	call printNextLine
	
	;print out msg1 
	lea dx,msg1
	mov ah,09h
	int 21h
	
	;read out the First number 
	lea si,num1i
	call readNumi
	lea si,num1f
	call readNumf
	
	call printNextLine
	
	;print out msg2 
	lea dx,msg2
	mov ah,09h
	int 21h
	
	;read out the Second number 
	lea si,num2i
	call readNumi
	lea si,num2f
	call readNumf
	
	call printNextLine
	
	
	;print out msg3 
	lea dx,msg3
	mov ah,09h
	int 21h
	
	;print no.1
	mov ax,num1i
	call showNum
	mov dl,'.'
	call printChar
	mov ax,num1f
	cmp ax,10 ;if the fractional part is less than 10 then you have to print a 0 before the second number
	jae noless1
	push ax
	mov dl,'0'
	call printChar
	pop ax
	noless1:
	call showNum
	
	call printNextLine

	
	;print out msg4 
	lea dx,msg4
	mov ah,09h
	int 21h
	
	;print no.2
	mov ax,num2i
	call showNum
	mov dl,'.'
	call printChar
	mov ax,num2f
	cmp ax,10 ;if the fractional part is less than 10 then you have to print a 0 before the second number
	jae noless2
	push ax
	mov dl,'0'
	call printChar
	pop ax
	noless2:
	call showNum
	
	
	call printNextLine
	
	
	;print out msg5 
	lea dx,msg5
	mov ah,09h
	int 21h
	
	
	
	;call add subroutine and print the Sum
	;you know the drill, add the decimal part and then add the fractional part, if the fractional part is greater than 100
	;add 1 to the decimal part and subtract 100 from the fractional part
	call add_
	
	mov ax,sumi
	call showNum
	mov dl,'.'
	call printChar
	mov bl,needtoprintzero
	cmp bl,1
	jne noneed
	mov dl,'0'
	call printChar
	noneed:
	mov ax,sumf
	call showNum
	
	
	
	mov ah,4ch
	int 21h
	
	
	
	;the actual add subroutine
	add_:
		mov ax,num1i
		mov bx,num2i
		lea si,sumi
		lea di,sumf
		add ax,bx
		mov [si],ax
		
		mov dx,flag
		mov ax,num1f
		mov bx,num2f
		add ax,bx
		cmp dx,2
		je bothless
		cmp ax,99
		jl noproblem
		mov cx,num1i
		add cx,1
		mov [si],cx
		sub ax,100
		jmp noproblem
		
		bothless:
		cmp ax,10
		ja noproblem
		lea bx, needtoprintzero
		mov needtoprintzero,1
		
		noproblem:
		mov [di],ax
		ret
	
	
	
	;subroutine to read the integral part of number
	readNumi:
			mov bx,0
			readloopi:
				mov ah,01h
				int 21h
				cmp al,46
				je storeNumi
				
				sub al,'0'
				cmp al,9
				ja readloopi
				
				mov ch,0
				mov cl,al
				mov ax,bx
				mov dx,10
				mul dx
				add ax,cx
				mov bx,ax
				jmp readloopi
			storeNumi:
				mov [si], bx
				ret
	
	;subroutine to read the fractional part of the number
	;custom subroutine for using a flag for <9 decimal part and inputing two characters converting them into a number
	;this thing will only work for numbers with two decimal places, as im manually reading 2 characters
	readNumf:
			lea di,flag
			call inputChar
			cmp al,'0'
			jne continue
			mov bl, [di]
			add bl,1
			mov [di],bl
			continue:
			sub al,'0'
			mov cl,al
			call inputChar
			sub al,'0'
			mov bl,al
			mov al,cl
			mov cl,10
			mul cl
			add al,bl
			mov [si],al
			ret
			
			
			
			
	
	
	
	
	;subroutine to printout the number
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
	
	;print out carriage return
	printNextLine:
		mov dl,10
		mov ah,02h
		int 21h
		ret
		
	
	;input one character
	inputChar:
		mov ah,01h
		int 21h
		ret
	
	;print a character
	printChar:
		mov ah,02h
		int 21h
		ret
	
	.exit
end