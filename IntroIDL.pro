; This is the intro tutorial for IDL
; Jan 13, 2022 
PRO Lab1
; hold the line open
; $

; make an array of zeros of size (1, 100)
a = fltarr(100)
; array of of two dim (3, 7)
z = fltarr(3, 7)

; array of zero to max in steps of 1 (int)
a = indgen(10)

; make an array from 0-99 in steps of 1 (floating)
b = findgen(100)

; index an array 
print, b[10:20]

; for loop 0-99
for n=0, 99 do print, n, b[n]

; need a floating point number for division
c = sin(b/5.)

; pi
print, !pi

; deg to rad
!dtor

; cancel run
; ctrl-c

; kill
; .reset

; save variables
save, a, b, filename='tutorial_ab.sav'

save, /all, filename='IDL_Session_JAN13.sav'

; plotting basics

; plot c vs b with data symbol 7
;plot, b, c, psym=7, $

; x and y range
;xrange=[0.3, 3.2], yrange=[0, 0.4], $
  
; x and y style - override auto ranges
;/xs, /xstyle, /ys, /ystyle

; x and y axis labels
;xtitle='text' $
;ytitle='text' $
; title
;title='text'

; overlay plots
;oplot, x, y

; example plot
restore, 'jgr_mars.sav' & help
plot, x_bright, y_bright, psym=7, xrange=[0.3, 3.2], yrange=[0, 0.4], $
/xs, /ys, xtitle='Wavelength ($\mu$ M)', ytitle='Reflectance', $
title='Typical Bright and Dark Regions on Mars'
oplot, x_dark, y_dark, psym=4
oplot, x_bright, y_bright
oplot, x_dark, y_dark, linestyle=2
oplot, x_dark, y_dark

; < and > operators
print, 4 < 7
plot a <1>(-1) ; set the range -1 to +1

; Where
a = indgen(5) + 8 & for n = 0,4 do print, n, a(n)
indices = where(a gt 10)

; Writing a file
openw, 1, 'name.dat'
;printf, 1, original, original_2 ; writes the data to 1
; better to do as columns with for loop
for n = 0, 199 do printf, 1, n, original[n], original_2[n]
close, 1

; want it to look different? use format

; want to read in? 
readcol, 'name.txt', a, b, c
; wait, that doesnt work

; use
openr, lun, 'file.txt', /GET_LUN
array = ''
line =''
while not eof(lun) do begin & readf, lun, line & array=[carray, line] & $
  endwhile
  
  FREE_LUN, lun




END
