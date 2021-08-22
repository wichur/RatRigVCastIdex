; PARAMETERS
var currentToolIndex = param.T				
var currentHeaterTemperature = param.S
var currentFilamentName = param.N

M291 P{"Heating nozzle T" ^ var.currentToolIndex ^ " to " ^ var.currentHeaterTemperature} R{"Loading " ^ var.currentFilamentName} T5  ; Display message
G10 S{var.currentHeaterTemperature} T{var.currentToolIndex}	; Heat up the current tool
M116 ; Wait for the temperatures to be reached
	
M291 P"Retracting filament" R{"Unloading " ^ var.currentFilamentName} T5 ; Display another message

G0 E-5 F3600        ;extract filament to cold end area 
G4 S3                     ;wait for three seconds
G0 E5 F3600         ;push back the filament to smash any stringing 
G0 E-15 F3600      ;Extract back fast in the cold zone 
G0 E-90 F300        ;Continue extraction slowly, allow the filament time to cool solid before it reaches the gears
G10 S0 T{var.currentToolIndex}	; Turn off heater
M400 ; Wait for the moves to finish

M292 ; Hide the message again
M291 P{"T" ^ var.currentToolIndex ^ " unloaded"} R"Cleanup nozzle" T5 ; Display another message

; DOCUMENTATION
; Orbiter setup https://www.youtube.com/watch?v=C-ebKlD9tyA