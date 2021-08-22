; tpost1.g
; Called after activating T1

M106 R2           ; restore print cooling fan speed
M116 P1 ; wait for tool 1 heaters to reach operating temperature
M83 ; relative extruder movement
if heat.heaters[2].current > (heat.heaters[2].active-5) && heat.heaters[2].current > 200
	G1 E3 F3600 ; extrude 2mm