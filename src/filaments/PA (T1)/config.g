;PA12

;M207 S0.9 R0.0 F3000 T3000 Z0.0 ; firmware retraction settings for PETG
M307 H0 B0 R0.915 C143.0 D2.91 S1.00 V24.0         ; Bed PID tune for 100C
M307 H2 B0 R3.044 C195.0 D4.94 S1.00 V23.7        ; Hot end PID tune at 280c
;M566 X1200 Y1200 Z60 E3000        ; jerk settings for PETG
;M204 P1000 T4000                    ; Set printing and travel accelerations