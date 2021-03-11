;=================================================
; Name: Apar Mistry
; Email: amist007@ucr.edu
; 
; Lab: lab 8, ex 1 & 2
; Lab section: 023
; TA: Shirin
; 
;=================================================

; test harness
.ORIG x3000
				 
	; Instructions
	LD R6, SUB_PRINT_OPCODE_TABLE_PTR
	JSRR R6 ; first task aka ex 1
	
	LD R0, NEWLINE
	OUT ; separate both examples
	
	LD R6, SUB_FIND_OPCODE_PTR
	JSRR R6 ; example two
	
	HALT
;-----------------------------------------------------------------------------------------------
; test harness local data:

SUB_PRINT_OPCODE_TABLE_PTR .FILL x3200
SUB_FIND_OPCODE_PTR .FILL x3600
NEWLINE .FILL '\n'

;===============================================================================================


; subroutines:
;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_PRINT_OPCODE_TABLE
; Parameters: None
; Postcondition: The subroutine has printed out a list of every LC3 instruction
;				 and corresponding opcode in the following format:
;					ADD = 0001
;					AND = 0101
;					BR = 0000
;					…
; Return Value: None
;-----------------------------------------------------------------------------------------------
.ORIG x3200
				 
	SUB_PRINT_OPCODE_TABLE_3200
		; backup the registers
		ST R0, BACKUP_R0_3200
		ST R1, BACKUP_R1_3200
		ST R2, BACKUP_R2_3200
		ST R3, BACKUP_R3_3200
		ST R4, BACKUP_R4_3200
		ST R5, BACKUP_R5_3200
		ST R6, BACKUP_R6_3200
		ST R7, BACKUP_R7_3200
		
		LD R1, opcodes_po_ptr ; R1 has the pointer to the array of opcodes
		LD R3, instructions_po_ptr ; R3 has the pointer to array of instructions
		
		TABLE_PRINT_LOOP_3200
		
			PRINT_INST_LOOP_3200 
				LDR R0, R3, #0 ; LDR whatever is at R3 to R0
				ADD R0, R0, #0 ; Add R0 to itself to make it the last register
				BRz END_PRINT_INST_LOOP_3200 ; if it's 0 end loop
				
				OUT ; print instruction
				
				ADD R3, R3, #1 ; incrememnt to next element
				BR PRINT_INST_LOOP_3200 ; do it again
			END_PRINT_INST_LOOP_3200
			ADD R3, R3, #1 ; increment R3 to next element
			
			LEA R0, EQUALS_STATEMENT_3200 ; load equal sign into R0
			PUTS ; print it
			
			LDR R2, R1, #0 ; LDR what's at R1 aka pointer to opcode to R2
			LD R6, SUB_PRINT_OPCODE_PTR_3200 ; load subroutine to print opcodes
			JSRR R6 ; invoke subroutine
			
			LD R0, NEWLINE_3200 ; print newline
			OUT
		
			ADD R1, R1, #1 ;increment what's at R1
			LDR R2, R1, #0
			ADD R2, R2, #0
			BRzp TABLE_PRINT_LOOP_3200

		LD R0, BACKUP_R0_3200
		LD R1, BACKUP_R1_3200
		LD R2, BACKUP_R2_3200
		LD R3, BACKUP_R3_3200
		LD R4, BACKUP_R4_3200
		LD R5, BACKUP_R5_3200
		LD R6, BACKUP_R6_3200
		LD R7, BACKUP_R7_3200
		RET
		
;-----------------------------------------------------------------------------------------------
; SUB_PRINT_OPCODE_TABLE local data
opcodes_po_ptr		.fill x4000				; local pointer to remote table of opcodes
instructions_po_ptr	.fill x4100				; local pointer to remote table of instructions
BACKUP_R0_3200 .BLKW #1
BACKUP_R1_3200 .BLKW #1
BACKUP_R2_3200 .BLKW #1
BACKUP_R3_3200 .BLKW #1
BACKUP_R4_3200 .BLKW #1
BACKUP_R5_3200 .BLKW #1
BACKUP_R6_3200 .BLKW #1
BACKUP_R7_3200 .BLKW #1
SUB_PRINT_OPCODE_PTR_3200 .FILL x3400
EQUALS_STATEMENT_3200 .STRINGZ " = "
NEWLINE_3200 .FILL '\n'

