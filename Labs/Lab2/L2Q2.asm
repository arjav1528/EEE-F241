.model tiny
.186
.data
	arr db 0010h,0020h,0030h
	len db 3
	key db 0020h
.code
	.startup
		mov cl,len
		mov bl,key
		lea si,arr
		mov dx,-1
		mov ax,si
		
		myloop:
			cmp bl,[si]
			jne notEqual
			mov dx,0
			sub si,ax
			mov ax,si
			jmp exit
			notEqual:
				inc si
				dec cl
				jnz myloop
		
		exit:
			
	.exit
end