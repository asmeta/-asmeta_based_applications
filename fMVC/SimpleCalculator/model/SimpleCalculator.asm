//
// a simple example with inc and dec action
//
asm SimpleCalculator

import StandardLibrary

signature:
	// DOMAINS
	enum domain MathAction = {INC, DEC}
	enum domain MemoryAction = {MPLUS, MRESET}
	// FUNCTIONS
	monitored number: Integer
	monitored math_action: MathAction
	monitored mem_action: MemoryAction
	controlled calc_result: Integer
	controlled mem: Integer

definitions:

	// INVARIANTS
	invariant inv_res over calc_result:  calc_result >= 0

	invariant inv_action over math_action, mem_action: (math_action != undef implies mem_action=undef) and (mem_action != undef implies math_action=undef) 


	// MAIN RULE
	main rule r_Main =
		par 
			if math_action = INC then calc_result := calc_result + number endif  
			if math_action = DEC then calc_result := calc_result - number endif
			if mem_action = MPLUS then mem := calc_result endif  
			if mem_action = MRESET then mem := undef endif
		endpar  

// INITIAL STATE
default init s0:
	function calc_result = 0
	function mem = undef
