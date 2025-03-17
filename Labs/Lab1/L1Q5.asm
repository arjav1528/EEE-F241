.model tiny
.186
.data
	arr db 0010h,0020h,0030h
	len db 3
	key db 0000h
.code
	.startup
		mov cl,len
		mov bl,key
		lea si,arr
		mov ax,0
		
		myloop:
			cmp bl,[si]
			jne notEqual
			mov ax,1
			jmp exit
			notEqual:
				inc si
				dec cl
				jnz myloop
		
		exit:
			mov ds:[1002h],ax
			
			
	.exit
end