


.model tiny
.186
.data
    message db 'Enter a string: $'
    str1 db 100, 0, 100 dup('$')  ; Buffer for string input
    newline db 0Ah, 0Dh, '$'      ; Newline characters
    key db 100, 0, 100 dup('$')   ; Buffer for word input
    mess db 'Enter a word: $'
    found db 'Word is present in the string$'
    notfound db 'Word is absent$'
.code
.startup
    ; Print "Enter a string:"
    lea dx, message
    mov ah, 09h
    int 21h

    ; Read string input
    lea dx, str1
    mov ah, 0Ah
    int 21h

    ; Print newline
    lea dx, newline
    mov ah, 09h
    int 21h

    ; Print "Enter a word:"
    lea dx, mess
    mov ah, 09h
    int 21h

    ; Read word input
    lea dx, key
    mov ah, 0Ah
    int 21h

    ; Print newline
    lea dx, newline
    mov ah, 09h
    int 21h

    ; Initialize pointers
    lea si, str1 + 2  ; Point to the start of the string
    lea di, key + 2   ; Point to the start of the word

    ; Get lengths of input strings
    mov cl, str1 + 1  ; Length of the string
    mov ch, key + 1   ; Length of the word

    ; Check if the word is longer than the string
    cmp ch, cl
    ja word_absent    ; If word is longer, it cannot be present

    ; Main comparison loop
outer_loop:
    mov al, [si]      ; Load character from string
    mov bl, [di]      ; Load character from word
    cmp al, bl        ; Compare characters
    jne mismatch      ; If not equal, handle mismatch

    ; Characters match, move to next character
    inc si
    inc di
    dec ch            ; Decrement remaining word length
    jz word_present   ; If word length is 0, word is found

    ; Continue checking
    jmp outer_loop

mismatch:
    ; Reset word pointer and remaining length
    lea di, key + 2   ; Reset word pointer
    mov ch, key + 1   ; Reset remaining word length

    ; Move to next character in the string
    inc si
    dec cl            ; Decrement remaining string length
    jnz outer_loop    ; If string length is not 0, continue

    ; If we reach here, the word is not found
word_absent:
    lea dx, notfound
    mov ah, 09h
    int 21h
    jmp exit_program

word_present:
    lea dx, found
    mov ah, 09h
    int 21h

exit_program:
    ; Exit program
    mov ah, 4Ch
    int 21h
.exit
end