;===============================================================================================


;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_PRINT_OPCODE
; Parameters: R2 containing a 4-bit op-code in the 4 LSBs of the register
; Postcondition: The subroutine has printed out just the 4 bits as 4 ascii 1s and 0s
;				 The output is NOT newline terminated.
; Return Value: None
;-----------------------------------------------------------------------------------------------
.ORIG x3400

	SUB_PRINT_OPCODE_3400
		
		ST R0, BACKUP_R0_3400
		ST R1, BACKUP_R1_3400
		ST R2, BACKUP_R2_3400
		ST R3, BACKUP_R3_3400
		ST R4, BACKUP_R4_3400
		ST R5, BACKUP_R5_3400
		ST R6, BACKUP_R6_3400
		ST R7, BACKUP_R7_3400
		
		LD R4, DEC_3_3400 ; fill R4 register with #3
		BIT_LOOP_3400
			LD R3, DEC_4_3400 ; fill R3 with #4
			INNER_BIT_LOOP_3400
				LD R0, HEX_30_3400 ; fill R0 with hex 30 aka 0 in ascii
				LD R5, LEADING_1_3400 ; fill r5 with leading 1
				
				; Skipping first three sections (addon lab8)
				ADD R4, R4, #0 ; if r4 is pos,  end priint
				BRp END_PRINT_3400
				
				AND R5, R5, R2 ; if R5 is the same as R2
				BRn PRINT_1_3400 ; if not print one
				
				PRINT_0_3400
					OUT ; print 0 char 
					BR END_PRINT_3400 ; go to endprint 
				PRINT_1_3400
					ADD R0, R0, #1 ; add x30 + 1 so it prints 1 aka x31
					OUT
				END_PRINT_3400
				
				ADD R2, R2, R2 ;bit shift
				ADD R3, R3, #-1 ; increment down by 1
				BRp INNER_BIT_LOOP_3400 ; if it's still positive aka all 4 bits were printedN
			END_INNER_BIT_LOOP_3400

			ADD R4, R4, #-1 ; decrementing down
			BRn END_SEGMENTS_3400 ; if its <0 then end
			BR BIT_LOOP_3400 ; otherwise loop again
		END_SEGMENTS_3400

		LD R0, BACKUP_R0_3400
		LD R1, BACKUP_R1_3400
		LD R2, BACKUP_R2_3400
		LD R3, BACKUP_R3_3400
		LD R4, BACKUP_R4_3400
		LD R5, BACKUP_R5_3400
		LD R6, BACKUP_R6_3400
		LD R7, BACKUP_R7_3400
		RET

;-----------------------------------------------------------------------------------------------
; SUB_PRINT_OPCODE local data

BACKUP_R0_3400 .BLKW #1
BACKUP_R1_3400 .BLKW #1
BACKUP_R2_3400 .BLKW #1
BACKUP_R3_3400 .BLKW #1
BACKUP_R4_3400 .BLKW #1
BACKUP_R5_3400 .BLKW #1
BACKUP_R6_3400 .BLKW #1
BACKUP_R7_3400 .BLKW #1
DEC_3_3400 .FILL #3
DEC_4_3400 .FILL #4
SPACE_3400 .FILL ' '
TEMP_CHAR_3400 .FILL 'a'
HEX_30_3400 .FILL x30
LEADING_1_3400 .FILL x8000 

;===============================================================================================


