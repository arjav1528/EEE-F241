
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
.model tiny
.186
.data  
 message1 db 'enter a string:$'
 message2 db 'enter a character you want to search:$'
 newline db 0Ah,0Dh,'$'
 str1 db 100,0,100 dup('$')
 str2 db 100,0,100 dup('$') 
 pnt db 'character found at position:$'
 pnt2 db 'character not found$'
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
  
  lea dx,message2
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
  mov bl,0
  mov ch,0 
  check:
  mov al,[si]
  cmp al,[di]
  jz result
  inc si  
  inc bl
  loop check 
  
  lea dx,pnt2
  mov ah,09h
  int 21h 
  jmp EXIT
  
  result: 
  lea dx,pnt
  mov ah,09h
  int 21h     
    mov ax,bx
  showNum:
    mov cx, 0       ; CX = digit count
    mov bx, 10      ; Divisor

    convertLoop:
        mov dx, 0       ; Clear DX for division
        div bx          ; AX / 10, remainder in DX
        push dx         ; using stack here since the last digit needs to be displayed first
        inc cx          ; Increment digit count
        cmp ax,0        ; Check if AX is 0
        jnz convertLoop ; Continue if not zero

    printLoop:
        pop dx         ; Get digit from stack
        add dl, '0'    ; Convert to ASCII
        mov ah, 02H    ; INT21 argument to print one character
        int 21H
        dec cx
        jnz printLoop 
  
  EXIT:
  mov ah,4ch
  int 21h
  
.exit
end
