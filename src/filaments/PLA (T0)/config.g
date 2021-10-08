;PLA

;M207 S0.9 R0.0 F3000 T3000 Z0.0 ; firmware retraction settings for PETG
M307 H0 B0 R0.923 C589.5 D4.41 S1.00 V24.0         ; Bed PID tune for 55C
M307 H1 B0 R3.366 C172.7:133.4 D4.91 S1.00 V23.7        ; Hot end PID tune at 280c
;M566 X1200 Y1200 Z60 E3000        ; jerk settings for PETG
;M204 P1000 T4000                    ; Set printing and travel accelerations