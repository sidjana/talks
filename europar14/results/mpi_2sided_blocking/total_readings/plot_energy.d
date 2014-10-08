FILE_NAME_OPENIB_72B = "openib_72b"
FILE_NAME_OPENIB_2MB = "openib_2mb"
FILE_NAME_TCP_72B = "tcp_72b"
FILE_NAME_TCP_2MB = "tcp_2mb"

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
set output "energy.pdf"
#set terminal pngcairo
#set output "energy.png"

set palette defined ( 0 "blue", 1 "dark-green", 2 "green", 3 "yellow",\
        4 "orange", 5 "red", 6 "dark-red" )
#set palette defined ( 0 "dark-red", 1 "red", 2 "orange", 3 "yellow",\
#        4 "green", 5 "dark-green", 6 "blue" ,7 "violet")
set pm3d corners2color mean at st
set view map
set multiplot layout 2,2 rowsfirst scale 1,1 

set macros

USING_M = "using X:Y:Z with pm3d"

NOXTICS = "unset xtics; unset xlabel;"
XTICS = "set xtics font 'Times-Roman,3' offset \
0,-0.2,0 rotate by 90; set xlabel 'Total Message Size \
(Bytes)[Log-scale]' font 'Times-Roman,4' offset -1,0.7"
NOYTICS = "unset ylabel; unset ytics" 
YTICS = "set ytics font 'Times-Roman,3' offset \
0.5,0,0 ;set ylabel '#Fragments[Log-scale]' font 'Times-Roman, \
4' offset 7.5,-1,0"

TMARGIN = "set tmargin at screen 0.88; set bmargin at screen 0.60"
BMARGIN = "set tmargin at screen 0.38; set bmargin at \
screen 0.10"
LMARGIN = "set lmargin at screen 0.15; set rmargin at screen 0.43"
RMARGIN = "set lmargin at screen 0.55; set rmargin at screen 0.85" 

CBLABEL_POW = "set cblabel 'Energy (J) [Log-scale]' font \
'Times-Roman, 3' offset -9,0 rotate by -90" 

TITLE_ENERGY_TCP_72B = "set title 'TCP+RENDEZVOUS: Energy (J)' font \
'Times-Roman, 4' offset -3,0"
TITLE_ENERGY_OPENIB_72B = "set title 'OPENIB+RENDEZVOUS: Energy (J)' font \
'Times-Roman, 4' offset -3,0"
TITLE_ENERGY_TCP_2MB = "set title 'TCP+EAGER: Energy (J)' font \
'Times-Roman, 4' offset -3,0"
TITLE_ENERGY_OPENIB_2MB = "set title 'OPENIB+EAGER: Energy (J)' font \
'Times-Roman, 4' offset -3,0"


set label 4 "Rise in Bytes/X'fer" at 64,65536 center font "Times-Roman,4" 
set arrow from 32,32768 to 256,4096  front lw 3 lt 8

@TITLE_ENERGY_TCP_72B; @CBLABEL_POW
@TMARGIN; @LMARGIN
@XTICS; @YTICS
set label 1 "(A)" at 16385,262144 center font "Times-Roman,4"
set arrow from 32768,262144 to 262144,65536 nohead front lw 0.5 
set label 2 "(B)" at 32,1024 center font "Times-Roman,4"
set arrow from 64,1024 to 524288,64 nohead front lw 0.5
set label 3 "(C)" at 4,32 center font "Times-Roman,4"
set arrow from 8,32 to 64,8 nohead front lw 0.5
Z=6;set log cb  1.0008282; set cbrange[0.0001:20000] ;
splot FILE_NAME_TCP_72B @USING_M


@TITLE_ENERGY_OPENIB_72B; @CBLABEL_POW
@TMARGIN; @RMARGIN
@XTICS; @NOYTICS
set label 1 "(A)" at 16385,262144 center font "Times-Roman,4"
set arrow from 32768,262144 to 262144,65536 nohead front lw 0.5 
set label 2 "(B)" at 32,1024 center font "Times-Roman,4"
set arrow from 64,1024 to 524288,64 nohead front lw 0.5
set label 3 "(C)" at 4,32 center font "Times-Roman,4"
set arrow from 8,32 to 64,8 nohead front lw 0.5
Z=6;set log cb  1.0008282; set cbrange[0.0001:20000] ;
splot FILE_NAME_OPENIB_72B @USING_M

@TITLE_ENERGY_TCP_2MB; @CBLABEL_POW
@BMARGIN; @LMARGIN
@XTICS; @YTICS
set label 1 "(A)" at 16385,262144 center font "Times-Roman,4"
set arrow from 32768,262144 to 262144,65536 nohead front lw 0.5 
set label 2 "(B)" at 32,1024 center font "Times-Roman,4"
set arrow from 64,1024 to 524288,64 nohead front lw 0.5
set label 3 "(C)" at 4,32 center font "Times-Roman,4"
set arrow from 8,32 to 64,8 nohead front lw 0.5
Z=6;set log cb  1.0008282; set cbrange[0.0001:20000] ;
splot FILE_NAME_TCP_2MB @USING_M

@TITLE_ENERGY_OPENIB_2MB; @CBLABEL_POW
@BMARGIN; @RMARGIN
@XTICS; @NOYTICS
set label 1 "(A)" at 16385,262144 center font "Times-Roman,4"
set arrow from 32768,262144 to 262144,65536 nohead front lw 0.5 
set label 2 "(B)" at 32,1024 center font "Times-Roman,4"
set arrow from 64,1024 to 524288,64 nohead front lw 0.5
set label 3 "(C)" at 4,32 center font "Times-Roman,4"
set arrow from 8,32 to 64,8 nohead front lw 0.5
Z=6;set log cb  1.0008282; set cbrange[0.0001:20000] ;
splot FILE_NAME_OPENIB_2MB @USING_M

pause -1 "Hit any key to continue" 
