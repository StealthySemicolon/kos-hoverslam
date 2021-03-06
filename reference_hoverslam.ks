clearscreen.
set radarOffset to 14.
lock trueRadar to alt:radar - radarOffset.			// Offset radar to get distance from gear to ground
lock g to constant:g * body:mass / body:radius^2.		// Gravity (m/s^2)
lock maxDecel to (ship:availablethrust / ship:mass) - g.	// Maximum deceleration possible (m/s^2)
lock stopDist to ship:verticalspeed^2 / (2 * maxDecel).		// The distance the burn will require
lock idealThrottle to stopDist / trueRadar.			// Throttle required for perfect hoverslam
lock impactTime to trueRadar / abs(ship:verticalspeed).		// Time until impact, used for landing gear
set runMode to 0.

set steer to up.
set thrott to 0.0.

lock throttle to thrott.
lock steering to steer.

ag1 on.

WAIT UNTIL ship:verticalspeed < -1.
UNTIL ship:verticalspeed>-0.05{
    print (trueRadar - stopDist) at (10, 4).
    print (idealThrottle) at (10, 5).
    print (ship:geoposition) at (10, 6).
    print (runMode) at (10, 6).

    if trueRadar < stopDist-100{
        set runMode to 1.
        set steer to srfRetrograde.
    }
    if runMode = 1{
        set thrott to idealThrottle.
        set steer to srfretrograde.
    }
    else{
        unlock throttle.
        unlock steering.
    }
}
unlock all.
