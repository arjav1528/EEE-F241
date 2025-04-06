
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

.model tony
.186
.data
  str1 db 'silent$'
  str2 db 'listens$'
  m1 db 'they are anagrams$'
  m2 db 'not anagrams$'
.code
.startup
  lea si,str1+2
  lea di,str2+2 
  mov cl,[str1+1]
  mov ch,[str2+1]
  cmp cl,ch
  jnz notana
  outer_loop:
  mov al,[si]
  mov bl,[di]
  cmp al,bl
  jz inner
  inc di
  cmp [di],'$'
  jnz outer_loop 
  lea dx,m1
  mov ah,09h
  int 21h
  jmp Exit
  
  inner:
  inc si
  lea di,str2+2
  cmp [si],'$'
  jnz outer_loop
  
  
  
  notana:
  lea dx,m2
  mov ah,09h
  int 21h
  Exit:
  
.exit
end


