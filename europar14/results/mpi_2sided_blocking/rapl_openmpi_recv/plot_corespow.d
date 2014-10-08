FILE_NAME_OPENIB_72B = "openib_72B.dat.bak1"
FILE_NAME_OPENIB_2MB = "openib_2MB.dat.bak2"
FILE_NAME_TCP_72B = "tcp_72B.dat.bak1"
FILE_NAME_TCP_2MB = "tcp_2MB.dat.bak2"

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
set output "cores_power.pdf"
#set terminal pngcairo
#set output "cores_power.png"

set palette defined ( 0 "violet", 1 "blue", 2 "dark-blue", 3 "dark-green", 4 "green", 5 "yellow",\
        6 "orange", 7 "red", 8 "dark-red" )
#set palette defined ( 0 "blue", 1 "dark-green", 2 "green", 3 "yellow",\
#        4 "orange", 5 "red", 6 "dark-red" )
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

TITLE_COREPOW_TCP_72B = "set title '(I)TCP+RENDEZVOUS: Cores Power (W)' font \
'Times-Roman, 4' offset -3,0"
TITLE_COREPOW_OPENIB_72B = "set title '(II)OPENIB+RENDEZVOUS: Cores Power (Watts)' font \
'Times-Roman, 4' offset -3,0"
TITLE_COREPOW_TCP_2MB = "set title '(III)TCP+EAGER: Cores Power (Watts)' font \
'Times-Roman, 4' offset -3,0"
TITLE_COREPOW_OPENIB_2MB = "set title '(IV)OPENIB+EAGER: Cores Power (Watts)' font \
'Times-Roman, 4' offset -3,0"

set label 1 "(A)" at 8,512 center font "Times-Roman,4"
set arrow from 8,256 to 32,4 nohead front lw 0.5 
set label 2 "(B)" at 8,32768 center font "Times-Roman,4"
set arrow from 16,16384 to 16384,32 nohead front lw 0.5

@TITLE_COREPOW_TCP_72B; @CBLABEL_POW
@TMARGIN; @LMARGIN
@XTICS; @YTICS
Z=5;set log cb  1.0008282; set cbrange[15.8:16.2] ;
splot FILE_NAME_TCP_72B @USING_M

unset label
unset arrow
set label 1 "(A)" at 8,512 center font "Times-Roman,4"
set arrow from 8,256 to 32,4 nohead front lw 0.5 
set label 2 "(B)" at 5,32768 center font "Times-Roman,4"
set arrow from 16,16384 to 8192,32 nohead front lw 0.5
set label 3 "(C)" at 512,32768 center font "Times-Roman,4"
set arrow from 1024,16384 to 65536,512 nohead front lw 0.5
set label 4 "(D)" at 32768,524288 center font "Times-Roman,4"
set arrow from 32768,262144 to 524288,4 nohead front lw 0.5

@TITLE_COREPOW_OPENIB_72B; @CBLABEL_POW
@TMARGIN; @RMARGIN
@XTICS; @NOYTICS
Z=5;set log cb  1.0008282; set cbrange[16.2:16.6] ;
splot FILE_NAME_OPENIB_72B @USING_M

unset label
unset arrow
set label 1 "(A)" at 8,512 center font "Times-Roman,4"
set arrow from 8,256 to 32,4 nohead front lw 0.5 
set label 2 "(B)" at 8,32768 center font "Times-Roman,4"
set arrow from 16,16384 to 32768,32 nohead front lw 0.5

@TITLE_COREPOW_TCP_2MB; @CBLABEL_POW
@BMARGIN; @LMARGIN
@XTICS; @YTICS
Z=5;set log cb  1.0008282; set cbrange[15.7:19] ;
splot FILE_NAME_TCP_2MB @USING_M

unset label
unset arrow
set label 1 "(A)" at 8,512 center font "Times-Roman,4"
set arrow from 8,256 to 524288,4 nohead front lw 0.5 
set label 2 "(B)" at 8,32768 center font "Times-Roman,4"
set arrow from 16,16384 to 524288,32768 nohead front lw 0.5

@TITLE_COREPOW_OPENIB_2MB; @CBLABEL_POW
@BMARGIN; @RMARGIN
@XTICS; @NOYTICS
Z=5;set log cb  1.0008282; set cbrange[15.7:17.3] ;
splot FILE_NAME_OPENIB_2MB @USING_M

pause -1 "Hit any key to continue" 
