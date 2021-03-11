;=================================================
; Name: Apar Mistry
; Email: amist007@ucr.edu
; 
; Lab: lab 6, ex 1
; Lab section: 023
; TA: Shirin
; 
;=================================================
.ORIG x3000

	; Instructions (test harness)
	
	LEA R1, CHAR_ARRAY ; address to store array
	;---- Calls subroutine
	LD R6, SUB_GET_STRING_PTR
	JSRR R6 ; invokes subroutine
	;---- Calls PUTS to print string
	LEA R0, CHAR_ARRAY
	PUTS
	
	HALT
	
	; Local data
	
	SUB_GET_STRING_PTR .FILL x3200 ; location of subroutine
	CHAR_ARRAY .BLKW #100 ;hardcoded array for R1 - test bench

;=======================================================================
; Subroutine: SUB_GET_STRING_3200
; Parameter: (R1) The starting address of the character array
; Postcondition: The subroutine has prompted the user to input a string,
;                terminated by the [ENTER] key (the "sentinel"), and has
;                stored the received characters in an array of
;                characters starting at (R1). The array is NULL-
;                terminated; the sentinel character is NOT stored.
; Return Value: (R5) The number of non-sentinel characters read from the
;                    user. R1 contains the starting address of the array
;                    unchanged.
;=======================================================================
.ORIG x3200

	;========================
	; Subroutine Instructions
	;========================

	SUB_GET_STRING_3200

		ST R0, BACKUP_R0_3200
		ST R1, BACKUP_R1_3200
		ST R2, BACKUP_R2_3200
		ST R3, BACKUP_R3_3200
		ST R4, BACKUP_R4_3200
		ST R6, BACKUP_R6_3200
		ST R7, BACKUP_R7_3200
		
		; Get negative NEWLINE
		LD R2, NEWLINE_3200
		NOT R2, R2
		ADD R2, R2, #1
		AND R5, R5, x0 ; setting R5 to 0
		
		CHAR_LOOP_3200
			GETC
			OUT
			
			STR R0, R1, #0
			
			ADD R0, R0, R2 ; checking if newline was entered
			BRz END_CHAR_LOOP_3200 
			
			ADD R1, R1, #1 ; shift to next slot in array
			ADD R5, R5, #1 
			
			BR CHAR_LOOP_3200 ;iterate again
		END_CHAR_LOOP_3200
		
		AND R0, R0, x0 ;checking
		STR R0, R1, #0
		; Restoring backup registers.
		LD R0, BACKUP_R0_3200
		LD R1, BACKUP_R1_3200
		LD R2, BACKUP_R2_3200
		LD R3, BACKUP_R3_3200
		LD R4, BACKUP_R4_3200
		LD R6, BACKUP_R6_3200
		LD R7, BACKUP_R7_3200
		RET

	;========================
	; Subroutine Data
	;========================

	BACKUP_R0_3200 .BLKW #1
	BACKUP_R1_3200 .BLKW #1
	BACKUP_R2_3200 .BLKW #1
	BACKUP_R3_3200 .BLKW #1
	BACKUP_R4_3200 .BLKW #1
	BACKUP_R5_3200 .BLKW #1
	BACKUP_R6_3200 .BLKW #1
	BACKUP_R7_3200 .BLKW #1
	NEWLINE_3200 .FILL '\n'

.END
