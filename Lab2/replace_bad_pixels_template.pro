; 
; FIRST: RENAME THIS FILE replace_bad_pixels.pro AND REMOVE THIS LINE
; 
; replace_bad_pixels.pro
; 
; Created by <<your name here>> on <<date>>
; 
; Purpose: To replace "bad" pixels in an image with the local median 
;          
; Inputs: img
;         
; Outputs: img_nobad
;
; Example of use: juno_nobad = replace_bad_pixels(juno_red)


FUNCTION replace_bad_pixels, img

  ; calculate the median image from the raw image
  
  
  ; calculate a difference image
   
   
  ; determine what the cutoff for “bad” is based on the difference image
  
  
  ; use “where” to create an array with the locations of the bad pixels
  
  
  ; print to the screen how many bad pixels were found
  
  
  ; create a new image that is initially a copy of the old image (e.g., img_nobad)
  
  
  ; replace the bad pixels in this image with values from the median image
  
  
  ; return the corrected image
  return, img_nobad


END