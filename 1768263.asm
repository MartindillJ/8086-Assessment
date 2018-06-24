TITLE x86 Assembly Language Program

COMMENT @
------------------------------------------------------------------------------------------------------------------------- 
Student No: 1768263
Student Name: Joseph Ciriaco Martindill
Module Code: CMT102
Module Title: Computational Systems
Coursework Title: 8086 Assembly Language Programming
Lecturer: Dr M Morgan
Hours Spent on this Exercise: ~40
------------------------------------------------------------------------------------------------------------------------- 
The program works perfectly, but requires calling functions from Kip Irvine's Library
------------------------------------------------------------------------------------------------------------------------- 
Program instructions:
    1. Read in two strings
    2. In each string convert UPPERCASE characters to lowercase
    3. In each string remove all non-alphabetic characters
    4. In each string count the frequency of each character
    5. Compare the frequencies for each string to test if they are anagrams

At each step, output the results, exactly following the format shown in the following examples:
  enter string: Eleven plus two                                enter string: Eleven plus two
  just read string: Eleven plus two                            just read string: Eleven plus two
  enter string: = twelve (12) PLUS (+) one (1).                enter string: = Thirteen.
  just read string: = twelve (12) PLUS (+) one (1).            just read string: = Thirteen.
  converted to lower case: eleven plus two                     converted to lower case: eleven plus two
  converted to lower case: twelve (12) plus (+) one (1).       converted to lower case: = thirteen.
  removed non-alphabetic characters: elevenplustwo             removed non-alphabetic characters: elevenplustwo
  removed non-alphabetic characters: twelveplusone             removed non-alphabetic characters: thirteen
  character counts: 00003000000201110011111000                 character counts: 00003000000201110011111000
  character counts: 00003000000201110011111000                 character counts: 00002001100001000102000000
  strings ARE anagrams                                         strings are NOT anagrams
------------------------------------------------------------------------------------------------------------------------- 
@

INCLUDE Irvine32.inc                    ; Library

COMMENT @
Acknowledgements
------------------------------------------------------------------------------------------------------------------------- 
Most of the code in this library was written by Kip Irvine, in particular, the four procedures called in this piece:
    WriteString, ReadString, Crlf and WriteDec, which I have summarised below:

;----------------------------------------------------------- ;----------------------------------------------------------- 
WriteString proc                                             ReadString proc
;                                                            ; Reads a string up to 128 characters from the console
;                                                            ; past the end of line, and places the characters in a buffer
;                                                            ; Strips off CR/LF from the input buffer
;                                                            ; Receives: EDX points to the buffer
; Writes a null-terminated string to standard output         ;           ECX contains the maximum string length
; Input parameter: EDX points to the string                  ; Returns:  EAX = size of the input string
;                                                            ; Comments: Stops when Enter key (0Dh) is pressed. ReadConsole
;                                                            ; places 0Dh,0Ah in the buffer, so we use a local variable
;                                                            ; to overwrite the caller's memory. After calling ReadConsole
;                                                            ; we copy the characters back to the buffer
WriteString endp                                             ReadString endp
;----------------------------------------------------------- ;----------------------------------------------------------- 
Crlf proc                                                    WriteDec proc
; Writes a carriage return / linefeed                        ; Writes an unsigned 32-bit decimal number to standard output
; sequence (0Dh,0Ah) to standard output                      ; Input parameters: EAX = the number to write
Crlf endp                                                    WriteDec endp      "Irvine32.asm" (Read.pudn.com 2002)
;----------------------------------------------------------- ;----------------------------------------------------------- 

Also, special thanks go to Gerald Cahill for his online help file "Irvine Library Help" (2006)
@

.data
max=100
array1 byte 26 DUP (0)
array2 byte 26 DUP (0)
string1 byte 'enter string: ', 0
string2 byte 'just read string: ', 0
string3 byte max+1 DUP (?)
target3  byte  SIZEOF string3 DUP(0), 0
string4 byte 'enter string: ', 0
string5 byte 'just read string: ', 0
string6 byte max+1 DUP (?)
target6  byte  SIZEOF string6 DUP(0), 0 
string7 byte 'converted to lower case: ', 0
string8 byte 'converted to lower case: ', 0
string9 byte 'removed non-alphabetic characters: ', 0
string10 byte 'removed non-alphabetic characters: ', 0
strin11 byte 'character counts: ', 0
strin12 byte 'character counts: ', 0
string11 byte 'strings are NOT anagrams', 0
string12 byte 'strings ARE anagrams', 0

count1 dword ?
count2 dword ?
count3 dword ?
count4 dword ?

.code
main PROC
    mov ebx, 0

    call readStr
    call Loop1
    call Loop2
    call Loop3
    call Loop4
    call Loop5
    call Loop6

    exit
main ENDP

