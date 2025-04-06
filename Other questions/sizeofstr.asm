
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

.model tiny
.186
.data
 message db 'enter a string:$'
 buffer db 100,0,100 dup('$') 
 newline db 0Ah,0Dh,'$'
 size dw 0
.code
.startup
 lea dx,message
 mov ah,09h
 int 21h
 
 lea dx,newline
 mov ah,09h
 int 21h
 
 lea dx,buffer
 mov ah,0Ah
 int 21h
 
 lea si,buffer+1
 mov cl,[si] 
 mov ch,0
 mov size,cx 
.exit
end



