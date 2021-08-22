; Configuration file for Duet 3 (firmware version 3)
; executed by the firmware on start-up

; General preferences
	G90                                          		; send absolute coordinates...
	M83                                          		; ...but relative extruder moves
	M550 P"Czardasz"                             		; set printer name
	G4 S1   								     		; wait for expansion boards to start
	
; Load Global Variables
	M98 P"/sys/variables.g"

; Network
	M552 P0.0.0.0 S1                             		; enable network and acquire dynamic address via DHCP
	M586 P0 S1                                   		; enable HTTP
	M586 P1 S1                                   		; enable FTP
	M586 P2 S0                                   		; disable Telnet

; Drives
	; Mappings
		; MCU is 0.A
		; Toolboards are AA.B
		M569 P0.0 D3 S0 V1000                                	; physical drive 0.0 goes backwards X
		M569 P0.1 D3 S0 V1000                               	; physical drive 0.1 goes backwards U
		M569 P0.2 D3 S0 V1000                                	; physical drive 0.2 goes backwards Y
		M569 P0.3 D3 S1 V1000                               	; physical drive 0.3 goes forwards ZLeft
		M569 P0.4 D3 S1 V1000                                	; physical drive 0.4 goes forwards ZRight
		M569 P20.0 D3 S1 V1000                                	; physical drive 20.0 goes forwards
		M569 P21.0 S1                              	; physical drive 21.0 goes forwards
		M584 X0.0 U0.1 Y0.2 Z0.3:0.4 E20.0:21.0         ; set drive mapping		
	; Currents
		M906 X2125 U2125 Y2000 Z1600:1600 E350:350 I50  ; set motor currents (mA) and motor idle factor in per cent (50-80% of rated current)	
		;M906 X1600 U1600 Y1600 Z1600:1600 E350:350 I50
		M84 X0 U3 Y1 S30                                ; Set idle timeout
		; TODO: Review M84 for validity
	; Steps
		M350 X16 U16 Y16 Z16:16 E16:16 I1                   				; configure microstepping with interpolation
		M92 X80.0630 U80.0630 Y80.0755 Z393.0294:393.0294 E694.44:694.44			; set steps per mm (E700 measured or E600 from datatsheet)
		; TODO: Calibrate both E and pick right value by comparing prints
	; Speeds and Accelerations
		M566 X800.00 U800.00 Y650.00 Z60:60 E300:300        				; set maximum instantaneous speed changes (mm/min)
		M203 X12000.00 U12000.00 Y12000.00 Z1800.00:1800.00 E3600:3600		; set maximum speeds (mm/min)
		M201 X900.00 U900.00 Y700.00 Z30.00:30.00 E600:600              	; set accelerations (mm/s^2)	

; Axis Limits 
	; 0,0 is in the center of printable area
	M208 S1 X-220 U-161.5 Y-190 							; set axis lower limits
	M208 S0 X125 U173.5 Y155 Z265   						; set axis upper limits
	M671 X-265:260 Y-30:-30 S4	 						; leadscrews at left (connected to Z) and right (connected to E1) of X axis
	; TODO: Validate if lead screw positions are correct

; Endstops
	M574 X1 P" io3.in" S1                              	; active-low endstop for low end on X via pin io3.in
	M574 U2 P" io2.in" S1							   	; active-low endstop for high end on U via pin io2.in  
	M574 Y1 P" io1.in" S1		  					   	; active-low endstop for low end on Y via pin io1.in
	; TODO: Add and map two top endstops for Z. Can it work?
	; TODO: Use Stall Detection to create crash-detection fail-safe behavior
	
; Bed (H0)
	M308 S0 P"temp0" Y"thermistor" T100000 B3950 A"Bed" ; configure sensor 0 as thermistor on pin temp0
	M950 H0 C"out0" T0                                  ; create bed heater output on out0 and map it to sensor 0
	M307 H0 B0 S1.00                                    ; disable bang-bang mode for the bed heater and set PWM limit
	M140 H0                                             ; map heated bed to heater 0
	M143 H0 S120                                        ; set temperature limit for heater 0 to 120C
	M307 H0 B0 R0.935 C574.7 D4.33 S1.00				; PID tuning from M303 H0 S60