readStr PROC                            ; User inputs strings
    pop ebx
    mov edx, OFFSET string1             ; Enter 1st string
    call WriteString                    ; Writes a string to standard output (EDX points to string1)
    mov esi, 0
    mov ecx, max                        ; The max number of characters to read
    mov edx, OFFSET string3             ; Read string (EDX points to the input buffer)
    call ReadString

    COMMENT @
    Reads string up to ECX non-null characters from standard input, stopping when the user presses Enter. A null byte is stored following input,
    the carriage return and line feed chars are not placed in the buffer. ECX should be smaller than the buffer size because the null byte
    could be the (ECX+1)th character "Irvine Library Help" (Cahill, 2006)
    @

    mov count1, eax                     ; EAX = size of input string
    call Crlf                           ; Writes 0Dh, 0Ah to standard output
    mov edx, OFFSET string2
    call WriteString                    ; Writes string to output (string2)
    mov edx, OFFSET string3
    call WriteString                    ; Writes string to output (string3)

    call Crlf                           ; 0Dh, 0Ah
    call Crlf                           ; 0Dh, 0Ah
    mov edx, OFFSET string4
    call WriteString                    ; Writes string to output (string4)
    mov esi, 0
    mov ecx, max
    mov edx, OFFSET string6
    call ReadString                     ; Reads string from input
    mov count2, eax                     ; Saves string length

    call Crlf                           ; 0Dh, 0Ah
    mov edx, OFFSET string5
    call WriteString                    ; Writes string to output (string5)
    mov edx, OFFSET string6
    call WriteString                    ; Writes string to output (string6)
    push ebx

    ret
readStr ENDP

Loop1 PROC                              ; Lowercase program
    pop ebx
    mov esi, 0
    mov ecx, 0
    mov esi, OFFSET string3
    mov ecx, SIZEOF string3
    mov eax, count1

    L1:                                 ; Lowercase start
        or byte ptr[esi], 00100000b     ; Convert to lowercase "Exam 3 Short Answers" (Quinn, 2018)

        COMMENT @
        Sometimes, to assist the assembler in translating references to memory, we use a pointer directive. Generally, PTR forces the expression
        to be treated as a pointer of specified type i.e. load 8-bit value from ESI "Directives BYTE PTR, WORD PTR, DWORD PTR" (C-jump.com 1999)
        @

        inc esi                         ; Increase position of ESI
        cmp eax, 0                      ; Compares whether the counter has reached 0
        jz out1
        dec eax                         ; Decrease counter
        Loop L1                         ; Repeat for entire string

    out1:
        call Crlf                       ; 0Dh, 0Ah
        call Crlf                       ; 0Dh, 0Ah
        mov edx, OFFSET string7
        call WriteString                ; Writes string to output (string7)

        mov edx, OFFSET string3
        call WriteString                ; Writes string to output (string3)

        mov esi, OFFSET string6         ; 2nd string lowercase
        mov ecx, LENGTHOF string6
        mov eax, count2

    L2:
        or byte ptr[esi], 00100000b     ; Convert to lowercase
        inc esi                         ; Increase position
        cmp eax, 0                      ; Has the counter reached 0?
        jz out2
        dec eax                         ; Decrease counter
        Loop L2                         ; Repeat

    out2:
        call Crlf                       ; 0Dh, 0Ah
        mov edx, OFFSET string8
        call WriteString                ; Writes string to output (string8)
        mov edx, OFFSET string6
        call WriteString                ; Writes string to output (string6)

        call Crlf                       ; 0Dh, 0Ah
        push ebx

        ret
Loop1 ENDP

Loop2 PROC                              ; Remove non-alphabetic characters
    pop ebx
    mov esi, OFFSET string3
    mov edi, OFFSET target3

    L3:                                 ; Check character "STRING, WITH. PUNCTUATION: AND * SPACES!$" (Rodríguez, 2016)
        mov al, [esi]                   ; Put the character to AL
        cmp al, 0                       ; and analyse it
        je final
        cmp al, 97                      ; Below 'a' (ASCII)?
        jb not_letter
        cmp al, 122                     ; Above 'z'?
        ja not_letter
        mov [edi], al
        inc di                          ; Position to next character

    not_letter:
        inc si                          ; Move to next character
        jmp L3

    final:
        mov [edi], al
        mov edx, OFFSET string9
        call WriteString                ; Writes string to output (string9)
        mov edx, OFFSET target3
        call WriteString                ; Writes string to output (target3)
        call Crlf                       ; 0Dh, 0Ah
        call Crlf                       ; 0Dh, 0Ah

    push ebx
    ret
Loop2 ENDP

Loop3 PROC
    pop ebx
    mov esi, OFFSET string6
    mov edi, OFFSET target6

    L4:
    mov al, [esi]
    cmp al, 0                           ; Equals 'NULL'?
    je final1
    cmp al, 97                          ; Below 'a'?
    jb not_letter1
    cmp al, 122                         ; Above 'z'?
    ja not_letter1

        mov [edi], al
        inc di                          ; Next character
        not_letter1:
            inc si
            jmp L4

        final1:
            mov [edi], al
            mov edx, OFFSET string10
            call WriteString            ; Writes string to output (string10)
            mov edx, OFFSET target6
            call WriteString            ; Writes string to output (target6)
            call Crlf                   ; 0Dh, 0Ah

    push ebx
    ret
