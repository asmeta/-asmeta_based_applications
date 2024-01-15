// translation of the asm (for avalla) file:///D:/AgHome/progettidaSVNGIT/asmeta/asmeta_based_applications/fMVC/AMAN/model/aman1_wom.asm
module _aman1_wom_10790079396382685890
import D:\\AgHome\\progettidaSVNGIT\\asmeta\\asmeta_based_applications\\fMVC\\AMAN\\model\\StandardLibrary
import D:\\AgHome\\progettidaSVNGIT\\asmeta\\asmeta_based_applications\\fMVC\\AMAN\\model\\CTLlibrary
export *

signature:
    domain TimeSlot subsetof Integer
    domain ZoomValue subsetof Integer
    abstract domain Airplane
    enum domain Status = {UNSTABLE | STABLE | FREEZE}
    enum domain Color = {YELLOW | CYAN | WHITE}
    enum domain PTCOAction = {UP | DOWN | NONE | HOLD}

    controlled landingSequence: TimeSlot -> Airplane
    derived landingTime: Airplane -> TimeSlot
    // converted to controlled by validator
    controlled statusInput: Airplane -> Status
    controlled statusOutput: Airplane -> Status
    // converted to controlled by validator
    controlled zoom: ZoomValue
    // converted to controlled by validator
    controlled selectedAirplane: Airplane
    // converted to controlled by validator
    controlled action: PTCOAction
    // converted to controlled by validator
    controlled timeToLock: TimeSlot
    // converted to controlled by validator
    controlled numMoves: TimeSlot
    controlled blocked: TimeSlot -> Boolean
    controlled zoomValue: ZoomValue
    controlled landingSequenceColor: TimeSlot -> Color
    static color: Status -> Color
    static search: Prod(Airplane, TimeSlot) -> TimeSlot
    static canBeMovedUp: Prod(Airplane, TimeSlot) -> Boolean
    static canBeMovedDown: Prod(Airplane, TimeSlot) -> Boolean
    static fr1988: Airplane
    static u21748: Airplane
    static fr1989: Airplane
    static a4: Airplane

definitions:

    domain TimeSlot = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44}
    domain ZoomValue = {15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45}

    function color($s in Status) = if eq($s,UNSTABLE) then YELLOW else if eq($s,STABLE) then CYAN else if eq($s,FREEZE) then WHITE endif endif endif
    function search($a in Airplane, $t in TimeSlot) = if eq(landingSequence($t),$a) then $t else if gt($t,zoomValue) then undef else search($a,plus($t,1)) endif endif
    function landingTime($a in Airplane) = search($a,0)
    function canBeMovedUp($airplane in Airplane, $nMov in TimeSlot) = let($currentLT=landingTime($airplane)) in if le(plus($currentLT,$nMov),45) then if neq(landingSequence(plus($currentLT,$nMov)),undef) then false else if le(plus(plus($currentLT,$nMov),1),45) then if neq(landingSequence(plus(plus($currentLT,$nMov),1)),undef) then false else if le(plus(plus($currentLT,$nMov),2),45) then if neq(landingSequence(plus(plus($currentLT,$nMov),2)),undef) then false else if le(plus(plus($currentLT,$nMov),3),45) then if neq(landingSequence(plus(plus($currentLT,$nMov),3)),undef) then false else true endif endif endif endif endif endif endif endif endlet
    function canBeMovedDown($airplane in Airplane, $nMov in TimeSlot) = let($currentLT=landingTime($airplane)) in if ge(minus($currentLT,$nMov),0) then if neq(landingSequence(minus($currentLT,$nMov)),undef) then false else if ge(minus(minus($currentLT,$nMov),1),0) then if neq(landingSequence(minus(minus($currentLT,$nMov),1)),undef) then false else if ge(minus(minus($currentLT,$nMov),2),0) then if neq(landingSequence(minus(minus($currentLT,$nMov),2)),undef) then false else if ge(minus(minus($currentLT,$nMov),3),0) then if neq(landingSequence(minus(minus($currentLT,$nMov),3)),undef) then false else true endif else true endif endif else true endif endif else true endif endif endif endlet

    macro rule r_moveUp($a in Airplane, $manual in Boolean, $nMov in TimeSlot) =
        let ($currentLT = landingTime($a)) in
            if neq($currentLT,undef) then
                if and(and(lt($currentLT,zoomValue),not(blocked(plus($currentLT,$nMov)))),canBeMovedUp($a,$nMov)) then
                    par
                        landingSequence(plus($currentLT,$nMov)) := $a
                        landingSequence($currentLT) := undef
                        landingSequenceColor(plus($currentLT,$nMov)) := landingSequenceColor($currentLT)
                        landingSequenceColor($currentLT) := WHITE
                    endpar
                endif
            endif
        endlet

    macro rule r_moveDown($a in Airplane, $manual in Boolean, $nMov in TimeSlot) =
        let ($currentLT = landingTime($a)) in
            if neq($currentLT,undef) then
                if and(le($currentLT,0),not($manual)) then
                    par
                        landingSequence($currentLT) := undef
                        landingSequenceColor($currentLT) := WHITE
                    endpar
                else 
                    if and(and(ge(minus($currentLT,$nMov),0),not(blocked(minus($currentLT,$nMov)))),not($manual)) then
                        par
                            landingSequence(minus($currentLT,$nMov)) := $a
                            landingSequence($currentLT) := undef
                            landingSequenceColor(minus($currentLT,$nMov)) := landingSequenceColor($currentLT)
                            landingSequenceColor($currentLT) := WHITE
                        endpar
                    else 
                        if and(and(gt($currentLT,0),not(blocked(minus($currentLT,$nMov)))),canBeMovedDown($a,$nMov)) then
                            par
                                landingSequence(minus($currentLT,$nMov)) := $a
                                landingSequence($currentLT) := undef
                                landingSequenceColor(minus($currentLT,$nMov)) := landingSequenceColor($currentLT)
                                landingSequenceColor($currentLT) := WHITE
                            endpar
                        endif
                    endif
                endif
            endif
        endlet

    macro rule r_hold($a in Airplane) =
        let ($currentLT = landingTime($a)) in
            if neq($currentLT,undef) then
                par
                    landingSequence($currentLT) := undef
                    landingSequenceColor($currentLT) := WHITE
                endpar
            endif
        endlet

    macro rule r_update_zoom =
        if lt(zoom,15) then
            zoomValue := 15
        else 
            if gt(zoom,45) then
                zoomValue := 45
            else 
                if eq(mod(zoom,5),0) then
                    zoomValue := zoom
                endif
            endif
        endif

    macro rule r_update_lock =
        if neq(timeToLock,undef) then
            if eq(landingSequence(timeToLock),undef) then
                blocked(timeToLock) := not(blocked(timeToLock))
            endif
        endif


// this ASM has no main, FunctionInitialization ignored