;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_FIND_OPCODE
; Parameters: None
; Postcondition: The subroutine has invoked the SUB_GET_STRING subroutine and stored a string
; 				as local data; it has searched the AL instruction list for that string, and reported
;				either the instruction/opcode pair, OR "Invalid instruction"
; Return Value: None
;-----------------------------------------------------------------------------------------------
.ORIG x3600

	SUB_FIND_OPCODE_3600

		ST R0, BACKUP_R0_3600
		ST R1, BACKUP_R1_3600
		ST R2, BACKUP_R2_3600
		ST R3, BACKUP_R3_3600
		ST R4, BACKUP_R4_3600
		ST R5, BACKUP_R5_3600
		ST R6, BACKUP_R6_3600
		ST R7, BACKUP_R7_3600
		
		INF_LOOP_3600
		
			LEA R2, STR_STORE_ARR_3600
			LD R6, SUB_GET_STRING_PTR_3600
			JSRR R6
			
			LD R1, opcodes_fo_ptr ; load r1 witharray f opcodes
			LD R3, instructions_fo_ptr ; load r3 with instruction pointers
			
			SEARCH_LOOP_3600
				LEA R2, STR_STORE_ARR_3600 ; load array with the stored string
				
				BR COMPARE_STRING_3600 ; jump to that 
				
				MISMATCH_CASE_3600
					LDR R4, R3, #0
					ADD R4, R4, #0
					BRz END_COMPARE_STRING_3600
					ADD R3, R3, #1
					BR MISMATCH_CASE_3600
			
				COMPARE_STRING_3600
					LDR R5, R3, #0 ; load whats at r3 to r5
 					LDR R4, R2, #0 ; load what's at r2 to r5
					ADD R4, R4, #0 ; add r4 with nothing to make it last register
					BRnp END_CHECK_INST_PTR_3600 ; if it's not 0
					
					ADD R5, R5, #0 ; make r5 last register
					BRz MATCH_CASE_3600 ; if it's 0
					BR MISMATCH_CASE_3600 ; jump to mismatch case
					END_CHECK_INST_PTR_3600
					
					NOT R4, R4 
					ADD R4, R4, #1
					ADD R5, R5, R4
					BRnp MISMATCH_CASE_3600
					
					ADD R2, R2, #1
					ADD R3, R3, #1
					BR COMPARE_STRING_3600
				END_COMPARE_STRING_3600
				
				ADD R3, R3, #1
				ADD R1, R1, #1
				LDR R0, R1, #0
				ADD R0, R0, #0
				BRzp SEARCH_LOOP_3600
			END_SEARCH_LOOP_3600
			
			LEA R0, INVALID_INSTRUCTION_ERR_3600
			PUTS
			BR END_MATCH_CASE_3600
			
			MATCH_CASE_3600
				LEA R0, STR_STORE_ARR_3600
				PUTS
				LEA R0, EQUALS_STATEMENT_3600
				PUTS
				LDR R2, R1, #0
				LD R6, SUB_PRINT_OPCODE_PTR_3600
				JSRR R6
				LD R0, NEWLINE_3600
				OUT
			END_MATCH_CASE_3600
		
		BR INF_LOOP_3600

		LD R0, BACKUP_R0_3600
		LD R1, BACKUP_R1_3600
		LD R2, BACKUP_R2_3600
		LD R3, BACKUP_R3_3600
		LD R4, BACKUP_R4_3600
		LD R5, BACKUP_R5_3600
		LD R6, BACKUP_R6_3600
		LD R7, BACKUP_R7_3600
		RET

;-----------------------------------------------------------------------------------------------
; SUB_FIND_OPCODE local data
BACKUP_R0_3600 .BLKW #1
BACKUP_R1_3600 .BLKW #1
BACKUP_R2_3600 .BLKW #1
BACKUP_R3_3600 .BLKW #1
BACKUP_R4_3600 .BLKW #1
BACKUP_R5_3600 .BLKW #1
BACKUP_R6_3600 .BLKW #1
BACKUP_R7_3600 .BLKW #1
opcodes_fo_ptr			.fill x4000
instructions_fo_ptr		.fill x4100
STR_STORE_ARR_3600 .BLKW #100
SUB_GET_STRING_PTR_3600 .FILL x3800
INVALID_INSTRUCTION_ERR_3600 .STRINGZ "Invalid instruction\n"
EQUALS_STATEMENT_3600 .STRINGZ " = "
SUB_PRINT_OPCODE_PTR_3600 .FILL x3400
NEWLINE_3600 .FILL '\n'

;===============================================================================================


