PRO write_false_color, red, grn, blu, filename, stretch

; write_color_tiff.pro
;
; Created by <<your name here>> on <<date>>
;
; Purpose: To output a color tiff image from a set of RGB images
;
; Inputs: red, grn, blu = names of images to be combined (requires all three).
;         filename = string containing desired filename
; Outputs: writes image file to working directory
;
IF stretch eq 'linear' THEN BEGIN
  mr =  bytscl(red, min=min(red), max=max(red))
  mg =  bytscl(grn, min=min(grn), max=max(grn))
  mb =  bytscl(blu, min=min(blu), max=max(blu))
END

IF stretch eq 'linear2' THEN BEGIN
  mr =  bytscl(red, min=0.02*max(red), max=0.98*max(red))
  mg =  bytscl(grn, min=0.02*max(grn), max=0.98*max(grn))
  mb =  bytscl(blu, min=0.02*max(blu), max=0.98*max(blu))
END

IF stretch eq 'sqrt' THEN BEGIN
  mr =  bytscl(red, min=min(sqrt(red)), max=max(sqrt(red)))
  mg =  bytscl(grn, min=min(sqrt(grn)), max=max(sqrt(grn)))
  mb =  bytscl(blu, min=min(sqrt(blu)), max=max(sqrt(blu)))
END

IF stretch eq 'log' THEN BEGIN
  mr =  bytscl(red, min=min(alog(red)), max=max(alog(red)))
  mg =  bytscl(grn, min=min(alog(grn)), max=max(alog(grn)))
  mb =  bytscl(blu, min=min(alog(blu)), max=max(alog(blu)))
END

window, 0, xsize=460, ysize=460, title='HST Mars 2001/05/13'
tv, mr, channel=1
tv, mg, channel=2
tv, mb, channel=3
erase

tv, [[[mr]], [[mg]], [[mb]]], true=3
tiff_write, filename+'.tif', red=mr, green=mg, blue=mb, planarconfig=2
print, 'Created RGB image: ' + filename
END
