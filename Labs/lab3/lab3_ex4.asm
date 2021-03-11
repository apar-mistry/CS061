;=================================================
; Name: Apar Mistry
; Email: amist007@ucr.edu
; 
; Lab: lab 3, ex 4
; Lab section: 023
; TA: Shirin
; 
;=================================================
.orig x3000

;instructions
	LEA R0, MESSAGE ; loads and out puts prompt
	PUTS
	
	LD R4, PTR ; loads block of 10 spaces into R4
	LD R5, EXITVAL
		NOT R5, R5
		ADD R5, R5, #1
	DO_WHILE
		TRAP x20
		OUT
		ADD R1, R0, R5 ;signal is tab. By adding the negative of it and storing at r4 can use BRz
		BRz TAB
		
		STR R0, R4, #0 ; stores input 
		ADD R4, R4, #1 ; moves to the next spot in the array
		BR DO_WHILE
	TAB ; this begins once user is done entering
	
	LD R0, COUNTER
	STR RO, R4, #0
	LD R4, PTR
	WHILE_THERE
		LDR R0, R4, #0
		OUT
		ADD R4, R4, #1
		ADD R0, R0, #0
		BRnp WHILE_THERE
	HALT

;data
	PTR .FILL x4000
	COUNTER .FILL #0
	MESSAGE .STRINGZ "Type 10 Chars\n"
	NEWLINE .STRINGZ "\n"
	EXITVAL .FILL x9

.end
