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


FUNCTION replace_bad_pixels, img, val, sigma

  ; calculate the median image from the raw image
  img_med = median(img, val)
  
  ; calculate a difference image
  img_diff = abs(img- img_med)
   
  ; determine what the cutoff for “bad” is based on the difference image
  print, stdev(juno_diff)
  
  ; use “where” to create an array with the locations of the bad pixels
  bad_pixels = where(img_diff gt sigma*stdev(img_diff))
  
  ; print to the screen how many bad pixels were found
  print, n_elements(bad_pixels)
  print, n_elements(img)/n_elements(bad_pixels)
  
  ; create a new image that is initially a copy of the old image (e.g., img_nobad)
  img_nobad = img
  
  ; replace the bad pixels in this image with values from the median image
  img_nobad[bad_pixels]=img_med[bad_pixels]
  
  ; return the corrected image
  return, img_nobad


END