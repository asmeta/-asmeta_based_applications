// ABZ 2023 - fMVC
// - make use of undef instead of NONE for actions (new version after ABZ)
//   at every time one action is def the others are all undef 
// - use of selectedAirplane
// - search returns -2147483647 if plane is not found (to check if it is in the domain?) (instead of undef)
//    why -2147483647? because it is the constant used by AsmetaSMV for undef
//
asm aman0_noUndef

import StandardLibrary
import CTLLibrary
import LTLLibrary
export *

signature:
	// DOMAINS
	domain TimeSlot subsetof Integer
	domain ZoomValue subsetof Integer
	abstract domain Airplane
	enum domain Status = {UNSTABLE, STABLE, FREEZE}
	enum domain Color = {YELLOW, CYAN, WHITE}
	enum domain PTCOAction = {UP, DOWN, HOLD}
	
	// FUNCTIONS
	// Landing sequence: it should be bijective partially defined
	controlled landingSequence: TimeSlot -> Airplane
	
	// The status shown on the interface
	controlled statusOutput: Airplane -> Status  
	
	// Interaction with the GUI
	monitored zoom: ZoomValue	
	monitored action: PTCOAction
	monitored timeToLock: TimeSlot

	monitored selectedAirplane : Airplane

	
	controlled blocked: TimeSlot -> Boolean	
	controlled zoomValue : ZoomValue
	controlled landingSequenceColor: TimeSlot -> Color
	
	// search the position of an airplane
	// (to call with timeslot = 0 
	static search: Prod(Airplane,TimeSlot) -> TimeSlot
	// Function checking whether an airplane can be moved in the new position
	static canBeMovedUp: Airplane -> Boolean
	static canBeMovedDown: Airplane -> Boolean
	
	static fr1988: Airplane
	static u21748: Airplane
	static fr1989: Airplane
	static u21749: Airplane
	 
definitions:
	
	// DOMAIN DEFINITIONS
	domain TimeSlot = {0 : 10}
	domain ZoomValue = {15 : 45}
	
	
	
	// FUNCTION DEFINITIONS
	// The function searches the airplane with the specified landing time
	// return -1 if $a is not found in the landing sequence
	// to be used only with $t = 0
	function search($a in Airplane, $t in TimeSlot) = 
		if landingSequence($t) = $a then $t else 
		if $t > 10 then -2147483647 else 
		if $t < 10 then search($a, $t+1) 
		else -2147483647 endif endif endif
