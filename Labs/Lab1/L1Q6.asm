.model tiny
.186
.data
	dividend db 54
	divisor db 5

.code
	.startup
		mov cl,dividend
		mov dl,divisor 
		mov ds:[1000h],cl
		mov ds:[1001h],dl
		
		mov al,ds:[1000h]
		mov bl,ds:[1001h]
		
		cmp al,bl
		jl done
		
		myloop:
			sub al,bl
			cmp al,bl
			jl done
			jmp myloop
			
		done:
			mov byte ptr ds:[2000h],al
			
	.exit
end
