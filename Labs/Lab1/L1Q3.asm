.model tiny
.186
.data

.code
	.startup
		mov ax,01bch
		mov bx,0221h
		add ax,bx
		mov ds:[2000],ax
	.exit
end