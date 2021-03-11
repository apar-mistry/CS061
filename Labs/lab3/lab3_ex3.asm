;=================================================
; Name: Apar Mistry
; Email: amist007@ucr.edu
; 
; Lab: lab 3, ex 3
; Lab section: 023
; TA: Shirin
; 
;=================================================
.orig x3000

;instructions
	LEA R0, MESSAGE ; loads and out puts prompt
	PUTS
	
	LEA R4, ARR1 ; loads block of 10 spaces into R4
	LD R5, COUNTER ; loads counter aka 10 into R5
	DO_WHILE
		TRAP x20
		OUT
		STR R0, R4, #0 ; stores input 
		ADD R4, R4, #1 ; moves to the next spot in the array
		ADD R5, R5, #-1 ; incrememnts down
		BRp DO_WHILE2
	END_DO_WHILE_LOOP
	
	ADD R4, R4, #-10 ; allows it to be back at the beginning
	LD R5, COUNTER
	DO WHILE
		LDR R0, R4, #0
		OUT
		LEA R0, NEWLINE
		PUTS
		
		ADD R4,R4, #1
		ADD R5, R5, #-1
		BRp DO_WHILE2
	END_DO_WHILE2
	HALT

;data
	ARR1 .BKLW #10
	COUNTER .FILL #10
	MESSAGE .STRINGZ "Type 10 Chars\n"
	NEWLINE .STRINGZ "\n"

.end
