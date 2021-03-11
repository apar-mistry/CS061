;=================================================
; Name: Apar Mistry	
; Email: amist007@ucr.edu 
; 
; Lab: lab 2, ex 3
; Lab section: 023 
; TA: Shirin
; 
;=================================================
.orig x3000


;Instructions--------------------------------------
	LD	R5, DEC_65_PTR
	LD	R6, HEXADEC_41_PTR
	LDR	R3,R5, #0
	LDR	R4, R6, #0

;-----------Incrementing values at R3 and R4 by 1 
	ADD	R3, R3, #1
	ADD	R4, R4, #1
	
;-----------Relatively Stores value of R3 and R4 respectively at both pointer locations----
	STR R3, R5, #0
	STR R4, R6, #0
	HALT


;Data Store----------------------------------------
	
	DEC_65_PTR	.FILL	x4000
	HEXADEC_41_PTR	.FILL	x4001

;-------Used to load data in new locations aka remote data
	.orig x4000
	NEW_DEC_65 .FILL #65
	NEW_HEXADEC_41 .FILL x41



.end