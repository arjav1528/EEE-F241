
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

.model tiny
.186
.data 
 message db 'enter a string:$'
 str db 100,0,100 dup('$')
 newline db 0Ah,0Dh,'$'
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
  
  lea si,str+2
  mov cl,[str+1]
  mov ch,0
  convert:
  mov al,[si]
  cmp al,'a'
  jl Cap
  sub al,32
  mov [si],al
  inc si
  loop convert 
  
  lea dx,str+2
  mov ah,09h
  int 21h 
  jmp Exit
  
  Cap:
  cmp al,'A'
  jge convert_small 
  jmp Exit
  
  convert_small:
  add al,32
  inc si
  jmp convert
  
  
  Exit:
.exit
end




