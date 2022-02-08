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


PRO imp_cal, red, grn, blu, t, temp, title

; write out the raw image in true color
write_true_color, red, grn, blu, title+'_raw'

; -------------- Bad pixel correction --------------

;create a new image for each channel (r/g/b) that has bad pixels replaced 
;with the median of their surroundings
val = 3   ; defines the width of the median 
sig = 2   ; defines the cut off for bad pixels (*STDEV)
red_nobad = replace_bad_pixels(red, val, sig)
grn_nobad = replace_bad_pixels(grn, val, sig)
blu_nobad = replace_bad_pixels(blu, val, sig)

; write out nobadpixels RGB image in true color
write_true_color, red_nobad, grn_nobad, blu_nobad, title+'_nobadpixels'
save, red_nobad, grn_nobad, blu_nobad, filename=(title+'_nobad.sav')
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

dn_dark_red = Ad*t[0]*exp(temp[0]*Bd) * D + 4000.00*As*exp(temp[0]*Bs) * S + An* exp(temp[0]*Bn) + Hoff
dn_dark_grn = Ad*t[1]*exp(temp[1]*Bd) * D + 4000.00*As*exp(temp[1]*Bs) * S + An* exp(temp[1]*Bn) + Hoff
dn_dark_blu = Ad*t[2]*exp(temp[2]*Bd) * D + 4000.00*As*exp(temp[2]*Bs) * S + An* exp(temp[2]*Bn) + Hoff

; create nodark images by subtracting the dark current model from nobadpixels
red_nodark = red_nobad - dn_dark_red
grn_nodark = grn_nobad - dn_dark_grn
blu_nodark = blu_nobad - dn_dark_blu

; write out the nodark RGB image in true color
write_true_color, red_nodark, grn_nodark, blu_nodark, title+'_nodark'

save, red_nodark, grn_nodark, blu_nodark, filename=title+'_nodark.sav'
; -------------- Flat Field Correction --------------

; create noflat images by dividing by the flatfield images
red_noflat = red_nodark/ff_red
grn_noflat = grn_nodark/ff_grn
blu_noflat = blu_nodark/ff_blu

; write out noflat RGB image in true color
write_true_color, red_noflat, grn_noflat, blu_noflat, title+'_noflat'
save, red_noflat, grn_noflat, blu_noflat, filename=(title+'_noflat.sav')

; -------------- Responsivity Correction --------------
A1 = [557.3, 578.6, 117.6]
A2 = [-0.575,-0.893, -0.392]
A3 = [-0.0014, -0.002, -0.0006]
; Calculate responsivity for each filter (RGB) at input temperature
R_red = A1[0] + A2[0]*temp[0] + A3[0]*temp[0]^2
R_grn = A1[1] + A2[1]*temp[1] + A3[1]*temp[1]^2
R_blu = A1[2] + A2[2]*temp[2] + A3[2]*temp[2]^2

; create final images by dividing by the responsivty and time
red_calib = red_noflat/t[0]/R_red
grn_calib = grn_noflat/t[1]/R_grn
blu_calib = blu_noflat/t[2]/R_blu

write_true_color, red_calib, grn_calib, blu_calib, title+'final'
save, red_calib, grn_calib, blu_calib, filename=(title+'_final.sav')

; write out final RGB image in true color (yay!)



END