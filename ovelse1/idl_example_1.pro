; pro idl_example_1
; Astronomy 4L IDL example 1
; how to read a table, print it on screen and in new file, and make a plot

device, decomposed = 0, retain=2
col=getcolor(/load)  ; get color table for plot
; type   help,col,/str         to see color table

close,1 ; to be sure that output file is closed 
        ; (could be open if prev. run failed)

f = 'example_1.tab'   ; input table

readcol,f,r,lrho,kappa,format='f,f,f'   ;read table 'example_1.tab'

n = n_elements(r)
print,'number of lines in table: ',n

; print table to screen
print,'     r/R           log(rho)     kappa'
print,transpose([[r],[lrho],[kappa]])

;print table to file
openw,1,'example_1.out'
printf,1,'   r/R  og(rho)     kappa'
printf,1,transpose([[r],[lrho],[kappa]]),form='(f6.3,f9.3,f10.2)'
close,1

; rest of program runs twice, first plot on screen then .ps file

; for print on screen
set_plot, 'X'
window, 0, xsize=500, ysize=0800, title='example_1'
!p.multi = [0,1,2]      ; to get 2 plots in one window / at one page
ynps = 'n'

; for .ps file
labps:
if ynps eq 'y' then begin
set_plot, 'ps'
device, filename='example_1.ps', ysize = 25.0, yoffset=2.0
device,/color
endif


farve=intarr(n)
farve=col.blue     ; used for points to plot

; for information (see oplot below)
;  psym     symbol
;  1        plus
;  2        asterisk
;  3        period
;  4        diamond
;  5        triangle
;  6        square
;  7        X
;  8        user-defined (usersym procedure)
;  NB  - before psym value adds line between points

rmin=min(r) & rmax=max(r) ; get min/max values
lrhomin=min(lrho) & lrhomax=max(lrho)
plot,[1000],[1000],xr=[rmin-0.1,rmax+0.1],yr=[lrhomin-0.1,lrhomax+0.1] $
    , thick = 2.0 $
    , xthick = 2.0 $
    , ythick = 2.0 $
    , charthick = 2.0 $
    , yminor = 2 $
    , ytickformat='(f6.3)' $
    , xstyle=1 $     ; = 2 useful also, as substitute for x/yrange
    , ystyle = 1 $
    , charsize = 1.75 $
;   , title='log(rho) versus r'$   ; normal
    , title='log(!4q!3)' $         ; to get greek letter
    , xtitle='r' $
    , ytitle='log(rho)' $
    , background = col.white, col=col.black
oplot,r,lrho,psym=1,col=farve,thick=2.0,symsize=1.5

; new color for points
farve = col.green

; note change in thick and symsize
plot,[1000],[1000],xr=[rmin-0.1,rmax+0.1],yr=[0,1.05*max(alog10(kappa))] $
    , thick = 1.0 $
    , xthick = 1.0 $
    , ythick = 1.0 $
    , charthick = 1.0 $
    , yminor = 4 $
    , ytickformat='(f10.2)' $
    , xstyle=1 $
    , ystyle = 1 $
    , charsize = 1.75 $
;   , title='log(kappa) versus r'$   ; normal
    , title='log(!4j!3)' $           ; to get greek letter
    , xtitle='r' $
    , ytitle='log(kappa)' $
    , background = col.white, col=col.red  
oplot,r,alog10(kappa),psym=-6,col=farve,thick=1.0,symsize=1.0 
; note psym=-6 (with line)

; check if this was screen or .ps
if ynps eq 'n' then begin
ynps='y'
goto,labps
endif
if ynps eq 'y' then begin
device,/close      ; close .ps file
ynps='n'
endif

set_plot, 'X'   ; to avoid error at leo2 from the line device, decomposed = 0 
print,'program completed'

end
