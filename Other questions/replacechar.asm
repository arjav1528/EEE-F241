

.model tiny
.186
.data
 message db 'enter a string:$'
 str db 100,0,100 dup('$')
 newline db 0Ah,0Dh,'$' 
 mess db 'enter key:$'
 key db 2,0,2 dup('$') 
 mess1 db 'enter a character you wanna replace:$'
 char db 2,0,2 dup('$')
.code
.startup
  lea dx,message
  mov ah,09h
  int 21h
  
  lea dx,str
  mov ah,0Ah
  int 21h
  
  lea dx,newline
  mov ah,09h
  int 21h
  
  lea dx,mess1
  mov ah,09h
  int 21h
  
  lea dx,char
  mov ah,0Ah
  int 21h
  
  lea dx,newline
  mov ah,09h
  int 21h
  
  lea dx,mess
  mov ah,09h
  int 21h
  
  lea dx,key
  mov ah,0Ah
  int 21h
  
  lea dx,newline
  mov ah,09h
  int 21h 
  
  lea si,str+2
  mov cl,[str+1]
  mov ch,0
  outer_loop:
  lea di,char+2
  push di
  pop di 
  mov bl,[di]
  cmp [si],bl
  jz result:
  inc si
  cmp [si],'$'
  jnz outer_loop
  jmp Exit
  
  result:
  lea di,key+2
  mov al,[di]
  mov [si],al 
  inc si
  jmp outer_loop
  
  Exit:
  lea dx,str+2
  mov ah,09h
  int 21h
  
  

  
.exit
end





