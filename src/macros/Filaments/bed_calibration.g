T0
M104 S130                             ; set extruder temp
M140 S55                       ; set bed temp                                                        
M109 S130                             ; wait for extruder temp
M190 S55                       ; wait for bed temp

M98 P"/macros/gantry_leveling.g"
M98 P"/macros/bed_leveling.g" 21

G1 X0 Y999 F6000 ; position for adjustment

M104 S0                             ; set extruder temp
M140 S0                       ; set bed temp                                                        