// alternatively without the recursion:
//		if landingSequence(0) = $a then 0 else 
//		if landingSequence(1) = $a then 1 else 
//		if landingSequence(2) = $a then 2 else 
//		if landingSequence(3) = $a then 3 else 
//		if landingSequence(4) = $a then 4 else 
//		if landingSequence(5) = $a then 5 else 
//		if landingSequence(6) = $a then 6 else 
//		if landingSequence(7) = $a then 7 else 
//		if landingSequence(8) = $a then 8 else 
//		if landingSequence(9) = $a then 9 else 
//		if landingSequence(10) = $a then 10 else 
//		if landingSequence(11) = $a then 11 else 
//		if landingSequence(12) = $a then 12 else 
//		if landingSequence(13) = $a then 13 else 
//		if landingSequence(14) = $a then 14 else 
//		if landingSequence(15) = $a then 15 else 
//		-2147483647 
//		endif endif endif endif endif endif endif endif endif endif endif endif endif endif endif endif
	
	function canBeMovedUp($airplane in Airplane) =
		let ($currentLT = search($airplane, 0)) in
		    // plane found ?
			if $currentLT = -2147483647 then false else
			    // check the slots up
				if ($currentLT + 1) <= 10 then 
					if not isUndef(landingSequence($currentLT + 1)) then false
				else if ($currentLT + 2) <= 10 then 
					if not isUndef(landingSequence($currentLT + 2)) then false
				else if ($currentLT + 3) <= 10 then 
					if not isUndef(landingSequence($currentLT + 3)) then false
				else if ($currentLT + 4) <= 10 then 
					if not isUndef(landingSequence($currentLT + 4)) then false 
				else true 
			endif endif endif endif endif endif endif endif endif
			endlet 
		
	function canBeMovedDown($airplane in Airplane) =
		let ($currentLT = search($airplane, 0)) in
			if $currentLT = -2147483647 then false else
				if ($currentLT - 1) >= 0 then 
					if not isUndef(landingSequence($currentLT - 1)) then false
				else if ($currentLT - 2) >= 0 then 
					if not isUndef(landingSequence($currentLT - 2)) then false
				else if ($currentLT - 3) >= 0 then 
					if not isUndef(landingSequence($currentLT - 3)) then false
				else if ($currentLT - 4) >= 0 then 
					if not isUndef(landingSequence($currentLT - 4)) then false 
				else true 
			endif endif endif endif endif endif endif endif endif
		endlet

	// RULE DEFINITIONS
	// the PLAN ATCo decides to move up an airplane
	rule r_moveUp($a in Airplane, $manual in Boolean) =
		let ($currentLT = search($a, 0)) in
		if $currentLT != -2147483647 and $currentLT < 10 then
			let ($blk = blocked($currentLT + 1)) in
				if $currentLT < zoomValue and not $blk and canBeMovedUp($a) then 
				par  
					landingSequence($currentLT + 1):= $a
					landingSequence($currentLT):= undef
					landingSequenceColor($currentLT + 1) := landingSequenceColor($currentLT)
					landingSequenceColor($currentLT) := WHITE
				endpar 
				endif 
			endlet
		endif endlet 
			
	// the PLAN ATCo decides to move down an airplane
	rule r_moveDown($a in Airplane, $manual in Boolean) =
		let ($currentLT = search($a, 0)) in
		let ($blk = blocked($currentLT - 1)) in
		if $currentLT != -2147483647 then
			// The function is called by AMAN -> It is ok to execute without checking anything
			if ($currentLT <= 0 and not $manual) then
				par
					landingSequence($currentLT):= undef
					landingSequenceColor($currentLT) := WHITE
				endpar
			else
				if  $currentLT >= 1 and not $blk and not $manual then
				par
					landingSequence($currentLT - 1):= $a
					landingSequence($currentLT):= undef
					landingSequenceColor($currentLT - 1) := landingSequenceColor($currentLT)
					landingSequenceColor($currentLT) := WHITE
				endpar				
				else if $currentLT >= 1 and not $blk and canBeMovedDown($a) then 
				par  
					landingSequence($currentLT - 1):= $a
					landingSequence($currentLT):= undef
					landingSequenceColor($currentLT - 1) := landingSequenceColor($currentLT)
					landingSequenceColor($currentLT) := WHITE
				endpar endif endif endif endif endlet endlet
						
	// the PLAN ATCo decides to put an airplane on hold -> The airplane has to be removed 
	// from the landing sequence and the color of the corresponding cell is set to white
	rule r_hold($a in Airplane) = 
		let ($currentLT = search($a, 0)) in
		if $currentLT != -2147483647 then
			par
				landingSequence($currentLT) := undef
				landingSequenceColor($currentLT) := WHITE
			endpar
			endif endlet
		
	// Update the zoom value shown on the GUI
	rule r_update_zoom = 
		if zoom < 15 then zoomValue := 15
		else if zoom > 45 then zoomValue := 45
		else if mod(zoom, 5) = 0 then 
		zoomValue := zoom endif endif endif
		
	// Update the locks depending on user input
	rule r_update_lock =
		if isUndef(landingSequence(timeToLock)) then blocked(timeToLock) := not (blocked(timeToLock)) endif
			     
	// INVARIANTS AND PROPERTIES
	// REQ16: The zoom value cannot be bigger than 45 and smaller than 15
	// proved with 10
//	LTLSPEC g(zoomValue >= 15 and zoomValue<=45)
	// REQ19: The value displayed next to the zoom slider must belong to the list of seven acceptable values for the zoom 
