.model tiny
.186
.data
num db 10
.code
	.startup
		mov cl,num
		cbw
		mov ax,1
		fact:
			cmp cx,1
			je done
			mul cx
			dec cx
			call fact
			done:
				ret
				
			
	.exit
end
