.model tiny
.186
.data

.code
	.startup
		mov byte ptr ds:[1000h],0004h
		mov byte ptr ds:[1001h],0008h
		mov al,ds:[1000h]
		mov ah,ds:[1001h]
		mul ah
		mov word ptr ds:[2000h], ax
	.exit
end