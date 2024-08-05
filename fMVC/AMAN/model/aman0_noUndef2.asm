// ABZ 2023 - fMVC
// - make use of undef instead of NONE for actions (new version after ABZ)
//   at every time one action is def the others are all undef 
// - use of selectedAirplane
// - search returns -2147483647 if plane is not found (to check if it is in the domain?) (instead of undef)
//    why -2147483647? because it is the constant used by AsmetaSMV for undef
// 

// VERSION FOR MODEL CHECKING

asm aman0_noUndef2

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
	// position
	static position: Airplane -> TimeSlot
	// Function checking whether an airplane can be moved in the new position
	static canBeMovedUp: Airplane -> Boolean
	static canBeMovedDown: Airplane -> Boolean
	
	static fr1988: Airplane
	static u21748: Airplane
	static fr1989: Airplane
	static u21749: Airplane
	 
definitions:
	
	// DOMAIN DEFINITIONS
	domain TimeSlot = {0 : 15}
	domain ZoomValue = {15 : 45}
	
	
	
	// FUNCTION DEFINITIONS
	// The function searches the airplane with the specified landing time
	// return -1 if $a is not found in the landing sequence
	// to be used only with $t = 0
	function position($a in Airplane) = 
// alternatively without the recursion:
		if landingSequence(0) = $a then 0 else 
		if landingSequence(1) = $a then 1 else 
		if landingSequence(2) = $a then 2 else 
		if landingSequence(3) = $a then 3 else 
		if landingSequence(4) = $a then 4 else 
		if landingSequence(5) = $a then 5 else 
		if landingSequence(6) = $a then 6 else 
		if landingSequence(7) = $a then 7 else 
		if landingSequence(8) = $a then 8 else 
		if landingSequence(9) = $a then 9 else 
		if landingSequence(10) = $a then 10 else 
		if landingSequence(11) = $a then 11 else 
		if landingSequence(12) = $a then 12 else 
		if landingSequence(13) = $a then 13 else 
		if landingSequence(14) = $a then 14 else 
		if landingSequence(15) = $a then 15 else 
		-2147483647 
		endif endif endif endif endif endif 
		endif endif endif endif endif 
		endif endif endif 
		endif endif
	
	// moved up +1
	// call only when the airplane if found (check before)
	function canBeMovedUp($airplane in Airplane) =
		let ($currentLT = position($airplane)) in
			 // check the slots up
			if ($currentLT + 1) <= 15 then 
				let ($blk = blocked($currentLT + 1)) in
					if ($blk) then false 
					else
						if not isUndef(landingSequence($currentLT + 1)) then false
						else if ($currentLT + 2) <= 15 then 
							if not isUndef(landingSequence($currentLT + 2)) then false
								else if ($currentLT + 3) <= 15 then 
									if not isUndef(landingSequence($currentLT + 3)) then false
									else if ($currentLT + 4) <= 15 then 
										if not isUndef(landingSequence($currentLT + 4)) then false 
										else true 
										endif endif endif endif endif endif endif endif
				endlet 
			else
				false
			endif 
		endlet 
		
		
	function canBeMovedDown($airplane in Airplane) =
		let ($currentLT = position($airplane)) in
			if ($currentLT - 1) >= 0 then 
				let ($blk = blocked($currentLT - 1)) in
					if ($blk) then false 
					else				
						if not isUndef(landingSequence($currentLT - 1)) then false
						else if ($currentLT - 2) >= 0 then 
							if not isUndef(landingSequence($currentLT - 2)) then false
						else if ($currentLT - 3) >= 0 then 
							if not isUndef(landingSequence($currentLT - 3)) then false
						else if ($currentLT - 4) >= 0 then 
							if not isUndef(landingSequence($currentLT - 4)) then false 
						else true
						endif endif endif endif endif endif endif 
					endif
				endlet
			 else false endif
		endlet

	// RULE DEFINITIONS
	// the PLAN ATCo decides to move up an airplane
	// always manual move (in this level)
	//
	rule r_moveUp($a in Airplane) =
		let ($currentLT = position($a)) in
		if $currentLT != -2147483647 and $currentLT < 15 then
			if $currentLT < zoomValue and canBeMovedUp($a) then 
			par  
				landingSequence($currentLT + 1):= $a
				landingSequence($currentLT):= undef
				landingSequenceColor($currentLT + 1) := landingSequenceColor($currentLT)
				landingSequenceColor($currentLT) := WHITE
			endpar 
			endif 
		endif endlet 
			
	// the PLAN ATCo decides to move down an airplane
	// always manual change
	rule r_moveDown($a in Airplane) =
		let ($currentLT = position($a)) in
		// The function is called by AMAN -> It is ok to execute without checking anything
		if $currentLT != -2147483647 and $currentLT > 0 then
		   let ($blk = blocked($currentLT - 1)) in
				if not $blk and canBeMovedDown($a) then 
				par  
					landingSequence($currentLT - 1):= $a
					landingSequence($currentLT):= undef
					landingSequenceColor($currentLT - 1) := landingSequenceColor($currentLT)
					landingSequenceColor($currentLT) := WHITE
				endpar endif endlet endif endlet
						
	// the PLAN ATCo decides to put an airplane on hold -> The airplane has to be removed 
	// from the landing sequence and the color of the corresponding cell is set to white
	rule r_hold($a in Airplane) = 
		let ($currentLT = position($a)) in
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
    // INVARIANTS over the inputs, usd INVAR
    // ADD Invariant about the actions
	INVAR (not isUndef(timeToLock) implies isUndef(action)) 
                    and (not isUndef(action) implies isUndef(timeToLock)) 
			     
	// REQ16: The zoom value cannot be bigger than 45 and smaller than 15
	// proved with 
	LTLSPEC g(zoomValue >= 15 and zoomValue<=45)
	// REQ19: The value displayed next to the zoom slider must belong to the list of seven acceptable values for the zoom 
