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
set output "memory_power.pdf"
#set terminal pngcairo
#set output "memroy_power.png"

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

CBLABEL_POW = "set cblabel 'Power(W)[Log-scale]' font \
'Times-Roman, 3' offset -5,0 rotate by -90" 

TITLE_MEMPOW_TCP_72B = "set title 'TCP_RVDV: Memory Power (W)' font \
'Times-Roman, 4' offset -3,0"
TITLE_MEMPOW_OPENIB_72B = "set title 'OPENIB_RNDV: Memory Power (Watts)' font \
'Times-Roman, 4' offset -3,0"
TITLE_MEMPOW_TCP_2MB = "set title 'TCP_EAGER: Memory Power (Watts)' font \
'Times-Roman, 4' offset -3,0"
TITLE_MEMPOW_OPENIB_2MB = "set title 'OPENIB_EAGER: Memory Power (Watts)' font \
'Times-Roman, 4' offset -3,0"

#@TITLE_MEMPOW_TCP_72B; @CBLABEL_POW
#@TMARGIN; @LMARGIN
#@XTICS; @YTICS
#Z=6;set log cb 1.01; set cbrange[73:85] ;
#splot FILE_NAME_TCP_72B @USING_M
#
#@TITLE_MEMPOW_OPENIB_72B; @CBLABEL_POW
#@TMARGIN; @RMARGIN
#@XTICS; @NOYTICS
#Z=6;set log cb 1.01; set cbrange[73:85] ;
#splot FILE_NAME_OPENIB_72B @USING_M
#
#@TITLE_MEMPOW_TCP_2MB; @CBLABEL_POW
#@BMARGIN; @LMARGIN
#@XTICS; @YTICS
#Z=6;set log cb 1.01; set cbrange[73:85] ;
#splot FILE_NAME_TCP_2MB @USING_M
#
@TITLE_MEMPOW_OPENIB_2MB; @CBLABEL_POW
@BMARGIN; @RMARGIN
@XTICS; @NOYTICS
Z=6;set log cb 1.01; set cbrange[73:85] ;
splot FILE_NAME_OPENIB_2MB @USING_M

pause -1 "Hit any key to continue" 
