; Scanning an Array             (ArrayScan.asm)
; Scan an array for the first nonzero value.

;ml64 /c MyLib-64.asm
;ml64 /c ArrayScan.asm
;link /subsystem:console ArrayScan.obj kernel32.Lib MyLib-64.obj /ENTRY:main /largeaddressaware:no

ExitProcess PROTO
WriteInt64 PROTO
WriteString PROTO
Crlf PROTO


 
 .data 
 intArray  QWORD  0,0,0,20,35,-12,66,4,0 
 
;intArray QWORD  1,0,0,0 ; alternate test data 
;intArray QWORD  0,0,0,0
;intArray QWORD  0,0,0,1 
 noneMsg  BYTE "A non-zero value was not found",0
 
 .code 
 main PROC
	mov rbx,OFFSET intArray						; point to the array
	mov rcx,LENGTHOF intArray 					; loop counter
	 		
L1:
	cmp   WORD PTR [rbx],0 						; compare value to zero
	jnz   found 								; found a value
	add   rbx,TYPE rbx							; point to next 
	loop  L1 									; continue the loop 
	jmp   notFound 								; none found 
found: 											; display the value 
	movsx rax,WORD PTR[rbx] 					; sign-extend into EAX 
	call  WriteInt64 
	jmp   quit
notFound: 										; display "not found" message
	mov   rdx,OFFSET noneMsg
	call WriteString 
quit:
	call Crlf 
	
	
call  ExitProcess
main endp
PUBLIC main
end

 