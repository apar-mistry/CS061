;=================================================
; Name: Apar Mistry
; Email: amist007@ucr.edu
; 
; Lab: lab 6, ex 2
; Lab section: 023
; TA: Shirin
; 
;=================================================
.ORIG x3000

	; Instructions (test harness)
	
	LEA R1, CHAR_ARRAY
	LD R6, SUB_GET_STRING_PTR
	JSRR R6
	
	LEA R0, CHAR_ARRAY
	PUTS
	
	; EX2 START
	
	LD R0, NEWLINE
	OUT
	
	LEA R0, HEADER
	PUTS
	LEA R0, CHAR_ARRAY
	PUTS
	
	LD R6, SUB_IS_PALINDROME_PTR
	JSRR R6
	
	ADD R4, R4, #0
	BRp TRUE_CONDITION
	
	FALSE_CONDITION
		LEA R0, FOOTER_FALSE
		PUTS
		BR END_OF_CONDITIONS
	TRUE_CONDITION
		LEA R0, FOOTER_TRUE
		PUTS
	END_OF_CONDITIONS
	
	HALT
	
	; Local data
	
	NEWLINE .FILL '\n'
	HEADER .STRINGZ "The string \""
	FOOTER_TRUE .STRINGZ "\" IS a palindrome"
	FOOTER_FALSE .STRINGZ "\" IS NOT a palindrome"
	SUB_GET_STRING_PTR .FILL x3200
	SUB_IS_PALINDROME_PTR .FILL x3400
	CHAR_ARRAY .BLKW #100

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
		;backing up
		ST R0, BACKUP_R0_3200
		ST R1, BACKUP_R1_3200
		ST R2, BACKUP_R2_3200
		ST R3, BACKUP_R3_3200
		ST R4, BACKUP_R4_3200
		ST R6, BACKUP_R6_3200
		ST R7, BACKUP_R7_3200
		
		; Get negative NEWLINE to compare to newline inputted so can compare
		LD R2, NEWLINE_3200
		NOT R2, R2
		ADD R2, R2, #1
		AND R5, R5, x0 ; setting R5 to 0 
		
		CHAR_LOOP_3200
			GETC
			OUT
			
			STR R0, R1, #0
			
			ADD R0, R0, R2 ; checking if its newline
			BRz END_CHAR_LOOP_3200
			
			ADD R1, R1, #1 ; next slot for the next character
			ADD R5, R5, #1 ; increase count
			
			BR CHAR_LOOP_3200
		END_CHAR_LOOP_3200
		
		AND R0, R0, x0 ; make r0 be 0
		STR R0, R1, #0 ; store that 0 in that slot of r1

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
	
;=======================================================================
; Subroutine: SUB_IS_PALINDROME_3400
; Parameter: (R1) The starting address of a null-terminated string
; Parameter: (R5) The number of characters in the array
; Postcondition: The subroutine has determined whether the string at
;                (R1) is a palindrome or not, and returned a flag to
;                that effect.
; Return Value: (R4) 1 if the string is a palindrome, 0 otherwise
;=======================================================================
.ORIG x3400

	;========================
	; Subroutine Instructions
	;========================

	SUB_IS_PALINDROME_3400

		ST R0, BACKUP_R0_3400
		ST R1, BACKUP_R1_3400
		ST R2, BACKUP_R2_3400
		ST R3, BACKUP_R3_3400
		ST R4, BACKUP_R4_3400
		ST R5, BACKUP_R5_3400
		ST R6, BACKUP_R6_3400
		ST R7, BACKUP_R7_3400
		
		ADD R2, R1, R5	
		ADD R2, R2, #-1					; R2 <- Pointer to the last element
		
		WHILE_3400
			CHECK_IF_MIDDLE ; if one character or the middle character
				ADD R4, R2, #0
				NOT R4, R4
				ADD R4, R4, #1
				ADD R4, R1, R4
				BRzp TRUE_CONDITION_3400 ; if R4 is >= 0, go to true condition
				
			LDR R0, R1, #0
			LDR R3, R2, #0
			NOT R3, R3
			ADD R3, R3, #1
			ADD R0, R0, R3 ; checking ifcharachters are equal
			BRnp FALSE_CONDITION_3400

			ADD R1, R1, #1
			ADD R2, R2, #-1 ; count goes down
			BR WHILE_3400
		END_WHILE_3400
		
		FALSE_CONDITION_3400
			AND R4, R4, x0 ;set r4 to 0
			BR END_CONDITIONS_3400
		TRUE_CONDITION_3400
			AND R4, R4, x0
			ADD R4, R4, #1 ; setting R4 to 1 ccuz it's true
		END_CONDITIONS_3400

		LD R0, BACKUP_R0_3400
		LD R1, BACKUP_R1_3400
		LD R2, BACKUP_R2_3400
		LD R3, BACKUP_R3_3400
		LD R5, BACKUP_R5_3400
		LD R6, BACKUP_R6_3400
		LD R7, BACKUP_R7_3400
		RET

	;========================
	; Subroutine Data
	;========================

	BACKUP_R0_3400 .BLKW #1
	BACKUP_R1_3400 .BLKW #1
	BACKUP_R2_3400 .BLKW #1
	BACKUP_R3_3400 .BLKW #1
	BACKUP_R4_3400 .BLKW #1
	BACKUP_R5_3400 .BLKW #1
	BACKUP_R6_3400 .BLKW #1
	BACKUP_R7_3400 .BLKW #1 

.END
