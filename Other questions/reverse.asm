
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt


.model tiny
.186
.data  
 message1 db 'enter a string:$'
 newline db 0Ah,0Dh,'$'
 str1 db 100,0,100 dup('$')    
 
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
 
 lea si,str1+2
 mov cl,[str1+1] 
 mov ch,0
 lea di,si
 add di,cx
 dec di
 
 reverse:
 cmp si,di
 jae result  
 mov al,[si]
 mov bl,[di]
 xchg al,bl 
 mov [si],al
 mov [di],bl
 inc si
 dec di
 jmp reverse
 
 result:  
  
  lea dx,newline
  mov ah,09h
  int 21h
  
  lea dx,str1+2
  mov ah,09h
  int 21h
 
 
.exit
end




