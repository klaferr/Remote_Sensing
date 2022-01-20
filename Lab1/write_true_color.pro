PRO write_true_color, red, grn, blu, filename

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
minv = 0.
maxv = max([red, blu, grn])

mr =  bytscl(red, min=minv, max=maxv)
mg =  bytscl(grn, min=minv, max=maxv)
mb =  bytscl(blu, min=minv, max=maxv)

window, 0, xsize=460, ysize=460, title='HST Mars 2001/05/13'
tv, mr, channel=1
tv, mg, channel=2
tv, mb, channel=3
erase

tv, [[[mr]], [[mg]], [[mb]]], true=3
tiff_write, filename+'.tif', red=mr, green=mg, blue=mb, planarconfig=2
print, 'Created RGB image: ' + filename
END
