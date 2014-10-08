FILE_NAME_OPENIB_72B = "openib_72B.dat"
FILE_NAME_OPENIB_2MB = "openib_2MB.dat"
FILE_NAME_TCP_72B = "tcp_72B.dat"
FILE_NAME_TCP_2MB = "tcp_2MB.dat"
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
set output "cachemisses.pdf"
#set terminal pngcairo
#set output "cachemisses.png"

set palette defined ( 0 "blue", 1 "dark-green", 2 "green", 3 "yellow",\
        4 "orange", 5 "red", 6 "dark-red" )
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

CBLABEL_CACHE = "set cblabel '#Cache-Misses[Log-scale]' font \
'Times-Roman, 3' offset -3,0 rotate by -90"

TITLE_CACHEMISS_TCP_72B = "set title \
'TCP_RVDV: Cache misses' font \
'Times-Roman, 4' offset -3,0"
TITLE_CACHEMISS_OPENIB_72B = "set title \
'OPENIB_RNDV: Cache misses' font \
'Times-Roman, 4' offset -3,0"
TITLE_CACHEMISS_TCP_2MB = "set title \
'TCP_EAGER: Cache misses' font \
'Times-Roman, 4' offset -3,0"
TITLE_CACHEMISS_OPENIB_2MB = "set title \
'OPENIB_EAGER: Cache misses' font \
'Times-Roman, 4' offset -3,0"

@TITLE_CACHEMISS_TCP_72B; @CBLABEL_CACHE
@TMARGIN; @LMARGIN
@XTICS; @YTICS
Z=12;set log cb 10; set cbrange[2:232] ;
splot FILE_NAME_TCP_72B @USING_M

@TITLE_CACHEMISS_OPENIB_72B; @CBLABEL_CACHE
@TMARGIN; @RMARGIN
@XTICS; @NOYTICS
Z=12;set log cb 10; set cbrange[2:232] ;
splot FILE_NAME_OPENIB_72B @USING_M

@TITLE_CACHEMISS_TCP_2MB; @CBLABEL_CACHE
@BMARGIN; @LMARGIN
@XTICS; @YTICS
Z=12;set log cb 10; set cbrange[2:232] ;
splot FILE_NAME_TCP_2MB @USING_M

@TITLE_CACHEMISS_OPENIB_2MB; @CBLABEL_CACHE
@BMARGIN; @RMARGIN
@XTICS; @NOYTICS
Z=12;set log cb 10; set cbrange[2:232] ;
splot FILE_NAME_OPENIB_2MB @USING_M

pause -1 "Hit any key to continue" 
