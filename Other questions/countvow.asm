
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
.model tiny
.186
.data 
 message db 'enter a string:$'
 str1 db 100,0,100 dup('$')
 buffer db 'AEIOUaeiou$'
 newline db 0Ah,0Dh,'$'
 countv db 0
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
  mov cl,[str1+1]
  mov ch,0
  lea di,buffer+2 
  
  outer_loop:
  mov al,[si]
  cmp al,'$'
  jz Exit
  
  inner_loop:
  mov bl,[di]
  cmp bl,'$'
  jz next_char 
  
  cmp al,bl
  je count 
  inc di
  jmp inner_loop
  
  count:
  inc countv
  
  next_char:
  inc si
  lea di,buffer+2
  jmp outer_loop 
  
  Exit:
.exit
end




                  