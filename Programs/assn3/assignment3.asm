;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: 
; Email: 
; 
; Assignment name: Assignment 3
; Lab section: 
; TA:
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
LD R6, Value_ptr		; R6 <-- pointer to value to be displayed as binary
LDR R1, R6, #0			; R1 <-- value to be displayed as binary 
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------


HALT
;---------------	
;Data
;---------------
Value_ptr	.FILL xCB00	; The address where value to be displayed is stored


.ORIG xCB00					; Remote data
Value .FILL xABCD			; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.
;---------------	
;END of PROGRAM
;---------------	
.END
