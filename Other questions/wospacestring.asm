
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

.model tiny
.186
.data
 message db 'enter a string:$'
 str1 db 100,0,100 dup('$')
 newline db 0Ah,0Dh,'$'
 mes db 'entered string without spaces is:$'
 str2 db 100,0,100 dup('$')
.code
.startup 
  lea dx,message
  mov ah,09h
  int 21h
  
  lea dx,str1
  mov ah,0Ah
  int 21h
  
  lea dx,newline
  mov ah,09h
  int 21h
  
  lea si,str1+2 
  lea di,str2+2
  mov cl,[str1+1]
  mov ch,0
  outer_loop:
  cmp [si],' '
  jz swap
  mov al,[si]
  mov [di],al
  inc si
  inc di
  loop outer_loop
  jmp Result
  
  swap:
  inc si
  mov al,[si]
  mov [di],al
  inc di 
  inc si
  jmp outer_loop  
  
  Result: 
  lea dx,mes
  mov ah,09h
  int 21h 
  
  lea dx,newline
  mov ah,09h
  int 21h
  
  lea dx,str2+2
  mov ah,09h
  int 21h
  
  
  
  
.exit
end



