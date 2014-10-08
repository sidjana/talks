FILE_NAME_OPENIB_72B = "openib_mvapich_2b.rput.dat.bak1"
FILE_NAME_OPENIB_2MB = "openib_mvapich_2mb.dat.bak2"
FILE_NAME_TCP_72B = "openib_mvapich_2b.r3.dat.bak2"
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
set output "cpu_dram_accesses.pdf"
#set terminal pngcairo
#set output "cpu_dram_accesses.png"


# set palette model HSV
#      set palette defined ( 0 0 1 1, 1 1 1 1 )
#    set palette defined ( 0 "blue", 3 "green", 6 "yellow", 10 "red" )

set palette defined ( 2 "violet", 3 "blue", 4 "dark-blue", \
        5 "dark-green", 6 "green", 7 "yellow",\
        8 "orange", 9 "red", 10 "dark-red")
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

TITLE_COREPOW_TCP_72B = "set title 'TCP_RVDV:CPU-DRAM accesses(W)[Scale:7.7-7.798W]' font \
'Times-Roman, 4' offset -3,0"
TITLE_COREPOW_OPENIB_72B = "set title 'OPENIB_RNDV:CPU-DRAM accesses(W)[Scale:4.5-6W]' font \
'Times-Roman, 4' offset -3,0"
TITLE_COREPOW_TCP_2MB = "set title 'TCP_EAGER: CPU-DRAM accesses(W)[Scale:6-8.5W]' font \
'Times-Roman, 4' offset -3,0"
TITLE_COREPOW_OPENIB_2MB = "set title 'OPENIB_EAGER: CPU-DRAM accesses(W)[Scale:6-7.5W]' font \
'Times-Roman, 4' offset -3,0"

@TITLE_COREPOW_TCP_72B; @CBLABEL_POW
@TMARGIN; @LMARGIN
@XTICS; @YTICS
Z=7;set log cb  1.008282; set cbrange[5:7.7]
splot FILE_NAME_TCP_72B @USING_M

@TITLE_COREPOW_OPENIB_72B; @CBLABEL_POW
@TMARGIN; @RMARGIN
@XTICS; @NOYTICS
Z=7;set log cb  1.008282; set cbrange[4.5:7.5] #[5:7.798];
splot FILE_NAME_OPENIB_72B @USING_M

#@TITLE_COREPOW_TCP_2MB; @CBLABEL_POW
#@BMARGIN; @LMARGIN
#@XTICS; @YTICS
#Z=7;set log cb  1.008282; set cbrange[6:8.5]  #[5:7.798];
#splot FILE_NAME_TCP_2MB @USING_M

@TITLE_COREPOW_OPENIB_2MB; @CBLABEL_POW
@BMARGIN; @RMARGIN
@XTICS; @NOYTICS
Z=7;set log cb  1.008282; set cbrange[5.8:7.4]   #[5:7.798]; 
splot FILE_NAME_OPENIB_2MB @USING_M

pause -1 "Hit any key to continue" 
