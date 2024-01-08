//
// a simple example with inc and dec action
//
asm incdec

import StandardLibrary

signature:
	// DOMAINS
	enum domain Operation = {SUM, MULT}
	// FUNCTIONS
	monitored number: Integer
	monitored operation: Operation
	controlled calc_result: Integer

definitions:


	// INVARIANTS
	invariant inv_win over calc_result:  calc_result >= 0

	// MAIN RULE
	main rule r_Main =
		par 
		if operation = SUM then calc_result := calc_result + number endif  
		if operation = MULT then calc_result := calc_result * number endif
		endpar  

// INITIAL STATE
default init s0:
	function calc_result = 1
