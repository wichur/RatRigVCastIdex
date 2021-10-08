; probe_repeatability.g
; Macro used to test the repeatability of the Z-Probe
;

G28

M558 A1 F120												; Set Z-probe to a maximum of 1 probe at 120mm/min dive speed
G1 Z30 F6000												; Raise Z to clear the bed
M291 P"Probe will be tested 10 times and return mean and standard deviation. Ok or Cancel?" R"WARNING" S3 ; User must click OK or cancel.

M401
G30 P0 X0 Y0 Z-9999
G30 P1 X0 Y0 Z-9999
G30 P2 X0 Y0 Z-9999
G30 P3 X0 Y0 Z-9999
G30 P4 X0 Y0 Z-9999
G30 P5 X0 Y0 Z-9999
G30 P6 X0 Y0 Z-9999
G30 P7 X0 Y0 Z-9999
G30 P8 X0 Y0 Z-9999
G30 P9 X0 Y0 Z-9999 S-1
M402