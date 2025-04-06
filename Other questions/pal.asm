
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

.model tiny
.186
.data  
 message1 db 'enter a string:$'
 newline db 0Ah,0Dh,'$'
 str1 db 100,0,100 dup('$')    
 printpal db 'its a palindrome$'
 printnotpal db 'its not a palindrome$'
 
.code
.startup   
   lea dx,message1
   mov ah,09h
   int 21h
   
   lea dx,newline
   mov ah,09h
   int 21h    
   
   lea dx,str1
   mov ah,0Ah
   int 21h  
   
   lea dx,newline
   mov ah,09h
   int 21h
  
   lea si,str1+1
   mov cl,[si]
   mov ch,0
   lea si,str1+2
   lea di,si
   add di,cx
   dec di 
    check_palindrome:
   cmp si,di
   jae is_palindrome  
   mov al,[si]
   mov bl,[di]
   cmp al,bl
   jne not_palindrome  
   inc si
   dec di
   jmp check_palindrome
   
   is_palindrome:
   lea dx,printpal
   mov ah,09h
   int 21h 
   jmp Exit
   
   not_palindrome: 
   lea dx,printnotpal
   mov ah,09h
   int 21h  
   
   Exit:
   mov ah,4ch
   int 21h
  
.exit
end




