
M557 X{global.bed_probe_x_min}:{global.bed_probe_x_max} Y{global.bed_probe_y_min}:{global.bed_probe_y_max} P9  

T0

G28
M98 P"/macros/gantry_leveling.g"      ; make sure that X is levelled

G28					; Home
G29 S0				; Probe, save and activate

G1 X0 Y999 F6000 ; position for adjustment

M557 X{global.bed_probe_x_min}:{global.bed_probe_x_max} Y{global.bed_probe_y_min}:{global.bed_probe_y_max} P2
	