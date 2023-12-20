// translation of the asm (for avalla) file:///D:/AgHome/progettidaSVNGIT/asmeta/asmeta_based_applications/fMVC/AMAN/model/aman2.asm
asm __tempAsmetaV7859023612479832841
import D:\\AgHome\\progettidaSVNGIT\\asmeta\\asmeta_based_applications\\fMVC\\AMAN\\model\\StandardLibrary
import D:\\AgHome\\progettidaSVNGIT\\asmeta\\asmeta_based_applications\\fMVC\\AMAN\\model\\CTLlibrary
import D:\\AgHome\\progettidaSVNGIT\\asmeta\\asmeta_based_applications\\fMVC\\AMAN\\model\\TimeLibrary
import _aman1_wom_10790079396382685890

signature:
    domain Minutes subsetof Integer
    domain Hours subsetof Integer

    // added by validator
    controlled step__: Integer
    derived currentTimeMins: Integer
    derived currentTimeHours: Integer
    controlled timeShown: TimeSlot -> Minutes
    controlled lastTimeUpdated: Minutes
    controlled mins: Minutes
    controlled hours: Hours

definitions:

    domain Hours = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23}
    domain Minutes = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59}

    function currentTimeMins = mod(rtoi(div(mCurrTimeSecs,60)),60)
    function currentTimeHours = mod(rtoi(div(mCurrTimeSecs,3600)),24)

    macro rule r_update_time =
        par
            mins := currentTimeMins
            hours := currentTimeHours
        endpar

    macro rule r_update_time_shown =
        par
            forall $t in TimeSlot with true do
                timeShown($t) := mod(plus(plus(currentTimeMins,$t),1),60)
            if neq(lastTimeUpdated,currentTimeMins) then
                par
                    lastTimeUpdated := currentTimeMins
                    forall $a in Airplane with true do
                        r_moveDown[$a,false,1]
                    forall $time in TimeSlot with gt($time,0) do
                        blocked(minus($time,1)) := blocked($time)
                endpar
            endif
        endpar

    macro rule r_Main =
        par
            r_update_lock[]
            r_update_zoom[]
            r_update_time[]
            r_update_time_shown[]
            if neq(selectedAirplane,undef) then
                if eq(action,UP) then
                    r_moveUp[selectedAirplane,true,numMoves]
                else 
                    if eq(action,DOWN) then
                        r_moveDown[selectedAirplane,true,numMoves]
                    else 
                        if eq(action,HOLD) then
                            r_hold[selectedAirplane]
                        endif
                    endif
                endif
            endif
        endpar


    // new main added by validator
    main rule r_main__ =
        switch step__
			case 0:
				seq
					if lastTimeUpdated = 0 then
						result := print("check succeeded: lastTimeUpdated = 0")
					else
						seq
							result := print("CHECK FAILED: lastTimeUpdated = 0 at step 0")
							step__ := -2
						endseq
					endif
					if landingSequence(18) = a3 then
						result := print("check succeeded: landingSequence(18) = a3")
					else
						seq
							result := print("CHECK FAILED: landingSequence(18) = a3 at step 0")
							step__ := -2
						endseq
					endif
					if landingSequence(17) = undef then
						result := print("check succeeded: landingSequence(17) = undef")
					else
						seq
							result := print("CHECK FAILED: landingSequence(17) = undef at step 0")
							step__ := -2
						endseq
					endif
					if landingSequence(14) = undef then
						result := print("check succeeded: landingSequence(14) = undef")
					else
						seq
							result := print("CHECK FAILED: landingSequence(14) = undef at step 0")
							step__ := -2
						endseq
					endif
					if landingSequence(13) = undef then
						result := print("check succeeded: landingSequence(13) = undef")
					else
						seq
							result := print("CHECK FAILED: landingSequence(13) = undef at step 0")
							step__ := -2
						endseq
					endif
					if landingSequence(16) = undef then
						result := print("check succeeded: landingSequence(16) = undef")
					else
						seq
							result := print("CHECK FAILED: landingSequence(16) = undef at step 0")
							step__ := -2
						endseq
					endif
					if landingSequence(15) = undef then
						result := print("check succeeded: landingSequence(15) = undef")
					else
						seq
							result := print("CHECK FAILED: landingSequence(15) = undef at step 0")
							step__ := -2
						endseq
					endif
					if landingSequence(10) = undef then
						result := print("check succeeded: landingSequence(10) = undef")
					else
						seq
							result := print("CHECK FAILED: landingSequence(10) = undef at step 0")
							step__ := -2
						endseq
					endif
					if landingSequence(9) = undef then
						result := print("check succeeded: landingSequence(9) = undef")
					else
						seq
							result := print("CHECK FAILED: landingSequence(9) = undef at step 0")
							step__ := -2
						endseq
					endif
					if landingSequence(12) = undef then
						result := print("check succeeded: landingSequence(12) = undef")
					else
						seq
							result := print("CHECK FAILED: landingSequence(12) = undef at step 0")
							step__ := -2
						endseq
					endif
					if landingSequence(11) = undef then
						result := print("check succeeded: landingSequence(11) = undef")
					else
						seq
							result := print("CHECK FAILED: landingSequence(11) = undef at step 0")
							step__ := -2
						endseq
					endif
					if landingSequence(6) = undef then
						result := print("check succeeded: landingSequence(6) = undef")
					else
						seq
							result := print("CHECK FAILED: landingSequence(6) = undef at step 0")
							step__ := -2
						endseq
					endif
					if landingSequence(5) = a1 then
						result := print("check succeeded: landingSequence(5) = a1")
					else
						seq
							result := print("CHECK FAILED: landingSequence(5) = a1 at step 0")
							step__ := -2
						endseq
					endif
					if landingSequence(8) = undef then
						result := print("check succeeded: landingSequence(8) = undef")
					else
						seq
							result := print("CHECK FAILED: landingSequence(8) = undef at step 0")
							step__ := -2
						endseq
					endif
					if landingSequence(7) = undef then
						result := print("check succeeded: landingSequence(7) = undef")
					else
						seq
							result := print("CHECK FAILED: landingSequence(7) = undef at step 0")
							step__ := -2
						endseq
					endif
					if landingSequence(2) = a2 then
						result := print("check succeeded: landingSequence(2) = a2")
					else
						seq
							result := print("CHECK FAILED: landingSequence(2) = a2 at step 0")
							step__ := -2
						endseq
					endif
					if landingSequence(33) = undef then
						result := print("check succeeded: landingSequence(33) = undef")
					else
						seq
							result := print("CHECK FAILED: landingSequence(33) = undef at step 0")
							step__ := -2
						endseq
					endif
					if landingSequence(1) = undef then
						result := print("check succeeded: landingSequence(1) = undef")
					else
						seq
							result := print("CHECK FAILED: landingSequence(1) = undef at step 0")
							step__ := -2
						endseq
					endif
					if landingSequence(4) = undef then
						result := print("check succeeded: landingSequence(4) = undef")
					else
						seq
							result := print("CHECK FAILED: landingSequence(4) = undef at step 0")
							step__ := -2
						endseq
					endif
					if landingSequence(3) = undef then
						result := print("check succeeded: landingSequence(3) = undef")
					else
						seq
							result := print("CHECK FAILED: landingSequence(3) = undef at step 0")
							step__ := -2
						endseq
					endif
					if zoomValue = 30 then
						result := print("check succeeded: zoomValue = 30")
					else
						seq
							result := print("CHECK FAILED: zoomValue = 30 at step 0")
							step__ := -2
						endseq
					endif
					if blocked(33) = false then
						result := print("check succeeded: blocked(33) = false")
					else
						seq
							result := print("CHECK FAILED: blocked(33) = false at step 0")
							step__ := -2
						endseq
					endif
					if landingSequence(0) = undef then
						result := print("check succeeded: landingSequence(0) = undef")
					else
						seq
							result := print("CHECK FAILED: landingSequence(0) = undef at step 0")
							step__ := -2
						endseq
					endif
					r_Main[]
					action := UP
					zoom := 41
					selectedAirplane := a3
					timeToLock := 15
					step__ := step__ + 1
				endseq
			case 1:
				seq
				if lastTimeUpdated = 0 then
					result := print("check succeeded: lastTimeUpdated = 0")
				else
					seq
						result := print("CHECK FAILED: lastTimeUpdated = 0 at step 1")
						step__ := -2
					endseq
				endif
				if landingSequence(18) = undef then
					result := print("check succeeded: landingSequence(18) = undef")
				else
					seq
						result := print("CHECK FAILED: landingSequence(18) = undef at step 1")
						step__ := -2
					endseq
				endif
				if landingSequence(17) = undef then
					result := print("check succeeded: landingSequence(17) = undef")
				else
					seq
						result := print("CHECK FAILED: landingSequence(17) = undef at step 1")
						step__ := -2
					endseq
				endif
				if landingSequence(14) = undef then
					result := print("check succeeded: landingSequence(14) = undef")
				else
					seq
						result := print("CHECK FAILED: landingSequence(14) = undef at step 1")
						step__ := -2
					endseq
				endif
				if landingSequence(13) = undef then
					result := print("check succeeded: landingSequence(13) = undef")
				else
					seq
						result := print("CHECK FAILED: landingSequence(13) = undef at step 1")
						step__ := -2
					endseq
				endif
				if landingSequence(16) = undef then
					result := print("check succeeded: landingSequence(16) = undef")
				else
					seq
						result := print("CHECK FAILED: landingSequence(16) = undef at step 1")
						step__ := -2
					endseq
				endif
				if landingSequence(15) = undef then
					result := print("check succeeded: landingSequence(15) = undef")
				else
					seq
						result := print("CHECK FAILED: landingSequence(15) = undef at step 1")
						step__ := -2
					endseq
				endif
				if landingSequence(10) = undef then
					result := print("check succeeded: landingSequence(10) = undef")
				else
					seq
						result := print("CHECK FAILED: landingSequence(10) = undef at step 1")
						step__ := -2
					endseq
				endif
				if landingSequence(9) = undef then
					result := print("check succeeded: landingSequence(9) = undef")
				else
					seq
						result := print("CHECK FAILED: landingSequence(9) = undef at step 1")
						step__ := -2
					endseq
				endif
				if landingSequence(12) = undef then
					result := print("check succeeded: landingSequence(12) = undef")
				else
					seq
						result := print("CHECK FAILED: landingSequence(12) = undef at step 1")
						step__ := -2
					endseq
				endif
				if landingSequence(11) = undef then
					result := print("check succeeded: landingSequence(11) = undef")
				else
					seq
						result := print("CHECK FAILED: landingSequence(11) = undef at step 1")
						step__ := -2
					endseq
				endif
				if landingSequence(6) = undef then
					result := print("check succeeded: landingSequence(6) = undef")
				else
					seq
						result := print("CHECK FAILED: landingSequence(6) = undef at step 1")
						step__ := -2
					endseq
				endif
				if landingSequence(5) = a1 then
					result := print("check succeeded: landingSequence(5) = a1")
				else
					seq
						result := print("CHECK FAILED: landingSequence(5) = a1 at step 1")
						step__ := -2
					endseq
				endif
				if landingSequence(8) = undef then
					result := print("check succeeded: landingSequence(8) = undef")
				else
					seq
						result := print("CHECK FAILED: landingSequence(8) = undef at step 1")
						step__ := -2
					endseq
				endif
				if landingSequence(7) = undef then
					result := print("check succeeded: landingSequence(7) = undef")
				else
					seq
						result := print("CHECK FAILED: landingSequence(7) = undef at step 1")
						step__ := -2
					endseq
				endif
				if landingSequence(2) = a2 then
					result := print("check succeeded: landingSequence(2) = a2")
				else
					seq
						result := print("CHECK FAILED: landingSequence(2) = a2 at step 1")
						step__ := -2
					endseq
				endif
				if landingSequence(33) = undef then
					result := print("check succeeded: landingSequence(33) = undef")
				else
					seq
						result := print("CHECK FAILED: landingSequence(33) = undef at step 1")
						step__ := -2
					endseq
				endif
				if landingSequence(1) = undef then
					result := print("check succeeded: landingSequence(1) = undef")
				else
					seq
						result := print("CHECK FAILED: landingSequence(1) = undef at step 1")
						step__ := -2
					endseq
				endif
				if landingSequence(4) = undef then
					result := print("check succeeded: landingSequence(4) = undef")
				else
					seq
						result := print("CHECK FAILED: landingSequence(4) = undef at step 1")
						step__ := -2
					endseq
				endif
				if landingSequence(3) = undef then
					result := print("check succeeded: landingSequence(3) = undef")
				else
					seq
						result := print("CHECK FAILED: landingSequence(3) = undef at step 1")
						step__ := -2
					endseq
				endif
				if zoomValue = 15 then
					result := print("check succeeded: zoomValue = 15")
				else
					seq
						result := print("CHECK FAILED: zoomValue = 15 at step 1")
						step__ := -2
					endseq
				endif
				if blocked(33) = true then
					result := print("check succeeded: blocked(33) = true")
				else
					seq
						result := print("CHECK FAILED: blocked(33) = true at step 1")
						step__ := -2
					endseq
				endif
				if landingSequence(0) = undef then
					result := print("check succeeded: landingSequence(0) = undef")
				else
					seq
						result := print("CHECK FAILED: landingSequence(0) = undef at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(11) = 12 then
					result := print("check succeeded: timeShown(11) = 12")
				else
					seq
						result := print("CHECK FAILED: timeShown(11) = 12 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(12) = 13 then
					result := print("check succeeded: timeShown(12) = 13")
				else
					seq
						result := print("CHECK FAILED: timeShown(12) = 13 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(9) = 10 then
					result := print("check succeeded: timeShown(9) = 10")
				else
					seq
						result := print("CHECK FAILED: timeShown(9) = 10 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(10) = 11 then
					result := print("check succeeded: timeShown(10) = 11")
				else
					seq
						result := print("CHECK FAILED: timeShown(10) = 11 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(7) = 8 then
					result := print("check succeeded: timeShown(7) = 8")
				else
					seq
						result := print("CHECK FAILED: timeShown(7) = 8 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(8) = 9 then
					result := print("check succeeded: timeShown(8) = 9")
				else
					seq
						result := print("CHECK FAILED: timeShown(8) = 9 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(5) = 6 then
					result := print("check succeeded: timeShown(5) = 6")
				else
					seq
						result := print("CHECK FAILED: timeShown(5) = 6 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(6) = 7 then
					result := print("check succeeded: timeShown(6) = 7")
				else
					seq
						result := print("CHECK FAILED: timeShown(6) = 7 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(19) = 20 then
					result := print("check succeeded: timeShown(19) = 20")
				else
					seq
						result := print("CHECK FAILED: timeShown(19) = 20 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(20) = 21 then
					result := print("check succeeded: timeShown(20) = 21")
				else
					seq
						result := print("CHECK FAILED: timeShown(20) = 21 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(17) = 18 then
					result := print("check succeeded: timeShown(17) = 18")
				else
					seq
						result := print("CHECK FAILED: timeShown(17) = 18 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(18) = 19 then
					result := print("check succeeded: timeShown(18) = 19")
				else
					seq
						result := print("CHECK FAILED: timeShown(18) = 19 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(15) = 16 then
					result := print("check succeeded: timeShown(15) = 16")
				else
					seq
						result := print("CHECK FAILED: timeShown(15) = 16 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(16) = 17 then
					result := print("check succeeded: timeShown(16) = 17")
				else
					seq
						result := print("CHECK FAILED: timeShown(16) = 17 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(13) = 14 then
					result := print("check succeeded: timeShown(13) = 14")
				else
					seq
						result := print("CHECK FAILED: timeShown(13) = 14 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(14) = 15 then
					result := print("check succeeded: timeShown(14) = 15")
				else
					seq
						result := print("CHECK FAILED: timeShown(14) = 15 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(27) = 28 then
					result := print("check succeeded: timeShown(27) = 28")
				else
					seq
						result := print("CHECK FAILED: timeShown(27) = 28 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(28) = 29 then
					result := print("check succeeded: timeShown(28) = 29")
				else
					seq
						result := print("CHECK FAILED: timeShown(28) = 29 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(25) = 26 then
					result := print("check succeeded: timeShown(25) = 26")
				else
					seq
						result := print("CHECK FAILED: timeShown(25) = 26 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(26) = 27 then
					result := print("check succeeded: timeShown(26) = 27")
				else
					seq
						result := print("CHECK FAILED: timeShown(26) = 27 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(23) = 24 then
					result := print("check succeeded: timeShown(23) = 24")
				else
					seq
						result := print("CHECK FAILED: timeShown(23) = 24 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(24) = 25 then
					result := print("check succeeded: timeShown(24) = 25")
				else
					seq
						result := print("CHECK FAILED: timeShown(24) = 25 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(21) = 22 then
					result := print("check succeeded: timeShown(21) = 22")
				else
					seq
						result := print("CHECK FAILED: timeShown(21) = 22 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(22) = 23 then
					result := print("check succeeded: timeShown(22) = 23")
				else
					seq
						result := print("CHECK FAILED: timeShown(22) = 23 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(35) = 36 then
					result := print("check succeeded: timeShown(35) = 36")
				else
					seq
						result := print("CHECK FAILED: timeShown(35) = 36 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(36) = 37 then
					result := print("check succeeded: timeShown(36) = 37")
				else
					seq
						result := print("CHECK FAILED: timeShown(36) = 37 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(33) = 34 then
					result := print("check succeeded: timeShown(33) = 34")
				else
					seq
						result := print("CHECK FAILED: timeShown(33) = 34 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(34) = 35 then
					result := print("check succeeded: timeShown(34) = 35")
				else
					seq
						result := print("CHECK FAILED: timeShown(34) = 35 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(31) = 32 then
					result := print("check succeeded: timeShown(31) = 32")
				else
					seq
						result := print("CHECK FAILED: timeShown(31) = 32 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(32) = 33 then
					result := print("check succeeded: timeShown(32) = 33")
				else
					seq
						result := print("CHECK FAILED: timeShown(32) = 33 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(29) = 30 then
					result := print("check succeeded: timeShown(29) = 30")
				else
					seq
						result := print("CHECK FAILED: timeShown(29) = 30 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(30) = 31 then
					result := print("check succeeded: timeShown(30) = 31")
				else
					seq
						result := print("CHECK FAILED: timeShown(30) = 31 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(43) = 44 then
					result := print("check succeeded: timeShown(43) = 44")
				else
					seq
						result := print("CHECK FAILED: timeShown(43) = 44 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(44) = 45 then
					result := print("check succeeded: timeShown(44) = 45")
				else
					seq
						result := print("CHECK FAILED: timeShown(44) = 45 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(41) = 42 then
					result := print("check succeeded: timeShown(41) = 42")
				else
					seq
						result := print("CHECK FAILED: timeShown(41) = 42 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(42) = 43 then
					result := print("check succeeded: timeShown(42) = 43")
				else
					seq
						result := print("CHECK FAILED: timeShown(42) = 43 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(39) = 40 then
					result := print("check succeeded: timeShown(39) = 40")
				else
					seq
						result := print("CHECK FAILED: timeShown(39) = 40 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(40) = 41 then
					result := print("check succeeded: timeShown(40) = 41")
				else
					seq
						result := print("CHECK FAILED: timeShown(40) = 41 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(37) = 38 then
					result := print("check succeeded: timeShown(37) = 38")
				else
					seq
						result := print("CHECK FAILED: timeShown(37) = 38 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(38) = 39 then
					result := print("check succeeded: timeShown(38) = 39")
				else
					seq
						result := print("CHECK FAILED: timeShown(38) = 39 at step 1")
						step__ := -2
					endseq
				endif
				if mins = 0 then
					result := print("check succeeded: mins = 0")
				else
					seq
						result := print("CHECK FAILED: mins = 0 at step 1")
						step__ := -2
					endseq
				endif
				if hours = 0 then
					result := print("check succeeded: hours = 0")
				else
					seq
						result := print("CHECK FAILED: hours = 0 at step 1")
						step__ := -2
					endseq
				endif
				if landingSequenceColor(18) = WHITE then
					result := print("check succeeded: landingSequenceColor(18) = WHITE")
				else
					seq
						result := print("CHECK FAILED: landingSequenceColor(18) = WHITE at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(3) = 4 then
					result := print("check succeeded: timeShown(3) = 4")
				else
					seq
						result := print("CHECK FAILED: timeShown(3) = 4 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(4) = 5 then
					result := print("check succeeded: timeShown(4) = 5")
				else
					seq
						result := print("CHECK FAILED: timeShown(4) = 5 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(1) = 2 then
					result := print("check succeeded: timeShown(1) = 2")
				else
					seq
						result := print("CHECK FAILED: timeShown(1) = 2 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(2) = 3 then
					result := print("check succeeded: timeShown(2) = 3")
				else
					seq
						result := print("CHECK FAILED: timeShown(2) = 3 at step 1")
						step__ := -2
					endseq
				endif
				if timeShown(0) = 1 then
					result := print("check succeeded: timeShown(0) = 1")
				else
					seq
						result := print("CHECK FAILED: timeShown(0) = 1 at step 1")
						step__ := -2
					endseq
				endif
				if blocked(15) = false then
					result := print("check succeeded: blocked(15) = false")
				else
					seq
						result := print("CHECK FAILED: blocked(15) = false at step 1")
						step__ := -2
					endseq
				endif
				r_Main[]
				action := DOWN
				zoom := 23
				selectedAirplane := a1
				timeToLock := 12
				numMoves := 37
				step__ := step__ + 1
			endseq
			case 2:
				seq
			if lastTimeUpdated = 0 then
				result := print("check succeeded: lastTimeUpdated = 0")
			else
				seq
					result := print("CHECK FAILED: lastTimeUpdated = 0 at step 2")
					step__ := -2
				endseq
			endif
			if landingSequence(18) = undef then
				result := print("check succeeded: landingSequence(18) = undef")
			else
				seq
					result := print("CHECK FAILED: landingSequence(18) = undef at step 2")
					step__ := -2
				endseq
			endif
			if landingSequence(17) = undef then
				result := print("check succeeded: landingSequence(17) = undef")
			else
				seq
					result := print("CHECK FAILED: landingSequence(17) = undef at step 2")
					step__ := -2
				endseq
			endif
			if landingSequence(14) = undef then
				result := print("check succeeded: landingSequence(14) = undef")
			else
				seq
					result := print("CHECK FAILED: landingSequence(14) = undef at step 2")
					step__ := -2
				endseq
			endif
			if landingSequence(13) = undef then
				result := print("check succeeded: landingSequence(13) = undef")
			else
				seq
					result := print("CHECK FAILED: landingSequence(13) = undef at step 2")
					step__ := -2
				endseq
			endif
			if landingSequence(16) = undef then
				result := print("check succeeded: landingSequence(16) = undef")
			else
				seq
					result := print("CHECK FAILED: landingSequence(16) = undef at step 2")
					step__ := -2
				endseq
			endif
			if landingSequence(15) = undef then
				result := print("check succeeded: landingSequence(15) = undef")
			else
				seq
					result := print("CHECK FAILED: landingSequence(15) = undef at step 2")
					step__ := -2
				endseq
			endif
			if landingSequence(10) = undef then
				result := print("check succeeded: landingSequence(10) = undef")
			else
				seq
					result := print("CHECK FAILED: landingSequence(10) = undef at step 2")
					step__ := -2
				endseq
			endif
			if landingSequence(9) = undef then
				result := print("check succeeded: landingSequence(9) = undef")
			else
				seq
					result := print("CHECK FAILED: landingSequence(9) = undef at step 2")
					step__ := -2
				endseq
			endif
			if landingSequence(12) = undef then
				result := print("check succeeded: landingSequence(12) = undef")
			else
				seq
					result := print("CHECK FAILED: landingSequence(12) = undef at step 2")
					step__ := -2
				endseq
			endif
			if landingSequence(11) = undef then
				result := print("check succeeded: landingSequence(11) = undef")
			else
				seq
					result := print("CHECK FAILED: landingSequence(11) = undef at step 2")
					step__ := -2
				endseq
			endif
			if landingSequence(6) = undef then
				result := print("check succeeded: landingSequence(6) = undef")
			else
				seq
					result := print("CHECK FAILED: landingSequence(6) = undef at step 2")
					step__ := -2
				endseq
			endif
			if landingSequence(5) = a1 then
				result := print("check succeeded: landingSequence(5) = a1")
			else
				seq
					result := print("CHECK FAILED: landingSequence(5) = a1 at step 2")
					step__ := -2
				endseq
			endif
			if landingSequence(8) = undef then
				result := print("check succeeded: landingSequence(8) = undef")
			else
				seq
					result := print("CHECK FAILED: landingSequence(8) = undef at step 2")
					step__ := -2
				endseq
			endif
			if landingSequence(7) = undef then
				result := print("check succeeded: landingSequence(7) = undef")
			else
				seq
					result := print("CHECK FAILED: landingSequence(7) = undef at step 2")
					step__ := -2
				endseq
			endif
			if landingSequence(2) = a2 then
				result := print("check succeeded: landingSequence(2) = a2")
			else
				seq
					result := print("CHECK FAILED: landingSequence(2) = a2 at step 2")
					step__ := -2
				endseq
			endif
			if landingSequence(33) = undef then
				result := print("check succeeded: landingSequence(33) = undef")
			else
				seq
					result := print("CHECK FAILED: landingSequence(33) = undef at step 2")
					step__ := -2
				endseq
			endif
			if landingSequence(1) = undef then
				result := print("check succeeded: landingSequence(1) = undef")
			else
				seq
					result := print("CHECK FAILED: landingSequence(1) = undef at step 2")
					step__ := -2
				endseq
			endif
			if landingSequence(4) = undef then
				result := print("check succeeded: landingSequence(4) = undef")
			else
				seq
					result := print("CHECK FAILED: landingSequence(4) = undef at step 2")
					step__ := -2
				endseq
			endif
			if landingSequence(3) = undef then
				result := print("check succeeded: landingSequence(3) = undef")
			else
				seq
					result := print("CHECK FAILED: landingSequence(3) = undef at step 2")
					step__ := -2
				endseq
			endif
			if zoomValue = 15 then
				result := print("check succeeded: zoomValue = 15")
			else
				seq
					result := print("CHECK FAILED: zoomValue = 15 at step 2")
					step__ := -2
				endseq
			endif
			if blocked(33) = true then
				result := print("check succeeded: blocked(33) = true")
			else
				seq
					result := print("CHECK FAILED: blocked(33) = true at step 2")
					step__ := -2
				endseq
			endif
			if landingSequence(0) = undef then
				result := print("check succeeded: landingSequence(0) = undef")
			else
				seq
					result := print("CHECK FAILED: landingSequence(0) = undef at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(11) = 12 then
				result := print("check succeeded: timeShown(11) = 12")
			else
				seq
					result := print("CHECK FAILED: timeShown(11) = 12 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(12) = 13 then
				result := print("check succeeded: timeShown(12) = 13")
			else
				seq
					result := print("CHECK FAILED: timeShown(12) = 13 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(9) = 10 then
				result := print("check succeeded: timeShown(9) = 10")
			else
				seq
					result := print("CHECK FAILED: timeShown(9) = 10 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(10) = 11 then
				result := print("check succeeded: timeShown(10) = 11")
			else
				seq
					result := print("CHECK FAILED: timeShown(10) = 11 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(7) = 8 then
				result := print("check succeeded: timeShown(7) = 8")
			else
				seq
					result := print("CHECK FAILED: timeShown(7) = 8 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(8) = 9 then
				result := print("check succeeded: timeShown(8) = 9")
			else
				seq
					result := print("CHECK FAILED: timeShown(8) = 9 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(5) = 6 then
				result := print("check succeeded: timeShown(5) = 6")
			else
				seq
					result := print("CHECK FAILED: timeShown(5) = 6 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(6) = 7 then
				result := print("check succeeded: timeShown(6) = 7")
			else
				seq
					result := print("CHECK FAILED: timeShown(6) = 7 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(19) = 20 then
				result := print("check succeeded: timeShown(19) = 20")
			else
				seq
					result := print("CHECK FAILED: timeShown(19) = 20 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(20) = 21 then
				result := print("check succeeded: timeShown(20) = 21")
			else
				seq
					result := print("CHECK FAILED: timeShown(20) = 21 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(17) = 18 then
				result := print("check succeeded: timeShown(17) = 18")
			else
				seq
					result := print("CHECK FAILED: timeShown(17) = 18 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(18) = 19 then
				result := print("check succeeded: timeShown(18) = 19")
			else
				seq
					result := print("CHECK FAILED: timeShown(18) = 19 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(15) = 16 then
				result := print("check succeeded: timeShown(15) = 16")
			else
				seq
					result := print("CHECK FAILED: timeShown(15) = 16 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(16) = 17 then
				result := print("check succeeded: timeShown(16) = 17")
			else
				seq
					result := print("CHECK FAILED: timeShown(16) = 17 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(13) = 14 then
				result := print("check succeeded: timeShown(13) = 14")
			else
				seq
					result := print("CHECK FAILED: timeShown(13) = 14 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(14) = 15 then
				result := print("check succeeded: timeShown(14) = 15")
			else
				seq
					result := print("CHECK FAILED: timeShown(14) = 15 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(27) = 28 then
				result := print("check succeeded: timeShown(27) = 28")
			else
				seq
					result := print("CHECK FAILED: timeShown(27) = 28 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(28) = 29 then
				result := print("check succeeded: timeShown(28) = 29")
			else
				seq
					result := print("CHECK FAILED: timeShown(28) = 29 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(25) = 26 then
				result := print("check succeeded: timeShown(25) = 26")
			else
				seq
					result := print("CHECK FAILED: timeShown(25) = 26 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(26) = 27 then
				result := print("check succeeded: timeShown(26) = 27")
			else
				seq
					result := print("CHECK FAILED: timeShown(26) = 27 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(23) = 24 then
				result := print("check succeeded: timeShown(23) = 24")
			else
				seq
					result := print("CHECK FAILED: timeShown(23) = 24 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(24) = 25 then
				result := print("check succeeded: timeShown(24) = 25")
			else
				seq
					result := print("CHECK FAILED: timeShown(24) = 25 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(21) = 22 then
				result := print("check succeeded: timeShown(21) = 22")
			else
				seq
					result := print("CHECK FAILED: timeShown(21) = 22 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(22) = 23 then
				result := print("check succeeded: timeShown(22) = 23")
			else
				seq
					result := print("CHECK FAILED: timeShown(22) = 23 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(35) = 36 then
				result := print("check succeeded: timeShown(35) = 36")
			else
				seq
					result := print("CHECK FAILED: timeShown(35) = 36 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(36) = 37 then
				result := print("check succeeded: timeShown(36) = 37")
			else
				seq
					result := print("CHECK FAILED: timeShown(36) = 37 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(33) = 34 then
				result := print("check succeeded: timeShown(33) = 34")
			else
				seq
					result := print("CHECK FAILED: timeShown(33) = 34 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(34) = 35 then
				result := print("check succeeded: timeShown(34) = 35")
			else
				seq
					result := print("CHECK FAILED: timeShown(34) = 35 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(31) = 32 then
				result := print("check succeeded: timeShown(31) = 32")
			else
				seq
					result := print("CHECK FAILED: timeShown(31) = 32 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(32) = 33 then
				result := print("check succeeded: timeShown(32) = 33")
			else
				seq
					result := print("CHECK FAILED: timeShown(32) = 33 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(29) = 30 then
				result := print("check succeeded: timeShown(29) = 30")
			else
				seq
					result := print("CHECK FAILED: timeShown(29) = 30 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(30) = 31 then
				result := print("check succeeded: timeShown(30) = 31")
			else
				seq
					result := print("CHECK FAILED: timeShown(30) = 31 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(43) = 44 then
				result := print("check succeeded: timeShown(43) = 44")
			else
				seq
					result := print("CHECK FAILED: timeShown(43) = 44 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(44) = 45 then
				result := print("check succeeded: timeShown(44) = 45")
			else
				seq
					result := print("CHECK FAILED: timeShown(44) = 45 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(41) = 42 then
				result := print("check succeeded: timeShown(41) = 42")
			else
				seq
					result := print("CHECK FAILED: timeShown(41) = 42 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(42) = 43 then
				result := print("check succeeded: timeShown(42) = 43")
			else
				seq
					result := print("CHECK FAILED: timeShown(42) = 43 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(39) = 40 then
				result := print("check succeeded: timeShown(39) = 40")
			else
				seq
					result := print("CHECK FAILED: timeShown(39) = 40 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(40) = 41 then
				result := print("check succeeded: timeShown(40) = 41")
			else
				seq
					result := print("CHECK FAILED: timeShown(40) = 41 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(37) = 38 then
				result := print("check succeeded: timeShown(37) = 38")
			else
				seq
					result := print("CHECK FAILED: timeShown(37) = 38 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(38) = 39 then
				result := print("check succeeded: timeShown(38) = 39")
			else
				seq
					result := print("CHECK FAILED: timeShown(38) = 39 at step 2")
					step__ := -2
				endseq
			endif
			if mins = 0 then
				result := print("check succeeded: mins = 0")
			else
				seq
					result := print("CHECK FAILED: mins = 0 at step 2")
					step__ := -2
				endseq
			endif
			if hours = 0 then
				result := print("check succeeded: hours = 0")
			else
				seq
					result := print("CHECK FAILED: hours = 0 at step 2")
					step__ := -2
				endseq
			endif
			if landingSequenceColor(18) = WHITE then
				result := print("check succeeded: landingSequenceColor(18) = WHITE")
			else
				seq
					result := print("CHECK FAILED: landingSequenceColor(18) = WHITE at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(3) = 4 then
				result := print("check succeeded: timeShown(3) = 4")
			else
				seq
					result := print("CHECK FAILED: timeShown(3) = 4 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(4) = 5 then
				result := print("check succeeded: timeShown(4) = 5")
			else
				seq
					result := print("CHECK FAILED: timeShown(4) = 5 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(1) = 2 then
				result := print("check succeeded: timeShown(1) = 2")
			else
				seq
					result := print("CHECK FAILED: timeShown(1) = 2 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(2) = 3 then
				result := print("check succeeded: timeShown(2) = 3")
			else
				seq
					result := print("CHECK FAILED: timeShown(2) = 3 at step 2")
					step__ := -2
				endseq
			endif
			if timeShown(0) = 1 then
				result := print("check succeeded: timeShown(0) = 1")
			else
				seq
					result := print("CHECK FAILED: timeShown(0) = 1 at step 2")
					step__ := -2
				endseq
			endif
			if blocked(15) = true then
				result := print("check succeeded: blocked(15) = true")
			else
				seq
					result := print("CHECK FAILED: blocked(15) = true at step 2")
					step__ := -2
				endseq
			endif
			r_Main[]
			step__ := step__ + 1
		endseq
			case 3:
				seq
		if lastTimeUpdated = 0 then
			result := print("check succeeded: lastTimeUpdated = 0")
		else
			seq
				result := print("CHECK FAILED: lastTimeUpdated = 0 at step 3")
				step__ := -2
			endseq
		endif
		if landingSequence(18) = undef then
			result := print("check succeeded: landingSequence(18) = undef")
		else
			seq
				result := print("CHECK FAILED: landingSequence(18) = undef at step 3")
				step__ := -2
			endseq
		endif
		if landingSequence(17) = undef then
			result := print("check succeeded: landingSequence(17) = undef")
		else
			seq
				result := print("CHECK FAILED: landingSequence(17) = undef at step 3")
				step__ := -2
			endseq
		endif
		if landingSequence(14) = undef then
			result := print("check succeeded: landingSequence(14) = undef")
		else
			seq
				result := print("CHECK FAILED: landingSequence(14) = undef at step 3")
				step__ := -2
			endseq
		endif
		if landingSequence(13) = undef then
			result := print("check succeeded: landingSequence(13) = undef")
		else
			seq
				result := print("CHECK FAILED: landingSequence(13) = undef at step 3")
				step__ := -2
			endseq
		endif
		if landingSequence(16) = undef then
			result := print("check succeeded: landingSequence(16) = undef")
		else
			seq
				result := print("CHECK FAILED: landingSequence(16) = undef at step 3")
				step__ := -2
			endseq
		endif
		if landingSequence(15) = undef then
			result := print("check succeeded: landingSequence(15) = undef")
		else
			seq
				result := print("CHECK FAILED: landingSequence(15) = undef at step 3")
				step__ := -2
			endseq
		endif
		if landingSequence(10) = undef then
			result := print("check succeeded: landingSequence(10) = undef")
		else
			seq
				result := print("CHECK FAILED: landingSequence(10) = undef at step 3")
				step__ := -2
			endseq
		endif
		if landingSequence(9) = undef then
			result := print("check succeeded: landingSequence(9) = undef")
		else
			seq
				result := print("CHECK FAILED: landingSequence(9) = undef at step 3")
				step__ := -2
			endseq
		endif
		if landingSequence(12) = undef then
			result := print("check succeeded: landingSequence(12) = undef")
		else
			seq
				result := print("CHECK FAILED: landingSequence(12) = undef at step 3")
				step__ := -2
			endseq
		endif
		if landingSequence(11) = undef then
			result := print("check succeeded: landingSequence(11) = undef")
		else
			seq
				result := print("CHECK FAILED: landingSequence(11) = undef at step 3")
				step__ := -2
			endseq
		endif
		if landingSequence(6) = undef then
			result := print("check succeeded: landingSequence(6) = undef")
		else
			seq
				result := print("CHECK FAILED: landingSequence(6) = undef at step 3")
				step__ := -2
			endseq
		endif
		if landingSequence(5) = a1 then
			result := print("check succeeded: landingSequence(5) = a1")
		else
			seq
				result := print("CHECK FAILED: landingSequence(5) = a1 at step 3")
				step__ := -2
			endseq
		endif
		if landingSequence(8) = undef then
			result := print("check succeeded: landingSequence(8) = undef")
		else
			seq
				result := print("CHECK FAILED: landingSequence(8) = undef at step 3")
				step__ := -2
			endseq
		endif
		if landingSequence(7) = undef then
			result := print("check succeeded: landingSequence(7) = undef")
		else
			seq
				result := print("CHECK FAILED: landingSequence(7) = undef at step 3")
				step__ := -2
			endseq
		endif
		if landingSequence(2) = a2 then
			result := print("check succeeded: landingSequence(2) = a2")
		else
			seq
				result := print("CHECK FAILED: landingSequence(2) = a2 at step 3")
				step__ := -2
			endseq
		endif
		if landingSequence(33) = undef then
			result := print("check succeeded: landingSequence(33) = undef")
		else
			seq
				result := print("CHECK FAILED: landingSequence(33) = undef at step 3")
				step__ := -2
			endseq
		endif
		if landingSequence(1) = undef then
			result := print("check succeeded: landingSequence(1) = undef")
		else
			seq
				result := print("CHECK FAILED: landingSequence(1) = undef at step 3")
				step__ := -2
			endseq
		endif
		if landingSequence(4) = undef then
			result := print("check succeeded: landingSequence(4) = undef")
		else
			seq
				result := print("CHECK FAILED: landingSequence(4) = undef at step 3")
				step__ := -2
			endseq
		endif
		if landingSequence(3) = undef then
			result := print("check succeeded: landingSequence(3) = undef")
		else
			seq
				result := print("CHECK FAILED: landingSequence(3) = undef at step 3")
				step__ := -2
			endseq
		endif
		if zoomValue = 15 then
			result := print("check succeeded: zoomValue = 15")
		else
			seq
				result := print("CHECK FAILED: zoomValue = 15 at step 3")
				step__ := -2
			endseq
		endif
		if blocked(33) = true then
			result := print("check succeeded: blocked(33) = true")
		else
			seq
				result := print("CHECK FAILED: blocked(33) = true at step 3")
				step__ := -2
			endseq
		endif
		if landingSequence(0) = undef then
			result := print("check succeeded: landingSequence(0) = undef")
		else
			seq
				result := print("CHECK FAILED: landingSequence(0) = undef at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(11) = 12 then
			result := print("check succeeded: timeShown(11) = 12")
		else
			seq
				result := print("CHECK FAILED: timeShown(11) = 12 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(12) = 13 then
			result := print("check succeeded: timeShown(12) = 13")
		else
			seq
				result := print("CHECK FAILED: timeShown(12) = 13 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(9) = 10 then
			result := print("check succeeded: timeShown(9) = 10")
		else
			seq
				result := print("CHECK FAILED: timeShown(9) = 10 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(10) = 11 then
			result := print("check succeeded: timeShown(10) = 11")
		else
			seq
				result := print("CHECK FAILED: timeShown(10) = 11 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(7) = 8 then
			result := print("check succeeded: timeShown(7) = 8")
		else
			seq
				result := print("CHECK FAILED: timeShown(7) = 8 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(8) = 9 then
			result := print("check succeeded: timeShown(8) = 9")
		else
			seq
				result := print("CHECK FAILED: timeShown(8) = 9 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(5) = 6 then
			result := print("check succeeded: timeShown(5) = 6")
		else
			seq
				result := print("CHECK FAILED: timeShown(5) = 6 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(6) = 7 then
			result := print("check succeeded: timeShown(6) = 7")
		else
			seq
				result := print("CHECK FAILED: timeShown(6) = 7 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(19) = 20 then
			result := print("check succeeded: timeShown(19) = 20")
		else
			seq
				result := print("CHECK FAILED: timeShown(19) = 20 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(20) = 21 then
			result := print("check succeeded: timeShown(20) = 21")
		else
			seq
				result := print("CHECK FAILED: timeShown(20) = 21 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(17) = 18 then
			result := print("check succeeded: timeShown(17) = 18")
		else
			seq
				result := print("CHECK FAILED: timeShown(17) = 18 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(18) = 19 then
			result := print("check succeeded: timeShown(18) = 19")
		else
			seq
				result := print("CHECK FAILED: timeShown(18) = 19 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(15) = 16 then
			result := print("check succeeded: timeShown(15) = 16")
		else
			seq
				result := print("CHECK FAILED: timeShown(15) = 16 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(16) = 17 then
			result := print("check succeeded: timeShown(16) = 17")
		else
			seq
				result := print("CHECK FAILED: timeShown(16) = 17 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(13) = 14 then
			result := print("check succeeded: timeShown(13) = 14")
		else
			seq
				result := print("CHECK FAILED: timeShown(13) = 14 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(14) = 15 then
			result := print("check succeeded: timeShown(14) = 15")
		else
			seq
				result := print("CHECK FAILED: timeShown(14) = 15 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(27) = 28 then
			result := print("check succeeded: timeShown(27) = 28")
		else
			seq
				result := print("CHECK FAILED: timeShown(27) = 28 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(28) = 29 then
			result := print("check succeeded: timeShown(28) = 29")
		else
			seq
				result := print("CHECK FAILED: timeShown(28) = 29 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(25) = 26 then
			result := print("check succeeded: timeShown(25) = 26")
		else
			seq
				result := print("CHECK FAILED: timeShown(25) = 26 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(26) = 27 then
			result := print("check succeeded: timeShown(26) = 27")
		else
			seq
				result := print("CHECK FAILED: timeShown(26) = 27 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(23) = 24 then
			result := print("check succeeded: timeShown(23) = 24")
		else
			seq
				result := print("CHECK FAILED: timeShown(23) = 24 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(24) = 25 then
			result := print("check succeeded: timeShown(24) = 25")
		else
			seq
				result := print("CHECK FAILED: timeShown(24) = 25 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(21) = 22 then
			result := print("check succeeded: timeShown(21) = 22")
		else
			seq
				result := print("CHECK FAILED: timeShown(21) = 22 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(22) = 23 then
			result := print("check succeeded: timeShown(22) = 23")
		else
			seq
				result := print("CHECK FAILED: timeShown(22) = 23 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(35) = 36 then
			result := print("check succeeded: timeShown(35) = 36")
		else
			seq
				result := print("CHECK FAILED: timeShown(35) = 36 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(36) = 37 then
			result := print("check succeeded: timeShown(36) = 37")
		else
			seq
				result := print("CHECK FAILED: timeShown(36) = 37 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(33) = 34 then
			result := print("check succeeded: timeShown(33) = 34")
		else
			seq
				result := print("CHECK FAILED: timeShown(33) = 34 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(34) = 35 then
			result := print("check succeeded: timeShown(34) = 35")
		else
			seq
				result := print("CHECK FAILED: timeShown(34) = 35 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(31) = 32 then
			result := print("check succeeded: timeShown(31) = 32")
		else
			seq
				result := print("CHECK FAILED: timeShown(31) = 32 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(32) = 33 then
			result := print("check succeeded: timeShown(32) = 33")
		else
			seq
				result := print("CHECK FAILED: timeShown(32) = 33 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(29) = 30 then
			result := print("check succeeded: timeShown(29) = 30")
		else
			seq
				result := print("CHECK FAILED: timeShown(29) = 30 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(30) = 31 then
			result := print("check succeeded: timeShown(30) = 31")
		else
			seq
				result := print("CHECK FAILED: timeShown(30) = 31 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(43) = 44 then
			result := print("check succeeded: timeShown(43) = 44")
		else
			seq
				result := print("CHECK FAILED: timeShown(43) = 44 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(44) = 45 then
			result := print("check succeeded: timeShown(44) = 45")
		else
			seq
				result := print("CHECK FAILED: timeShown(44) = 45 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(41) = 42 then
			result := print("check succeeded: timeShown(41) = 42")
		else
			seq
				result := print("CHECK FAILED: timeShown(41) = 42 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(42) = 43 then
			result := print("check succeeded: timeShown(42) = 43")
		else
			seq
				result := print("CHECK FAILED: timeShown(42) = 43 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(39) = 40 then
			result := print("check succeeded: timeShown(39) = 40")
		else
			seq
				result := print("CHECK FAILED: timeShown(39) = 40 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(40) = 41 then
			result := print("check succeeded: timeShown(40) = 41")
		else
			seq
				result := print("CHECK FAILED: timeShown(40) = 41 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(37) = 38 then
			result := print("check succeeded: timeShown(37) = 38")
		else
			seq
				result := print("CHECK FAILED: timeShown(37) = 38 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(38) = 39 then
			result := print("check succeeded: timeShown(38) = 39")
		else
			seq
				result := print("CHECK FAILED: timeShown(38) = 39 at step 3")
				step__ := -2
			endseq
		endif
		if mins = 0 then
			result := print("check succeeded: mins = 0")
		else
			seq
				result := print("CHECK FAILED: mins = 0 at step 3")
				step__ := -2
			endseq
		endif
		if hours = 0 then
			result := print("check succeeded: hours = 0")
		else
			seq
				result := print("CHECK FAILED: hours = 0 at step 3")
				step__ := -2
			endseq
		endif
		if landingSequenceColor(18) = WHITE then
			result := print("check succeeded: landingSequenceColor(18) = WHITE")
		else
			seq
				result := print("CHECK FAILED: landingSequenceColor(18) = WHITE at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(3) = 4 then
			result := print("check succeeded: timeShown(3) = 4")
		else
			seq
				result := print("CHECK FAILED: timeShown(3) = 4 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(4) = 5 then
			result := print("check succeeded: timeShown(4) = 5")
		else
			seq
				result := print("CHECK FAILED: timeShown(4) = 5 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(1) = 2 then
			result := print("check succeeded: timeShown(1) = 2")
		else
			seq
				result := print("CHECK FAILED: timeShown(1) = 2 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(2) = 3 then
			result := print("check succeeded: timeShown(2) = 3")
		else
			seq
				result := print("CHECK FAILED: timeShown(2) = 3 at step 3")
				step__ := -2
			endseq
		endif
		if timeShown(0) = 1 then
			result := print("check succeeded: timeShown(0) = 1")
		else
			seq
				result := print("CHECK FAILED: timeShown(0) = 1 at step 3")
				step__ := -2
			endseq
		endif
		if blocked(15) = true then
			result := print("check succeeded: blocked(15) = true")
		else
			seq
				result := print("CHECK FAILED: blocked(15) = true at step 3")
				step__ := -2
			endseq
		endif
		if blocked(12) = false then
			result := print("check succeeded: blocked(12) = false")
		else
			seq
				result := print("CHECK FAILED: blocked(12) = false at step 3")
				step__ := -2
			endseq
		endif
		if blocked(-32) = false then
			result := print("check succeeded: blocked(-32) = false")
		else
			seq
				result := print("CHECK FAILED: blocked(-32) = false at step 3")
				step__ := -2
			endseq
		endif
		r_Main[]
		step__ := step__ + 1
	endseq
		endswitch
    // added by validator (Initialization)
    default init s0:
        // added by validator (visitFuncInits)
        function step__ = 0
        function action = HOLD
        function zoom = 15
        function selectedAirplane = a3
        function timeToLock = 33
        function mCurrTimeSecs = 1
        function landingSequence($t in TimeSlot) = if eq($t,5) then a1 else if eq($t,2) then a2 else if eq($t,18) then a3 else if eq($t,35) then a4 else undef endif endif endif endif
        function zoomValue = 30
        // action is initialized also in the initial state - it will ignored
        // function action = NONE
        // selectedAirplane is initialized also in the initial state - it will ignored
        // function selectedAirplane = undef
        // this function does not belong to this asm, but it can be initialized 
        function timeShown($t in TimeSlot) = plus($t,1)
        // this function does not belong to this asm, but it can be initialized 
        function lastTimeUpdated = currentTimeMins
        function statusOutput($t in Airplane) = if eq($t,a1) then UNSTABLE else if eq($t,a2) then FREEZE else STABLE endif endif
        function landingSequenceColor($t in TimeSlot) = if eq($t,5) then YELLOW else if eq($t,2) then CYAN else WHITE endif endif
        function blocked($t in TimeSlot) = if eq($t,6) then true else false endif
        // this function does not belong to this asm, but it can be initialized 
        function mins = 0
        // this function does not belong to this asm, but it can be initialized 
        function hours = 0
