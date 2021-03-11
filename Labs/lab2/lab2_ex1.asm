;=================================================
; Name: Apar Mistry
; Email: amist007@ucr.edu
; 
; Lab: lab 2. ex 1
; Lab section: 023
; TA: Shirin
; 
;=================================================

.orig x3000


;Instructions--------------------------------------

	LD	R3,DEC_65
	LD	R4, HEXADEC_41
	HALT


;Data Store----------------------------------------

	DEC_65 .FILL #65
	HEXADEC_41 .FILL x41



.end