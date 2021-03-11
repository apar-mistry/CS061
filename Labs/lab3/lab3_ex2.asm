;=================================================
; Name: Apar Mistry
; Email: amist007@ucr.edu
; 
; Lab: lab 3, ex 2
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
	BRp DO_WHILE
	HALT

;data
	ARR1 .BKLW #10
	COUNTER .FILL #10
	MESSAGE .STRINGZ "Type 10 Chars\n"


.end
