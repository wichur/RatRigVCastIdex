if !move.axes[3].homed
  G28 U
  
G1 U125 F6000
while true
	if mod(iterations,2) == 0
		G1 U165 F6000
	else
		G1 U145 F6000
	if iterations >= 10
		break	
; end loop
G1 U999 F6000