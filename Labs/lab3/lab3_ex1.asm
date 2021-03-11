;=================================================
; Name: Apar Mistry
; Email: amist007@ucr.edu
; 
; Lab: lab 3, ex 1
; Lab section: 023
; TA: Shirin
; 
;=================================================
.orig x3000


;Instructions--------------------------------------
	LD R5, DATA_PTR ; stores value at R5
	ADD R6, R5, #1
	
	LDR R3, R5, #0
	LDR R4, R5, #0

;-----------Incrementing values at R3 and R4 by 1 
	ADD	R3, R3, #1
	ADD	R4, R4, #1
	

	STR R3, R5, #0
	STR R4, R6, #0
	HALT


;Data Store----------------------------------------
	
	DATA_PTR	.FILL	x4000 ;Step 1 use only one pointer

;-------Used to load data in new locations aka remote data
	.orig x4000
	NEW_DEC_65 .FILL #65
	NEW_HEXADEC_41 .FILL x41



.end
