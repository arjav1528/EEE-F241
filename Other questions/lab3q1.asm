
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

.model tiny
.186
.data
 message db 'enter a string:$'
 str db 22 dup('$')
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
  
  lea dx,str+2
  mov ah,09h
  int 21h
.exit
end


                                                       
                                                       