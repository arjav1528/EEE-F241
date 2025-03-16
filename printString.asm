;Simple Program to take input and print output

.model tiny
.186
.data
    msg1 db 'Enter the Stirng to be displayed : $'
    maxinput db 10
    len db ?
    input db 10 dup(?)


.code
    .startup
        lea dx,msg1
        mov ah,09h
        int 21h



        lea dx,maxinput
        mov ah,0ah
        int 21h


        mov dl,10
		mov ah,02h
		int 21h


        lea dx,input      ;Adding $ sign to the end so that it can end correctly
        mov bx,dx
        mov cl,len
        mov ch,00h
        mov si,cx
        mov byte ptr [bx+si],'$'

        mov ah,09h
        int 21h


        mov ah,4ch
        int 21h





    .exit
end