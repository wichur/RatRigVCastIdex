; PARAMETERS
var currentToolIndex = param.T
var currentHeaterTemperature = param.S
var currentFilamentName = param.N

M291 P{"Heating nozzle T" ^ var.currentToolIndex ^ " to " ^ var.currentHeaterTemperature} R{"Loading " ^ var.currentFilamentName T5  ; Display message
G10 S{var.currentHeaterTemperature} T{var.currentToolIndex}	; Heat up the current tool
M116                                                           ; Wait for the temperatures to be reached
M291 P"Feeding filament." R{"Loading " ^ var.currentFilamentName}" T5             ; Display new message
M83                                                            ; Extruder to relative mode
G1 E350 F300                                                   ; Feed 350mm of filament at 300mm/min
G4 P1000                                                       ; Wait one second
G1 E-5 F1800                                                   ; Retract 10mm of filament at 1800mm/min
M400                                                           ; Wait for moves to complete
M292                                                           ; Hide the message
G10 S0 T{var.currentToolIndex}	; Turn off heater
M291 P{"T" ^ var.currentToolIndex ^ " loaded"} R"Cleanup nozzle" T5 ; Display another message