;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_GET_STRING
; Parameters: R2 - the address to which the null-terminated string will be stored.
; Postcondition: The subroutine has prompted the user to enter a short string, terminated 
; 				by [ENTER]. That string has been stored as a null-terminated character array 
; 				at the address in R2
; Return Value: None (the address in R2 does not need to be preserved)
;-----------------------------------------------------------------------------------------------
.ORIG x3800

	SUB_GET_STRING_3800

		ST R0, BACKUP_R0_3800
		ST R1, BACKUP_R1_3800
		ST R2, BACKUP_R2_3800
		ST R3, BACKUP_R3_3800
		ST R4, BACKUP_R4_3800
		ST R5, BACKUP_R5_3800
		ST R6, BACKUP_R6_3800
		ST R7, BACKUP_R7_3800
		
		CHAR_LOOP_3800
			LD R3, NEWLINE_3800
			NOT R3, R3 ; set newline negative
			ADD R3, R3, #1
			
			GETC ; get input
			OUT
			
			ADD R3, R0, R3 ; if newline entered
			BRz END_CHAR_LOOP_3800
			
			STR R0, R2, #0 ; str what's at r2 to r0
			ADD R2, R2, #1 ; move to next value
			BR CHAR_LOOP_3800
		END_CHAR_LOOP_3800
		
		AND R0, R0, x0 ;clear r0
		STR R0, R2, #0 ; store what's at r2 at r0

		LD R0, BACKUP_R0_3800
		LD R1, BACKUP_R1_3800
		LD R2, BACKUP_R2_3800
		LD R3, BACKUP_R3_3800
		LD R4, BACKUP_R4_3800
		LD R5, BACKUP_R5_3800
		LD R6, BACKUP_R6_3800
		LD R7, BACKUP_R7_3800
		RET
		
;-----------------------------------------------------------------------------------------------
; SUB_GET_STRING local data
BACKUP_R0_3800 .BLKW #1
BACKUP_R1_3800 .BLKW #1
BACKUP_R2_3800 .BLKW #1
BACKUP_R3_3800 .BLKW #1
BACKUP_R4_3800 .BLKW #1
BACKUP_R5_3800 .BLKW #1
BACKUP_R6_3800 .BLKW #1
BACKUP_R7_3800 .BLKW #1 
NEWLINE_3800 .FILL '\n'

;===============================================================================================


;-----------------------------------------------------------------------------------------------
; REMOTE DATA
.ORIG x4000			; list opcodes as numbers from #0 through #15, e.g. .fill #12 or .fill xC
	; opcodes
	ADD_OPCODE .FILL x1
	AND_OPCODE .FILL x5
	BR_OPCODE .FILL x0
	JMP_OPCODE .FILL xC
	JSR_OPCODE .FILL x4
	JSRR_OPCODE .FILL x4
	LD_OPCODE .FILL x2
	LDI_OPCODE .FILL xA
	LDR_OPCODE .FILL x6
	LEA_OPCODE .FILL xE
	NOT_OPCODE .FILL x9
	RET_OPCODE .FILL xC
	RTI_OPCODE .FILL x8
	ST_OPCODE .FILL x3
	STI_OPCODE .FILL xB
	STR_OPCODE .FILL x7
	TRAP_OPCODE .FILL xF
	OPCODE_TERMINATE .FILL #-1

.ORIG x4100			; list AL instructions as null-terminated character strings, e.g. .stringz "JMP"
	; - be sure to follow same order in opcode & instruction arrays!
	; instructions
	ADD_INST .STRINGZ "ADD"
	AND_INST .STRINGZ "AND"
	BR_INST .STRINGZ "BR"
	JMP_INST .STRINGZ "JMP"
	JSR_INST .STRINGZ "JSR"
	JSRR_INST .STRINGZ "JSRR"
	LD_INST .STRINGZ "LD"
	LDI_INST .STRINGZ "LDI"
	LDR_INST .STRINGZ "LDR"
	LEA_INST .STRINGZ "LEA"
	NOT_INST .STRINGZ "NOT"
	RET_INST .STRINGZ "RET"
	RTI_INST .STRINGZ "RTI"
	ST_INST .STRINGZ "ST"
	STI_INST .STRINGZ "STI"
	STR_INST .STRINGZ "STR"
	TRAP_INST .STRINGZ "TRAP"

;===============================================================================================

.END
