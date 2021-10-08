if !move.axes[0].homed
  G28 X
if !move.axes[3].homed
  G28 U  
  
G1 X-190 U125 F6000
while true
	if mod(iterations,2) == 0
		G1 X-210 U165 F6000
	else
		G1 X-190 U145 F6000
	if iterations >= 10
		break	
; end loop
G1 X-999 U999 F6000