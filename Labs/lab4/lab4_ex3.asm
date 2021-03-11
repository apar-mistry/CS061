;=================================================
; Name: 
; Email: 
; 
; Lab: lab 4, ex 3
; Lab section: 023
; TA: Shirin
; 
;=================================================
.orig x3000



;Instructions=====================================
	LD R1, FIRST_VAL ; stores first power of 2 at R1
	LD R2, ARR_PTR ; stores pointer of array at R2
	LD R3, maxVAL ; loads value so loop ends 
POWLOOP
	STR R1, R2, #0
	ADD R2, R2, #1
	ADD R1, R1, R1 ; referenced LC-3 guide on ELEARN. This increments using bitshift
	ADD R4, R1, R3 ;checks to se if next value is 1024
	BRnp	POWLOOP
	
	LD R5, ARR_PTR
	ADD R4, R4, #d
	
	LDR R2, R4, #0


HALT
;Data=============================================
	FIRST_VAL 	.FILL	x1 ;storing first power of 2: 2^0 = 1
	ARR_PTR 	.FILL	ARR
	maxVAL 		.FILL	#-1024
.orig x4000
	ARR	.BLKW	#10 ; initializes array with 10 slots
