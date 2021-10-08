M557 X{global.bed_probe_x_min}:{global.bed_probe_x_max} Y{global.bed_probe_y_min}:{global.bed_probe_y_max} P2  

G28								; Home
G29 S0							; Probe, save and activate
G1 Z50 F6000 H2					; Move out

M557 X{global.bed_probe_x_min}:{global.bed_probe_x_max} Y{global.bed_probe_y_min}:{global.bed_probe_y_max} P12  