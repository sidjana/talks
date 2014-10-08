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

TITLE_CPUPOW = "set title 'CPU Power (Watts)' font \
'Times-Roman, 4' offset -3,0"
TITLE_DRAMPOW = "set title 'DRAM Power (Watts)' font \
'Times-Roman, 4' offset -3,0"
TITLE_IPMI = "set title 'Total IPMI Power (Watts)' \
font 'Times-Roman, 4' offset -2,0"
TITLE_TOTPOW = "set title 'Total Sys Power (Watts)' font \
'Times-Roman, 4' offset -2,0"
TITLE_MOTB = "set title 'Motherboard Power(Watts)' font \
'Times-Roman, 4' offset -2,0"
NOTITLE = "unset title"

#"Msg Fragments ${ipmi_sys_pow} ${pp_sys_pow} ${pp_cpu_pow} ${pp_mem_pow} ${pp_disk_pow} ${pp_mb_pow}  " 

@TMARGIN; @LMARGIN
@TITLE_IPMI; @CBLABEL_POW
@XTICS; @YTICS;
Z=3 ;set title "IPMI_pow"  ; set log cb 1.01;  
set cbrange[199.7:207] ;splot FILE_NAME using X:Y:Z with pm3d
#set cbrange[199.7:228] ;splot FILE_NAME using X:Y:Z with pm3d

@TMARGIN; @RMARGIN
@TITLE_CPUPOW; @CBLABEL_POW
@XTICS; @NOYTICS;
Z=5 ;set title "CPU_pow"  ; set log cb 1.01; 
set cbrange[70:95] ;splot FILE_NAME using X:Y:Z with pm3d


@BMARGIN; @LMARGIN
#@TITLE_MOTB; @CBLABEL_POW
@TITLE_TOTPOW; @CBLABEL_POW
@XTICS; @YTICS;
#Z=8 ;set title "PP_Motherboard(Watts)" ;set log cb 1.05; set cbrange[20:22] ;splot FILE_NAME using X:Y:Z with pm3d
Z=4 ;set title "PP_sys_power"  ;set log cb 1.01; 
set cbrange[230:264] ;splot FILE_NAME using X:Y:Z with pm3d

@BMARGIN; @RMARGIN
@TITLE_DRAMPOW; @CBLABEL_POW
@XTICS; @NOYTICS;
Z=6;set title "PP_Mem_Pow"   ;set log cb 1.01; 
set cbrange[73:85] ;splot FILE_NAME using X:Y:Z with pm3d

pause -1 "Hit any key to continue" 