// proved (10)
	LTLSPEC g(zoomValue = 15 or zoomValue = 20 or zoomValue = 25 or zoomValue = 30 or zoomValue = 35 or zoomValue = 40 or zoomValue = 45)  
	// REQ5: Aircraft labels should not overlap
	// proved
	LTLSPEC (forall $t1 in Airplane, $t2 in Airplane with g(($t1 != $t2 and position($t1) != -2147483647 and position($t2) != -2147483647 and not isUndef(position($t1)) and not isUndef(position($t2))) implies ((position($t1)-position($t2)>=3) or (position($t1)-position($t2)<=-3))))
	// REQ6: An aircraft label cannot be moved into a blocked time period;
	LTLSPEC (forall $a in Airplane, $t in TimeSlot with g(position($a) = $t implies not blocked($t)))
	// REQ15: The HOLD button must be available only when one aircraft label is selected
	LTLSPEC (forall $a in Airplane, $t in TimeSlot with g(position($a) = $t and isUndef(selectedAirplane) and action = HOLD implies x(position($a) = $t)))
	// REQ3: Planes can be moved earlier or later on the timeline
	LTLSPEC (forall $a in Airplane, $t in TimeSlot with g(position($a) = $t and selectedAirplane=$a and action = UP and canBeMovedUp($a) implies x(position($a) = $t + 1)))
	LTLSPEC (forall $a in Airplane, $t in TimeSlot with g(position($a) = $t and selectedAirplane=$a and action = DOWN and canBeMovedDown($a) implies x(position($a) = ($t - 1))))
	// REQ4: Planes can be put on hold by the PLAN ATCo
	LTLSPEC (forall $a in Airplane, $t in TimeSlot with g(position($a) = $t and selectedAirplane=$a and action = HOLD implies x(isUndef(landingSequence($t)))))	

//	CTLSPEC (forall $a in Airplane with ag(position($a) = 0 implies not canBeMovedDown($a)))
//	CTLSPEC (forall $a in Airplane with ag(position($a) = 0 implies not canBeMovedUp($a)))

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
					if action = UP then r_moveUp[fr1988] else
					if action = DOWN then r_moveDown[fr1988] else
					if action = HOLD then r_hold[fr1988] endif endif endif 
				endif
				if selectedAirplane = u21748 then
					if action = UP then r_moveUp[u21748] else
					if action = DOWN then r_moveDown[u21748] else
					if action = HOLD then r_hold[u21748] endif endif endif 
				endif
				if selectedAirplane = fr1989 then
					if action = UP then r_moveUp[fr1989] else
					if action = DOWN then r_moveDown[fr1989] else
					if action = HOLD then r_hold[fr1989] endif endif endif 
				endif
				if selectedAirplane = u21749 then
					if action = UP then r_moveUp[u21749] else
					if action = DOWN then r_moveDown[u21749] else
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
	