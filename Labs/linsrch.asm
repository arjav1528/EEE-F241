.model tiny
.186
.data
    arr1 db 30h,31h,31h
    size1 db 3h
    key db 30h
.code
    .startup
        lea si,arr1
        mov dl,size1
        mov dh,key
        mov al,0h
        loop1:
            cmp al,1h
            je Exit
            cmp dh,[si]
            jne notEqual
            mov al,1h
        notEqual:
            inc si
            dec dl
            jnz loop1
        Exit:
            mov ds:[1002h],al
    .exit
end
