; bed.g
; Called on G32 to tram the gantry to the bed

; Park U if not at endstop
;if !sensors.endstops[3].triggered
;    G1 U400 F6000													; make sure U is parked

if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed ;home if not homed
  G28

while true
	if iterations = 10
		abort "Too many auto calibration attempts"
	G30 P0 X95 Y0 Z-99999 											    ; probe near a RIGHT leadscrew, half way along Y axis
	if result != 0
		continue
	G30 P1 X-165 Y0 Z-99999 S2 											; probe near a LEFT leadscrew and calibrate 2 motors
	if result != 0
		continue	
	if move.calibration.initial.deviation <= 0.003
		break
	echo "Repeating calibration because deviation is too high (" ^ move.calibration.initial.deviation ^ "mm)"
; end loop

echo "Auto calibration successful, deviation", move.calibration.final.deviation ^ "mm"