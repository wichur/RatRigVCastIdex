G90 			; Absolute positioning
G1 X-157 Y-165 F6000 	; Move to front left corner
M400 			; clear movement buffer
M116 			; Wait for temps
G1 Z0.3 F100		; Move Z to prime height
G91 			; Relative positioning
M83 			; Relative extrusion
G1 X40 E10 F300 	; Prime nozzle
G10			; Retract
G1 Y-1 X1 F10000 	; Wipe nozzle
M400