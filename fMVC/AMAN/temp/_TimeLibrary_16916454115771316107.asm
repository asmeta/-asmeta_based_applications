// translation of the asm (for avalla) file:///D:/AgHome/progettidaSVNGIT/asmeta/asmeta_based_applications/fMVC/AMAN/model/TimeLibrary.asm
module _TimeLibrary_16916454115771316107
import D:\\AgHome\\progettidaSVNGIT\\asmeta\\asmeta_based_applications\\fMVC\\AMAN\\model\\StandardLibrary
export *

signature:
    abstract domain Timer

    controlled start: Timer -> Real
    controlled duration: Timer -> Real
    derived currentTime: Timer -> Real
    derived expired: Timer -> Boolean
    // Auto_increment time: keep function monitored
    monitored mCurrTimeSecs: Real

definitions:

    function currentTime($t in Timer) = mCurrTimeSecs
    function expired($t in Timer) = ge(currentTime($t),plus(start($t),duration($t)))

    macro rule r_reset_timer($t in Timer) =
        start($t) := currentTime($t)

    macro rule r_set_duration($t in Timer, $ms in Real) =
        duration($t) := $ms


// this ASM has no main, FunctionInitialization ignored
