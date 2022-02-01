; 
; FIRST: RENAME THIS FILE imp_cal.pro AND REMOVE THIS LINE
; 
; imp_cal.pro
; 
; Created by <<your name here>> on <<date>>
; 
; Purpose: To calibrate images from the Imager for Mars Pathfinder camera (IMP). 
;          Includes bad pixel correction, dark current subtraction, flat field correction, 
;          and responsivity correction.
;          
; Inputs: red, grn, blu = names of images to be corrected (requires all three). 
;         Calibration data (imp_cal.sav) must also be in working directory.
;         
; Outputs: writes images files at each step to working directory


PRO imp_cal, red, grn, blu

; write out the raw image in true color


; -------------- Bad pixel correction --------------

;create a new image for each channel (r/g/b) that has bad pixels replaced 
;with the median of their surroundings


; write out nobadpixels RGB image in true color


; -------------- Dark Current Subtraction --------------

; restore the calibration data


; create dark current model (the formula defined in the lab instructions)


; create nodark images by subtracting the dark current model from nobadpixels


; write out the nodark RGB image in true color


; -------------- Flat Field Correction --------------

; create noflat images by dividing by the flatfield images


; write out noflat RGB image in true color


; -------------- Responsivity Correction --------------

; Calculate responsivity for each filter (RGB) at input temperature


; create final images by dividing by the responsivty and time


; write out final RGB image in true color (yay!)



END