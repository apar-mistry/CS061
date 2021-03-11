;=================================================
; Name: Apar Mistry
; Email: amist007@ucr.edu
; 
; Lab: lab 9, ex 1 & 2
; Lab section: 023
; TA: Shirin
; 
;=================================================

.orig x3000
;main routine
	AND	R0,R0,#0	;make val to push onto stack zero
	ADD	R0,R0,#1	;we want to push 1 onto the stack
	LD	R1,stack_addr	;load stack addr into R1
	LD	R2,top		;load top addr into R2
	LD	R3,capacity	;load capacity into R3
;PUSHING
	LD	R4,SUB_STACK_PUSH_ADDR	;load address of push subroutine
	JSRR 	R4
	LD	R2,top		;load old top pointer
	ADD	R2,R2,#1	;increment top pointer b/c we pushed
	ST	R2,top		;store new top pointer
	
	ADD	R0,R0,#1	

	JSRR	R4
        LD      R2,top          ;load old top pointer
        ADD     R2,R2,#1        ;increment top pointer b/c we pushed
        ST      R2,top          ;store new top pointe	

	ADD	R0,R0,#1

	JSRR	R4
	LD      R2,top          ;load old top pointer
        ADD     R2,R2,#1        ;increment top pointer b/c we pushed
        ST      R2,top          ;store new top pointe

	ADD	R0,R0,#1

	JSRR	R4
        LD      R2,top          ;load old top pointer
        ADD     R2,R2,#1        ;increment top pointer b/c we pushed
        ST      R2,top          ;store new top pointe

	LD	R5,SUB_STACK_POP_ADDR
	
	JSRR	R5
	
	LD	R2,top
	ADD	R2,R2,#-1
	ST	R2,top

	JSRR	R5
	
	LD	R2,top
	ADD	R2,R2,#-1
	ST	R2,top

	JSRR	R5
	
	LD	R2,top
	ADD	R2,R2,#-1
	ST	R2,top

	JSRR	R5

	HALT
;main data
	SUB_STACK_PUSH_ADDR	.FILL	x4000
	SUB_STACK_POP_ADDR	.FILL	x5000
	stack_addr	.FILL	x8000
	top	.FILL	x8001
	capacity	.FILL	#10
.orig x4000
;Subroutine: SUB_STACK_PUSH
; Parameter (R0): The value to push onto the stack
; Parameter (R1): stack_addr: A pointer to the beginning of the stack
; Parameter (R2): top: A pointer to the next place to PUSH an item
; Parameter (R3): capacity: The number of additional items the stack can hold
; Postcondition: The subroutine has pushed (R0) onto the stack. If an overflow
; occurred, the subroutine has printed an overflow error message
; and terminated.
; Return Value: R2 ← updated top value
; R3 ← updated capacity value

	ST	R7,SUB_STACK_PUSH_R7
	
	ADD	R3,R3,#0		;make R3=capacity last used reg
	BRnz	OVERFLOW
	ADD	R3,R3,#-1		;decrease capacity
	STR	R0,R2,#0	;store R0, value to push at top of stack
	LDR	R2,R2,#0	;load the value at the top of stack into R2
	BRnzp	END_PUSH	;go to end
OVERFLOW
	LEA	R0,OVERFLOW_ERROR
	PUTS
END_PUSH
	LD	R7,SUB_STACK_PUSH_R7
	RET
;subroutine data
	SUB_STACK_PUSH_R7	.FILL	x0
	OVERFLOW_ERROR		.STRINGZ	"ERROR:OVERFLOW\n"

.orig x5000
;Subroutine: SUB_STACK_POP
; Parameter (R1): stack_addr: A pointer to the beginning of the stack
; Parameter (R2): top: A pointer to the item to POP
; Parameter (R3): capacity: The # of additional items the stack can hold
; Postcondition: The subroutine has popped MEM[top] off of the stack.
; If an underflow occurred, the subroutine has printed an
; underflow error message and terminated.
; Return Value: R0 ← value popped off of the stack
; R2 ← updated top value
; R3 ← updated capacity value
	
	ST	R7,SUB_STACK_POP_R7

	NOT	R4,R2			;flip bits of top address
	ADD	R4,R4,#1		;add 1 to get 2's comp of top addr
	ADD	R4,R4,R1		;do R4 <-- stack addr - top addr 
	ADD	R4,R4,#-1		;if stack empty, then stackddr-topddr = 1; set to 0
	BRz	UNDERFLOW		;if =0, then topaddr=stackaddr
	ADD	R3,R3,#1		;increase capacity by 1
	ADD	R2,R2,#-2		;decrement top pointer by 2 (NOT 1)
	LDR	R2,R2,#0		;load updated top value into R2
	BRnzp	END_POP		
UNDERFLOW
	LD	R0,UNDERFLOW_ERROR
	PUTS
END_POP
	LD	R7,SUB_STACK_POP_R7
	RET	

;subroutine data
	SUB_STACK_POP_R7	.FILL	x0
	UNDERFLOW_ERROR	.STRINGZ	"ERROR:UNDERFLOW\n"


.orig x8000
	THE_STACK	.BLKW	#10

.end
