
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

.model tiny
.186
.data  
 message1 db 'enter a string:$'
 newline db 0Ah,0Dh,'$'
 str1 db 100,0,100 dup('$')    
 str2 db 100,0,100 dup('$') 
 equal db 'string are equal$'
 noteq db 'strings are not equal$'
 
.code 
.startup 
 lea dx,message1
 mov ah,09h
 int 21h
 
 lea dx,str1
 mov ah,0Ah
 int 21h
 
 lea dx,newline
 mov ah,09h
 int 21h 
 
 lea dx,message1
 mov ah,09h
 int 21h
 
 lea dx,str2
 mov ah,0Ah
 int 21h
 
 lea dx,newline
 mov ah,09h
 int 21h
 
 lea si,str1+2
 lea di,str2+2
 mov cl,[str1+1]
 mov ch,[str2+1]

 cmp cl,ch
 jnz result 
 comp:
 mov al,[si]
 mov bl,[di]
 cmp al,bl
 jnz result
 inc si
 inc di 
 dec cl
 cmp cl,0
 jnz comp 
 jmp RESULT1
 
 result:
 lea dx,noteq
 mov ah,09h
 int 21h
 jmp Exit
 
 RESULT1:
 lea dx,equal
 mov ah,09h
 int 21h  
 
 Exit:
 
.exit
end




