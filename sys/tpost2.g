; tpost2.g
; Called after activating T2

M106 R2           ; restore print cooling fan speed
M116 P2 ; wait for tool 2 heaters to reach operating temperature
M83 ; relative extruder movement
M567 P2 E1:1 ; set tool mix ratio
M568 P2 S1 ; turn on mixing
if heat.heaters[1].current >= (heat.heaters[1].active-5) && heat.heaters[2].current >= (heat.heaters[2].active-5) && heat.heaters[1].current >= 200 && heat.heaters[2].current >= 200
	G1 E3 F3600 ; extrude 3mm from both extruders