; tpost0.g
; Called after activating T0

M106 R2           ; restore print cooling fan speed
M116 P0 ; wait for tool 0 heaters to reach operating temperature
M83 ; relative extruder movement

if heat.heaters[1].current >= (heat.heaters[1].active-5) && heat.heaters[1].current > 200
	G1 E3 F3600 ; extrude 2mm	