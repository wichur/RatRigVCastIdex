if !move.axes[0].homed
  G28 X
  
G1 X-190 F6000
while true
	if mod(iterations,2) == 0
		G1 X-210 F6000
	else
		G1 X-190 F6000
	if iterations >= 10
		break	
; end loop
G1 X-999 F6000