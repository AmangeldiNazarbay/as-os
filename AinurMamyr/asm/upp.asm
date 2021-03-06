;ml64 /c upp.asm
;link /subsystem:console upp.obj kernel32.Lib MyLib-64.obj /ENTRY:main /largeaddressaware:no

ExitProcess     proto 
WriteInt64      proto
WriteString     proto
ReadString      proto
Crlf            proto

BUFMAX = 128 						; maximum buffer size

.data
message BYTE "Enter the text:",0
array BYTE 50 DUP(?)
buffer BYTE BUFMAX+1 DUP(0)
bufSize QWORD ?

.code
main PROC
	
	mov rdx,OFFSET message;         ; display a message
	call WriteString

	mov rcx,BUFMAX 					; max character count
	mov rdx,OFFSET buffer 			; point to the buffer
	call ReadString 				; input the string
	
	mov bufSize,rax 				; save the length
	call Crlf


	mov rcx,LENGTHOF buffer
	mov rsi,OFFSET buffer
L1: 
	and BYTE PTR [rsi],11011111b 	; clear bit 5
	inc rsi
	loop L1
	
	call WriteString
	mov rdx,OFFSET buffer 			; display the buffer
	
	call Crlf
	call ExitProcess
main ENDP
END