M557 X{global.bed_probe_x_min}:{global.bed_probe_x_max} Y{global.bed_probe_y_min}:{global.bed_probe_y_max} P4  

G28					; Home Z
G29 S0				; Probe, save and activate

M557 X{global.bed_probe_x_min}:{global.bed_probe_x_max} Y{global.bed_probe_y_min}:{global.bed_probe_y_max} P12
	