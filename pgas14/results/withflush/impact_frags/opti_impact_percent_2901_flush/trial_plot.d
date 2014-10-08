set format x "%10.0f"
set format y "%10.4f"
set xrange [1:524288] 
set logscale x 2
X=2 ; 
set title font "Times-Roman, 4" 

set terminal pdf
set output "impact_opti_tot.pdf"
#set terminal pngcairo
#set output "impact_opti_tot.png"

set multiplot layout 2,2 rowsfirst scale 1,1 \
        title "%age Drop in Energy Parameters (Cores+DRAM) for different optimizations due to fragmentation of a 0.5MB payload" \
        font 'Times-Roman,4' 

set macros
#set key box
set key spacing 0.5 font 'Times-Roman,2' samplen 2 \
        width -10

NOXTICS = "unset xtics; unset xlabel;"
XTICS = "set xtics font 'Times-Roman,3' offset \
0,-1.5 rotate by 90; set xlabel 'Total number of fragments \
[Log-scale]'\ font 'Times-Roman,4' offset 0,5"
NOYTICS = "unset ylabel; unset ytics" 
YTICS_POW = "set ytics nomirror font 'Times-Roman,3' offset \
0.5,0,0 ;set ylabel 'Cores Energy Drop(%)' font 'Times-Roman, \
4' offset 7.5,-1"
YTICS_ENERGY = "set ytics nomirror font 'Times-Roman,3' offset \
0.5,0,0 ;set ylabel 'DRAM Energy Drop(%)' font 'Times-Roman, \
4' offset 7.5,-1,0"
YTICS_TIME = "set ytics nomirror font 'Times-Roman,3' offset \
0.5,0,0 ;set ylabel 'Latency Drop(%)' font 'Times-Roman, \
4' offset 7.5,-1,0"

TMARGIN = "set tmargin at screen 0.88; set bmargin at screen 0.60"
BMARGIN = "set tmargin at screen 0.38; set bmargin at screen 0.10"
LMARGIN = "set lmargin at screen 0.15; set rmargin at screen 0.43"
RMARGIN = "set lmargin at screen 0.55; set rmargin at screen 0.85" 

TITLE_CORE_ENERGY = "set title '(I) Cores Energy Drop(%)' font \
'Times-Roman, 4' offset -3,-1"
TITLE_DRAM_ENERGY = "set title '(II) DRAM Energy Drop (%)' font \
'Times-Roman, 4' offset -3,-1"
TITLE_TIME = "set title '(III) Latency Drop (%)' \
font 'Times-Roman, 4' offset -3,-1"

USING_M = "using X:Y with linespoints"
set style line 1 lw 2 pt 1 ps 0.3 lc rgb "#AA4499" 
set style line 2 lw 2 pt 2 ps 0.3 lc rgb "#88CCEE" 
set style line 3 lw 2 pt 3 ps 0.3 lc rgb "#882255" 
set style line 4 lw 2 pt 4 ps 0.3 lc rgb "#332288" 
set style line 5 lw 2 pt 5 ps 0.3 lc rgb "#999933" 
set style line 6 lw 2 pt 7 ps 0.3 lc rgb "#117733" 

set key vertical right bot
set y2tics 20 nomirror 
@TITLE_CORE_ENERGY;
@TMARGIN; @LMARGIN
@XTICS; @YTICS_ENERGY
Y=4 ;
#set logscale y 1.0001
set yrange[-100:100]
plot "2901_opti_impact_PPQ_MMPQ.out" @USING_M title "PPPQ->MMPQ@2901" ls 1 , \
     "2901_opti_impact_PQPQ_PPQ.out" @USING_M title "PQPQ->PPPQ@2901" ls 2 axes x1y2 

