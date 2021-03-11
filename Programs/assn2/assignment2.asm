;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Apar Mistry
; Email: amist007@ucr.edu
; 
; Assignment name: Assignment 2
; Lab section: 023
; TA: Shirin
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
; Referenced LC-3 BASIC I/O and basic_if_else.png provided by instruction team
;=========================================================================

.ORIG x3000 ; Program begins here
;-------------
;Instructions
;-------------

;----------------------------------------------
;output prompt
;---------------------------------------------- 
LEA R0, intro ; get starting address of prompt string
PUTS     ; Invokes BIOS routine to output string

;-------------------------------
;INSERT YOUR CODE here
;--------------------------------
;Step 1. Take first number in and echo characters to console
GETC ;aka Trap x20
OUT ;echos as they are received aka trap x21
ADD R1, R0, #0 ; stores character that's at R0 into it's own register aka R1 
LD R0, newline ; gets address of R0 and makes R0 be newline
OUT ; prints out the newline that's at R0

;Step 2. Take second number in and echo characters to console. Essentially same as Step 1, but for 
GETC ;aka Trap x20
OUT ;echos as they are received aka trap x21
ADD R2, R0, #0 ; stores character that's at R0 into it's own register aka R2 
LD R0, newline ; gets address of R0 and makes R0 be newline
OUT ; prints out the newline that's now at R0

;Step 3 - Output console the operation being preformed <first number> - <second number> = <difference>
ADD R0, R1, #0 ; getting value of first num to be printed
OUT ; prints first

LEA R0, subsign ; R0 now has the subsign string
PUTS ; prints entire string

ADD R0, R2, #0 ; now second val 
OUT

LEA R0, equalSign; equal sign
PUTS ; prints entire sign

;Step 4 prep numbers for subtraction
LD R7, ascOffset
NOT R7, R7 ;negates
ADD R7, R7, #1 ; add 1 to get 2's comp

ADD R1, R1, R7 ;gets first val into the right value
ADD R2, R2, R7; gets second val into the right value

NOT R3, R2; negating value and storing into R3
ADD R3, R3, #1 ; completing 2's comp by adding 1
;Doing the operation now
ADD R5, R1, R3; does the operation of subtraction and stores in R5
IF_STATEMENT ; sees if val is pos or not
BRp pos
neg
NOT R5, R5 ; negate the value back 
ADD R5, R5, #1 ; reversing 2's comp
LD R6, ascOffset
ADD R5, R5, R6 ;gives correct ascii val
LEA R0,negSign
PUTS
ADD R0, R5, #0 ; copy value from R5 to R0
OUT
BRp END_IF
pos
LD R6, ascOffset
ADD R5, R5, R6
ADD R0, R5, #0
OUT
LEA R0, newline
   PUTS
END_IF

HALT ; Stop execution of program
;------ 
;Data
;------
; String to prompt user. Note: already includes terminating newline!
intro .STRINGZ "ENTER two numbers (i.e '0'....'9')\n" ; prompt string - use with LEA, followed by PUTS.
newline .FILL '\n' ; newline character - use with LD followed by OUT
subsign .STRINGZ " - " ; for subtraction sign
equalSign .STRINGZ " = " ; equal sign 
negSign .STRINGZ "-" ; negative sign
ascOffset .FILL x30 ; 
;--------------- 
;END of PROGRAM
;--------------- 
.END
