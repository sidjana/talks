

set format x "%10.0f"
set format y "%10.0f"
set xrange [1:524288] 
set logscale x 2
X=2 ; 
set title font "Times-Roman, 4" 

set terminal pdf size 4in,1.5in 
set output "inst_cache_per_put_agg.pdf"
#set terminal pngcairo
#set output "inst_cache_per_put_agg.png"

set multiplot layout 5,2 rowsfirst scale 1,1 # \

set macros
set key spacing 0.5 font 'Times-Roman,2.5' samplen 2 \
        width -10

NOXTICS = "unset xtics; unset xlabel;"
XTICS = "set xtics nomirror font 'Times-Roman,3' offset \
0,-1.5 rotate by 90"
XLABEL = "set xlabel 'Total number of fragments \
[Log-scale]'\ font 'Times-Roman,4' offset 0,5"
NOYTICS = "unset ylabel; unset ytics" 
YTICS = "set ytics nomirror font 'Times-Roman,3' offset \
0.5,0,0 ;set ylabel 'Count/PUT' font 'Times-Roman, \
4' offset 9,-1"

TMARGIN = "set tmargin at screen 0.88; set bmargin at screen 0.20"
LMARGIN = "set lmargin at screen 0.10; set rmargin at screen 0.38"
RMARGIN = "set lmargin at screen 0.60; set rmargin at screen 0.90" 

TITLE_INST = "set title 'Agg:Instructions/PUT' \
font 'Times-Roman, 4' offset -3,-1"
TITLE_CACHE = "set title 'Agg:Cache misses/PUT' \
font 'Times-Roman, 4' offset -3,-1"

USING_M = " with linespoints axes x1y1"

set style line 1 lw 2 pt 1 ps 0.3 lc rgb "#AA4499" 
set style line 2 lw 2 pt 4 ps 0.3 lc rgb "#332288" 
set style line 6 lt 3 lc rgb "red" lw 1
set arrow from 1,0 to 524288,0 back nohead  ls 6 

@XTICS
@XLABEL
@YTICS

FIRST="PPQ"
LAST="MMPQAMM"
@TITLE_INST
@LMARGIN
@TMARGIN
set key vertical right bot
plot "2901_opti_impact_cache_".FIRST."_".LAST.".out" using X:11 @USING_M title FIRST."->".LAST ls 1

@TITLE_CACHE
@RMARGIN
@TMARGIN
set key vertical right bot
plot "2901_opti_impact_cache_".FIRST."_".LAST.".out" using X:14 @USING_M title FIRST."->".LAST ls 1

