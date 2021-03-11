;=================================================
; Name: Apar Mistry	
; Email: amist007@ucr.edu
; 
; Lab: lab 2, ex 2
; Lab section: 023
; TA: Shirin
; 
;=================================================
.orig x3000


;Instructions--------------------------------------

	LDI	R3,DEC_65_PTR
	LDI	R4, HEXADEC_41_PTR

;-----------Incrementing values at R3 and R4 by 1 
	ADD	R3, R3, #1
	ADD	R4, R4, #1
	
;-----------Stores value of R3 and R4 respectively at both pointer locations----
	STI R3, DEC_65_PTR
	STI R4, HEXADEC_41_PTR
	HALT


;Data Store----------------------------------------
	
	DEC_65_PTR	.FILL	x4000
	HEXADEC_41_PTR	.FILL	x4001

;-------Used to load data in new locations aka remote data
	.orig x4000
	NEW_DEC_65 .FILL #65
	NEW_HEXADEC_41 .FILL x41



.end