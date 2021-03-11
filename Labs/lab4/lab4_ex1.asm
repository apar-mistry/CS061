;=================================================
; Name: Apar Mistry
; Email: amist007@ucr.edu	
; 
; Lab: lab 4, ex 1
; Lab section: 023
; TA: Shirin
; 
;=================================================
.orig x3000

;instructions=====================================
	LD R1, FIRST_VAL
	LD R2, ARR_PTR
LOOP
	STR R1, R2, #0 ; stores the value at R1 into the nth entry
	ADD R2, R2, #1 ; increments to the next slot in array
	ADD R1, R1, #1; increments the value at R1 by 1
	ADD R5, R1, #-10 ; if next value is 10
	BRnp	LOOP ; if it isn't, iterate again
	
	
	LD R4, ARR_PTR ; loading R4 with array pointer
	ADD R4, R4, #6 ; gets R4 to point to the 7th element because it goes from 0 - n-1
	
	LDR R2, R4, #0 ; load the 7th value that's at R7 to R2 with no offset
	




HALT
;Data=============================================
	FIRST_VAL	.FILL	#0
	ARR_PTR		.FILL	ARRAY
	
	
	
.orig x4000
	ARRAY .BLKW	#10 ;initializes empty array with 10 slots
	
	
.end
