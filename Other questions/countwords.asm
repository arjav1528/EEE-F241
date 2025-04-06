
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

.model tiny
.186
.data
 message db 'enter a string:$'
 str db 100,0,100 dup('$')
 newline db 0Ah,0Dh,'$'
 countn db 0
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
  loopyy:
  cmp [si],' '
  jz count  
  cmp [si],'.'
  jz count
  inc si
  cmp [si],'$'
  jnz loopyy
  jmp result 
  
  count:
  inc countn
  inc si
  jmp loopyy 
  
  result:
  
.exit
end




