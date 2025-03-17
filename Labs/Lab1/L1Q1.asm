.model tiny 
.186
.data
	arr db 45h, 82h, 91h, 73h, 13h, 45h, 24h, 0a8h, 75h, 0b2h
	len db 10
	result db 1 dup(?)
.code
	.startup
		lea si,arr
		mov cl,len
		mov al,[si]
		
		maxelement:
			cmp al,[si]
			ja continue
			mov al,[si]
			continue:
				inc si
				dec cl
				cmp cl,0
				jne maxelement
		
		mov	result,al
	.exit
end