Loop3 ENDP

Loop4 PROC                              ; Character count
    pop ebx
    xor edx, edx
    mov edi, 0
    mov edx, 0
    mov ecx, 0
    mov edi, OFFSET target3
    mov ecx, SIZEOF target3
    mov eax, 0

    L5:
        mov al, [edi]
        cmp al, 97                      ; Below 'a'?
        jb ext
        cmp al, 122                     ; Above 'z'?
        ja ext
        sub al, 97                      ; Character - 97 (make letters from 0 to 25)
        add array1[eax], 1
        add edi, type array1
        Loop L5                         ; Repeat

    ext:
        call Crlf                       ; 0Dh, 0Ah
        mov edx, OFFSET strin11
        call WriteString                ; Writes string to output (strin11)
        xor edx, edx
        mov esi, 0
        mov ecx, LENGTHOF array1
        mov count3, ecx

    L6:
        cmp count3, 0
        jz ex
        mov al, array1[esi]             ; Unsigned number
        call WriteDec                   ; Writes number to standard output in decimal format with no leading zeros
        dec count3
        inc esi                         ; Increase position
        Loop L6                         ; Repeat
    ex:
        push ebx
    ret
Loop4 ENDP

Loop5 PROC
    pop ebx
    xor edx, edx
    mov edi, 0
    mov edx, 0
    mov ecx, 0
    mov edi, OFFSET target6
    mov ecx, SIZEOF target6
    mov eax, 0

    L7:
        mov al, [edi]
        cmp al, 97                      ; Below 'a'?
        jb ext1
        cmp al, 122                     ; Above 'z'?
        ja ext1

        sub al, 97
        add array2[eax], 1
        add edi, type array2
        Loop L7                         ; Repeat

    ext1:
        call Crlf                       ; 0Dh, 0Ah
        call Crlf                       ; 0Dh, 0Ah
        mov edx, OFFSET strin12
        call WriteString                ; Writes string to output (strin12)
        xor edx, edx
        mov esi, 0
        mov ecx, LENGTHOF array2
        mov count4, ecx

    L8:
        cmp count4, 0
        jz ex1
        mov al, array2[esi]             ; 2nd unsigned number
        call WriteDec                   ; Writes number to output in decimal format

        dec count4
        inc esi                         ; Increase position
        Loop L8                         ; Repeat

    ex1:
        push ebx
    ret
Loop5 ENDP

Loop6 PROC
    pop ebx
    mov esi, 0
    mov edi, 0
    mov edx, 0
    mov edx, LENGTHOF array1

    L9:
        mov al, array1[esi]
        mov cl, array2[edi]
        cmp al, cl
        jz L10
        jnz L11

    L10:
        inc esi                         ; Increase position
        inc edi
        dec edx
        cmp edx, 0
        jz L12
        jmp L9

    L11:
        call Crlf                       ; 0Dh, 0Ah
        call Crlf                       ; 0Dh, 0Ah
        mov edx, OFFSET string11
        call WriteString                ; Writes string to output (string11)
        jmp L13

    L12:
        call Crlf                       ; 0Dh, 0Ah
        call Crlf                       ; 0Dh, 0Ah
        mov edx, OFFSET string12
        call WriteString                ; Writes string to output (string12)

    L13:
        call Crlf                       ; 0Dh, 0Ah
        call Crlf                       ; 0Dh, 0Ah

    push ebx
    ret
Loop6 ENDP
END main

COMMENT @
References
------------------------------------------------------------------------------------------------------------------------- 
Cahill, G. 2006. Irvine Library Help [Online]. Available at: http://programming.msjc.edu/asm/help/index.html?page=source%2Fabout.htm
[Accessed: Dec 2017]

C-jump.com, 1999. Directives BYTE PTR, WORD PTR, DWORD PTR [Online]. Available at:
http://www.c-jump.com/CIS77/ASM/Instructions/I77_0250_ptr_pointer.htm [Accessed: Dec 2017]

Irvine, K. 2011. Assembly Language for x86 Processors (6th Edition, International). London: Pearson.

Quinn, M. 2018. Exam 3 Short Answers [Online]. Available at: https://quizlet.com/206980177/exam-3-short-answers-flash-cards/
[Accessed: Dec 2017]

Read.pudn.com 2005. Irvine32 Link Library Source Code (Irvine32.asm) [Online]. Available at:
http://read.pudn.com/downloads211/sourcecode/asm/991242/MASM/example/Lib32/Irvine32.asm__.htm [Accessed: Dec 2017]

Rodríguez, J. 2016. STRING, WITH. PUNCTUATION: AND * SPACES!$ [Online]. Available at:
https://stackoverflow.com/questions/36721559/how-to-remove-all-punctuation-and-spaces-in-a-string/36929832 [Accessed: Dec 2017]
@