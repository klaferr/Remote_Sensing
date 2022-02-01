; 
 
; imp_cal.pro
; 
; Created by Kris Laferriere on Feb 1, 2022
; 
; Purpose: To calibrate images from the Imager for Mars Pathfinder camera (IMP). 
;          Includes bad pixel correction, dark current subtraction, flat field correction, 
;          and responsivity correction.
;          
; Inputs: red, grn, blu = names of images to be corrected (requires all three). 
;         Calibration data (imp_cal.sav) must also be in working directory.
;         
; Outputs: writes images files at each step to working directory


PRO imp_cal, red, grn, blu, t, temp

; write out the raw image in true color
write_true_color, red, grn, blu, 'raw'

; -------------- Bad pixel correction --------------

;create a new image for each channel (r/g/b) that has bad pixels replaced 
;with the median of their surroundings
val = 3   ; defines the width of the median 
sig = 2   ; defines the cut off for bad pixels (*STDEV)
red_nobad = replace_bad_pixels(red, val, sig)
grn_nobad = replace_bad_pixels(grn, val, sig)
blu_nobad = replace_bad_pixels(blu, val, sig)

; write out nobadpixels RGB image in true color
write_true_color, red_nobad, grn_nobad, blu_nobad, 'nobadpixels'

; -------------- Dark Current Subtraction --------------

; restore the calibration data
restore, 'lab3_cal.sav'

; create dark current model (the formula defined in the lab instructions)
D = dark_lab
S = shutter_lab
; For IMP instrument
Hoff = 8.27
Ad = 3.016
Bd = 0.105
As = 2.845
Bs = 0.105
An = 4.05
Bn = 0.144

dn_dark = Ad*t*exp(temp*Bd) * D + 4000*As*exp(temp*Bs) * S + An* exp(temp*Bn) + Hoff

; create nodark images by subtracting the dark current model from nobadpixels
red_nodark = red_nobad - dn_dark[0]
grn_nodark = grn_nobad - dn_dark[1]
blu_nodark = blu_nobad - dn_dark[2]

; write out the nodark RGB image in true color
write_true_color, red_nodark, grn_nodark, blu_nodark, 'nodark'


; -------------- Flat Field Correction --------------

; create noflat images by dividing by the flatfield images


; write out noflat RGB image in true color


; -------------- Responsivity Correction --------------

; Calculate responsivity for each filter (RGB) at input temperature


; create final images by dividing by the responsivty and time


; write out final RGB image in true color (yay!)



END