// proved (10)
	// LTLSPEC g(zoomValue = 15 or zoomValue = 20 or zoomValue = 25 or zoomValue = 30 or zoomValue = 35 or zoomValue = 40 or zoomValue = 45)  
	// REQ5: Aircraft labels should not overlap
	// proved
	//LTLSPEC (forall $t1 in Airplane, $t2 in Airplane with g(($t1 != $t2 and search($t1, 0) != -1 and search($t2, 0) != -1 and not isUndef(search($t1, 0)) and not isUndef(search($t2, 0))) implies ((search($t1, 0)-search($t2, 0)>=3) or (search($t1, 0)-search($t2, 0)<=-3))))
	// REQ6: An aircraft label cannot be moved into a blocked time period;
	LTLSPEC (forall $a in Airplane, $t in TimeSlot with g(search($a, 0) = $t implies not blocked($t)))
	// REQ15: The HOLD button must be available only when one aircraft label is selected
//	LTLSPEC (forall $a in Airplane, $t in TimeSlot with g(search($a, 0) = $t and isUndef(selectedAirplane) and action = HOLD implies x(search($a, 0) = $t)))
	// REQ3: Planes can be moved earlier or later on the timeline
//	LTLSPEC (forall $a in Airplane, $t in TimeSlot with g(search($a, 0) = $t and selectedAirplane=$a and action = UP and canBeMovedUp($a) implies x(search($a, 0) = $t + 1)))
//	LTLSPEC (forall $a in Airplane, $t in TimeSlot with g(search($a, 0) = $t and selectedAirplane=$a and action = DOWN and canBeMovedDown($a) implies x(search($a, 0) = ($t - 1))))
	// REQ4: Planes can be put on hold by the PLAN ATCo
//	LTLSPEC (forall $a in Airplane, $t in TimeSlot with g(search($a, 0) = $t and selectedAirplane=$a and action = HOLD implies x(isUndef(landingSequence($t)))))	

    // ADD Invariant about the actions

	// MAIN RULE
	main rule r_Main =
		par		
			// Update GUI
			if not isUndef(timeToLock) then r_update_lock[] endif
			if not isUndef(zoom) then r_update_zoom[] endif
			if not isUndef(action) and not isUndef(selectedAirplane) then
			// Move selected airplanes
				
				// The following 3 commented lines substitute those in the par block, but cannot be used 
				// with the model checker
				
				/*if action = UP then r_moveUp[selectedAirplane, true] else
				if action = DOWN then r_moveDown[selectedAirplane, true] else
				if action = HOLD then r_hold[selectedAirplane] endif endif endif */
				
				par if selectedAirplane = fr1988 then
					if action = UP then r_moveUp[fr1988, true] else
					if action = DOWN then r_moveDown[fr1988, true] else
					if action = HOLD then r_hold[fr1988] endif endif endif 
				endif
				if selectedAirplane = u21748 then
					if action = UP then r_moveUp[u21748, true] else
					if action = DOWN then r_moveDown[u21748, true] else
					if action = HOLD then r_hold[u21748] endif endif endif 
				endif
				if selectedAirplane = fr1989 then
					if action = UP then r_moveUp[fr1989, true] else
					if action = DOWN then r_moveDown[fr1989, true] else
					if action = HOLD then r_hold[fr1989] endif endif endif 
				endif
				if selectedAirplane = u21749 then
					if action = UP then r_moveUp[u21749, true] else
					if action = DOWN then r_moveDown[u21749, true] else
					if action = HOLD then r_hold[u21749] endif endif endif 
				endif endpar
			endif
		endpar

// INITIAL STATE
default init s0:
	function landingSequence($t in TimeSlot) = if $t = 5 then fr1988 else 
										   	   if $t = 2 then u21748 else 
										   	   undef endif endif
	function zoomValue = 30
	function selectedAirplane = undef
	function statusOutput($t in Airplane) = if $t = fr1988 then UNSTABLE else if $t = u21748 then FREEZE else STABLE endif endif	
	function landingSequenceColor($t in TimeSlot) = if $t = 5 then YELLOW else
												if $t = 2 then CYAN else
												WHITE
												endif endif
	function blocked($t in TimeSlot) = if $t = 6 then true else false endif
	