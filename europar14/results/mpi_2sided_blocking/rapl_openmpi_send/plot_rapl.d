FILE_NAME = "`echo $FILE_NAME`"
set logscale x 2
set logscale y 2
set format x "%10.0f"
set format y "%10.0f"
set xrange [1:2097152] 
set yrange [1:2097152]
X=1 ; 
Y=2 ; 
set cbtics font "Times-Roman, 3" offset -0.5,0
set title font "Times-Roman, 4" 

unset key

set terminal pdf
set output FILE_NAME.".pdf"
#set terminal pngcairo
#set output FILE_NAME.".png"

set palette defined ( 0 "blue", 1 "green", 2 "yellow",\
        3 "orange", 4 "red", 5 "dark-red" )
set pm3d corners2color mean at st
set view map
set multiplot layout 2,2 rowsfirst scale 1,1 

set macros

USING_M = "using X:Y:Z with pm3d"

NOXTICS = "unset xtics; unset xlabel;"
XTICS = "set xtics font 'Times-Roman,3' offset \
0,-0.2,0 rotate by 90; set xlabel 'Total Message Size \
(Bytes)[Log-scale]' font 'Times-Roman,4' offset -0.8,0.7"
NOYTICS = "unset ylabel; unset ytics" 
YTICS = "set ytics font 'Times-Roman,3' offset \
0.5,0,0 ;set ylabel '#Fragments[Log-scale]' font 'Times-Roman, \
4' offset 7.5,-1,0"

TMARGIN = "set tmargin at screen 0.88; set bmargin at screen 0.60"
BMARGIN = "set tmargin at screen 0.38; set bmargin at screen 0.10"
LMARGIN = "set lmargin at screen 0.15; set rmargin at screen 0.43"
RMARGIN = "set lmargin at screen 0.55; set rmargin at screen 0.85" 

CBLABEL_POW = "set cblabel 'Power(W)[Log-scale]' font \
'Times-Roman, 3' offset -5,0 rotate by -90" 
CBLABEL_CACHE = "set cblabel '#Cache-Misses[Log-scale]' font \
'Times-Roman, 3' offset -3,0 rotate by -90"
CBLABEL_TIME = "set cblabel 'Time(secs)' font \
'Times-Roman, 3' offset -3,0 rotate by -90"

TITLE_COREPOW = "set title '(I) Cores Power (Watts)' font \
'Times-Roman, 4' offset -3,0"
TITLE_DRAMPOW = "set title '(II) DRAM Power (Watts)' font \
'Times-Roman, 4' offset -3,0"
TITLE_CACHE = "set title '(III) L3 (shared) Cache Misses' \
font 'Times-Roman, 4' offset -2,0"
TITLE_TIME = "set title '(III) Time(secs)' \
font 'Times-Roman, 4' offset -2,0"
TITLE_TOTPOW = "set title '(IV) Total Power(Watts)' font \
'Times-Roman, 4' offset -2,0"
NOTITLE = "unset title"


@TITLE_COREPOW; @CBLABEL_POW
@TMARGIN; @LMARGIN
@XTICS; @YTICS
Z=5;set log cb  1.01282; set cbrange[16:18] ;splot FILE_NAME @USING_M

@TITLE_DRAMPOW; @CBLABEL_POW
@TMARGIN; @RMARGIN
@XTICS; @YTICS
Z=7;set log cb 1.1; set cbrange[7.4:8] ;splot FILE_NAME @USING_M

#@TITLE_CACHE; @CBLABEL_CACHE
#@BMARGIN; @LMARGIN
#@XTICS; @YTICS
#Z=12;set log cb 10; set cbrange[2:232] ;splot FILE_NAME @USING_M

#set label 100 "(IV)" at 4,524288 center  
@TITLE_TOTPOW; @CBLABEL_POW
@BMARGIN; @RMARGIN
@XTICS; @YTICS
Z=9;set log cb 1.05; set cbrange[27:36]  ;splot FILE_NAME @USING_M


@TITLE_TIME; @CBLABEL_TIME
@BMARGIN; @LMARGIN
@XTICS; @YTICS
Z=4;set log cb 1.1; set cbrange[0.000001:1] ;splot FILE_NAME @USING_M
#Z=12;set title "#Cache Misses"   ;set zlabel "cachemiss"   ;set log cb 1.1; set cbrange[0.1:1.5] ;splot FILE_NAME using X:Y:Z with pm3d
#Z=13;set title "#FloatingPt. Ops"   ;set zlabel "floatinst"   ;set log cb; set cbrange[1:1000] ;splot FILE_NAME using X:Y:Z with pm3d
#Z=14;set title "Bandwidth(B/s)"   ;set zlabel "Bandwidth"   ;set log cb; set cbrange[100000:1200000000] ;splot FILE_NAME using X:Y:Z with pm3d
#Z=15;set title "#Bytes per Fragment";set zlabel "bytesperfrag";set log cb; set cbrange[1:2097152] ;splot FILE_NAME using X:Y:Z with pm3d
#Z=16;set title "#Fragments per byte" ;set zlabel "fragperbyte" ;set log cb; set cbrange[0.1:1] ;splot FILE_NAME using X:Y:Z with pm3d
#Z=17;set title "bytes per watt" ;set zlabel "byteperwatt" ;unset log cb; set cbrange[1:120000] ;splot FILE_NAME using X:Y:Z with pm3d
#Z=18;set title "Watt score" ;set zlabel "Normalized Watt score" ;unset log cb; set cbrange[0:3] ;splot FILE_NAME using X:Y:Z with pm3d
#Z=19;set title "Power score" ;set zlabel "Normalized Power score" ;set log cb; set cbrange[0:14000] ;splot FILE_NAME using X:Y:Z with pm3d
#Z=20;set title "BW/Watt" ;set zlabel "byteperwatt" ;set log cb; set cbrange[0:14000] ;splot FILE_NAME using X:Y:Z with pm3d
#Z=21;set title "BW/Watt" ;set zlabel "Normalized BW score" ;set log cb; set cbrange[0:14000] ;splot FILE_NAME using X:Y:Z with pm3d


pause -1 "Hit any key to continue" 