; Toolboard at 20 (X H1 F0 F1 TOOL_X)
	; Heater 1
		; Generic 70W heater
		M308 S1 P"20.temp0" Y"pt1000" A"Heater X"		; configure sensor 1 as PT1000 on pin 121.temp0
		M950 H1 C"20.out0" T1                               ; create nozzle heater output on 121.out0 and map it to sensor 1
		M307 H1 B0 S1.00                                    ; disable bang-bang mode for heater and set PWM limit
		M143 H1 S300                                        ; set temperature limit for heater 1 to 300C
		M307 H1 B0 R3.567 C159.3:110.3 D4.89 S1.00 V24.0    ; PID tuning from M303 T0 S205 (0.5mm from bed at 60C)		
		; TODO: Can I use filament .g files to have differet PID tuning outcomes defined for temp pairs?
	; Fans
		; Print Fan (0)
	  		M950 F0 C"20.out1" Q25                    	; create fan 0 on pin 121.out1 and set its frequency
	  		M106 P0 S0 H-1 X1                           	; set fan 0 value. Thermostatic control is turned off, 100% max speed
		; Hotend Fan (1)
	  		M950 F1 C"20.out2" Q500                     	; create fan 1 on pin 121.out2 and set its frequency
	  		M106 P1 S1 H1 T45                           	; set fan 1 value. Thermostatic control is turned on
	; Z-Probe
		M950 S0 C"20.io0.out"                           	; create servo pin 0 for BLTouch
		M558 P9 C"^20.io0.in" H5 F240 T24000 A5         	; set Z probe type to bltouch and the dive height + speeds
		G31 P500 X-26.3 Y-19.3 Z2.2           			; set Z probe trigger value, offset and trigger height 2.628
		M557 X-156.3:90 Y-134.3:120 P4       			; define mesh grid (2 4pt, 8 64 pt) 310x310mm
		G29 S1 												; read height map
		; TODO: Extend mesh grid to be closer to printabel area corner
	; Accelerometer
		M955 20.0 I21										; set accelerometer orientation
	  
; Toolboard at 21 (U H2 F2 F3 TOOL_U)
	; Heater 2
		; Generic 70W heater
		M308 S2 P"21.temp0" Y"pt1000" A"Heater U"			; configure sensor 2 as PT1000 on pin 121.temp1
		M950 H2 C"21.out0" T2                               ; create nozzle heater output on 122.out0 and map it to sensor 2
		M307 H2 B0 S1.00                                    ; disable bang-bang mode for heater  and set PWM limit
		M143 H2 S300                                        ; set temperature limit for heater 2 to 300C
		M307 H2 B0 R3.484 C182.5:130.0 D5.07 S1.00 V23.9    ; PID tuning from M303 T1 S205	(0.5mm from bed at 60C)
	; Fans
 		; Print Fan (2)
			M950 F2 C"21.out1" Q25                         ; create fan 2 on pin 122.out1 and set its frequency
			M106 P2 S0 H-1 X1                            ; set fan 2 value. Thermostatic control is turned off 100% max speed
		; Hotend Fan (3)
			M950 F3 C"21.out2" Q500                         ; create fan 3 on pin 122.out2 and set its frequency
			M106 P3 S1 H2 T45                               ; set fan 3 value. Thermostatic control is turned on
	
; Tool (T0 / Toolboard 22)
	M563 P0 S"TOOL_X" D0 H1 F0 X0                     	; define tool 0
	G10 P0 X0 Y0 Z0                                 	; set tool 0 axis offsets
	G10 P0 R0 S0                                    	; set initial tool 0 active and standby temperatures to 0C
	
; Tool (T1 / Toolboard 21)
	M563 P1 S"TOOL_U" D1 H2 F2 X3                       ; define tool 1
	G10 P1 X0 Y0 Z0                                     ; set tool 1 axis offsets
	G10 P1 R0 S0                                        ; set initial tool 1 active and standby temperatures to 0C		

; Tool (T2)
  M563 P2 D0:1 H1:2 X0:3 F0:2 S"TOOL_COPY" ; tool 2 uses both extruders and hot end heaters, maps X to both X and U, and uses both print cooling fans
  G10 P2 X0 Y0 U-145 S0 R0    ; set tool offsets and temperatures for tool 2
  M567 P2 E1:1               ; set mix ratio 100% on both extruders  

; ''' Create a tool that prints 2 copies of the object using both carriages'''
;M563 P2 D0:1 H1:2 X0:3 F0:2 S"copy" ; tool 2 uses both extruders, hot end heaters and fans, and maps X to both X and U
;G10 P2 X50 Y0 U-50 S0 R0 ; set tool offsets and temperatures G10 P2 X115 Y0 U-80 S0 R0///G10 P2 X100 Y0 U-100 S0 R0
;M567 P2 E1:1 ; set mix ratio 100% on both extruders

; Sensors
	M308 S20 Y"mcu-temp" A"CPU" 							; CPU temp sensor
	;M308 S21 Y"drivers" A"Duet_drv" 						; drivers temp sensor
	;M308 S4 Y"drivers" A"TMC Drivers"						; define Sensor4 as the TMC overheat sensor

; Custom Settings
	;M404 N1.75											    ; FILAMENT DIAMETER for print monitor
	;M593 P"daa" F58.8                                      ; CANCEL RINGING at 76.5Hz / F58.80 
	;M376 H2                                                ; Stop using autolevelling data after 2mm
	;M572 D0 S0.01                                          ; set PRESSURE ADVANCE for Orbiter 1.5
	; TODO: Ringing
	; TODO: Pressure Advance
	; TODO: Autolevelling Adjustment
                 
; Miscellaneous
M912 P0 S-6
M575 P1 S1 B57600											; Enable Panel Due
;T2															; Activate T0 by default
M501                                        				; Load saved parameters from non-volatile memory