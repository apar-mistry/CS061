;=================================================
; Name: Apar 
; Email: 
; 
; Lab: lab 4, ex 4
; Lab section: 
; TA: 
; 
;=================================================
.orig x3000
;==============
;Instructions
;==============
	LD R1, MEMORY_ARRAY
	LD R3, DEC_1
	STR R3, R1, #0


	LD R4, DEC_9
	FOR_LOOP
		ADD R4, R4, #0

		ADD R3, R3, R3
		ADD R1, R1, #1
		STR R3, R1, #0


		ADD R4, R4, #-1

		BRzp FOR_LOOP
		END_FOR_LOOP

	LD R6, DEC_1
	LD R5, DEC_1
	LD R2, DEC_15
	LD R3, DEC_9
	LD R4, COUNTER_3
	LD R1, DEC_1
FOR_LOOP3
	IF_STATEMENT5
	ADD R5, R5, #0
	BRnzp FOR_LOOP2
	FOR_LOOP2
		IF_STATEMENT
			ADD R6, R6, #0
			BRn PRINT_ONE
			BRzp PRINT_ZERO
		PRINT_ONE
		LEA R0, BIT_ONE
		TRAP x22
		ADD R6, R6, #0
		BRn CONTINUE_CODE


	PRINT_ZERO
	LEA R0, BIT_ZERO
	TRAP x22

	CONTINUE_CODE
	ADD R2, R2, #-1
	ADD R4, R4, #-1
	IF_STATEMENT2
		ADD R4, R4, #0
		BRn APPLY_SPACE
		BRzp DO_NOT_APPLY_SPACE

	APPLY_SPACE
		ADD R2, R2, #0
		BRn DO_NOT_APPLY_SPACE

		LEA R0, NEW_SPACE
		TRAP x22
		LD R4, COUNTER_3
		END_IF_STATEMENT1

	DO_NOT_APPLY_SPACE
		END_IF_STATEMENT2

	ADD R6, R6, R6
	ADD R2, R2, #0
	BRzp FOR_LOOP2
	END_FOR_LOOP2
	
	LEA R0, NEW_LINE
	TRAP x22
	LD R2, DEC_15
	ADD R1, R1, R1
	ADD R6, R1, R6
	LD R4, COUNTER_3
	ADD R5, R5, R5
	ADD R3, R3, #-1
	BRzp FOR_LOOP3
	END_FOR_LOOP3


HALT

;======
;Data
;======
DEC_1			.FILL		#1
MEMORY_ARRAY	.FILL		x4000
DEC_15			.FILL		#15
COUNTER_3		.FILL		#3
BIT_ZERO		.STRINGZ	"0"
BIT_ONE			.STRINGZ	"1"
NEW_SPACE		.STRINGZ	" "
NEW_LINE		.STRINGZ	"\n"
DEC_9			.FILL		#9

;============
;Remote Data
;============
.orig x4000
.BLKW #10
.end
