;psst i like bubble sort more

.model tiny
.186
.data
	arr dw 0010h,0050h,0030h,0031h,0029h,0340h,0099h,0808h,0a00h,0b00h
	len dw 10
.code
	.startup
		lea bx,arr
		mov cx,len
		
		;outer loop variaale
		xor ax,ax
		dec cx
		outerloop:
			cmp ax,cx
			je exit
			;inner loop variaale
			xor si,si
			mov dx,cx
			sub dx,ax
			push ax
			mov ax,2
			mul dx
			mov dx,ax
			pop ax
			innerloop:
				cmp  dx,si
				jne dontjumpout
				inc ax
				jmp outerloop
				dontjumpout:
				push ax
				push dx
				lea di, ds:[bx + si]
				lea bp, ds:[bx + si + 2]
				mov ax, ds:[bx + si]
				mov dx, ds:[bx + si + 2]
				cmp ax,dx
				jb noswap
				call swap
				noswap:
				pop dx
				pop ax
	
				add si,2
				jmp innerloop
			
			;inc ax
			;jmp outerloop
			
		exit:
			mov ah,4ch
			int 21h
		swap:
			push [di]
			push [bp]
			pop [di]
			pop [bp]
			ret
			
	.exit
end