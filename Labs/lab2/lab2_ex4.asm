;=================================================
; Name: Apar Mistry
; Email:  amist007@ucr.edu
; 
; Lab: lab 2, ex 4
; Lab section: 023 
; TA: Shirin
; 
;=================================================

.orig x3000

;---Instructions----------------------------------
	LD R0, HEX_61 ;respectively loading both hex values into R0 and R1
	LD R1, HEX_1A
	
	LOOP
		OUT ;Prints R0 ascii val
		add 	R0,R0,#1
		add 	R1, R1,#-1
		BRp	LOOP
		


;Data stores--------------------------------------

	HEX_61	.FILL	x61
	HEX_1A	.FILL	X1A


.end