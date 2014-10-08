

set format x "%10.0f"
set format y "%10.0f"
set xrange [1:524288] 
set logscale x 2
X=2 ; 
set title font "Times-Roman, 4" 

set terminal pdf size 4in,6in 
set output "inst_cache_per_put.pdf"
#set terminal pngcairo
#set output "inst_cache_per_put.png"

set multiplot layout 5,2 rowsfirst scale 1,1 # \

set macros
set key spacing 0.5 font 'Times-Roman,2.5' samplen 2 \
        width -10

NOXTICS = "unset xtics; unset xlabel;"
XTICS = "set xtics nomirror font 'Times-Roman,3' offset \
0,0.5 rotate by -25;"
XLABEL = "set xlabel 'Total number of fragments \
[Log-scale]'\ font 'Times-Roman,4' offset 0,5"
NOYTICS = "unset ylabel; unset ytics" 
YTICS = "set ytics nomirror font 'Times-Roman,3' offset \
0.5,0,0 ;set ylabel 'Count/PUT' font 'Times-Roman, \
4' offset 9,-1"
Y2TICS = "set y2tics nomirror font 'Times-Roman,3' offset \
0.5,0,0 ;set y2label 'Reduction(%)' font 'Times-Roman, \
4' offset 4,-1"

TMARGIN = "set tmargin at screen 0.88; set bmargin at screen 0.60"
BMARGIN = "set tmargin at screen 0.38; set bmargin at screen 0.10"
LMARGIN = "set lmargin at screen 0.10; set rmargin at screen 0.38"
RMARGIN = "set lmargin at screen 0.60; set rmargin at screen 0.90" 

TITLE_MMPQAMM = "set title 'MMPQAMM' \
font 'Times-Roman, 4' offset -3,-1"
TITLE_PQPQ = "set title 'PQPQ' \
font 'Times-Roman, 4' offset -3,-1"
TITLE_PPQ = "set title 'PPQ' \
font 'Times-Roman, 4' offset -3,-1"
TITLE_MPMPQ = "set title 'MPMPQ' \
font 'Times-Roman, 4' offset -3,-1"
TITLE_MPQMPQ = "set title 'MPQMPQ' \
font 'Times-Roman, 4' offset -3,-1"
TITLE_INST = "set title 'Instructions/PUT' \
font 'Times-Roman, 4' offset -3,-1"
TITLE_CACHE = "set title 'Cache misses/PUT' \
font 'Times-Roman, 4' offset -3,-1"


USING_M = " with linespoints axes x1y1"

set style line 1 lw 2 pt 1 ps 0.3 lc rgb "#AA4499" 
set style line 2 lw 2 pt 4 ps 0.3 lc rgb "#332288" 
set style line 6 lt 3 lc rgb "red" lw 1
set arrow from 1,0 to 524288,0 back nohead  ls 6 

@NOXTICS
@XTICS
@YTICS

FIRST="MPQMPQ"
LAST="PQPQ"
@TITLE_INST
@LMARGIN
set key vertical right top
plot "2901_opti_impact_cache_".FIRST."_".LAST.".out" using X:11 @USING_M title FIRST."->".LAST ls 1

@TITLE_CACHE
@RMARGIN
set key vertical right top
plot "2901_opti_impact_cache_".FIRST."_".LAST.".out" using X:14 @USING_M title FIRST."->".LAST ls 1

FIRST="MPQMPQ"
LAST="MPMPQ"
@TITLE_INST
@LMARGIN
set key vertical right top
plot "2901_opti_impact_cache_".FIRST."_".LAST.".out" using X:11 @USING_M title FIRST."->".LAST ls 1

@TITLE_CACHE
@RMARGIN
set key vertical right top
plot "2901_opti_impact_cache_".FIRST."_".LAST.".out" using X:14 @USING_M title FIRST."->".LAST ls 1

FIRST="PQPQ"
LAST="PPQ"
@TITLE_INST
@LMARGIN
set key vertical right top
plot "2901_opti_impact_cache_".FIRST."_".LAST.".out" using X:11 @USING_M title FIRST."->".LAST ls 1

@TITLE_CACHE
@RMARGIN
set key vertical right top
plot "2901_opti_impact_cache_".FIRST."_".LAST.".out" using X:14 @USING_M title FIRST."->".LAST ls 1

FIRST="MPMPQ"
LAST="PPQ"
@TITLE_INST
@LMARGIN
set key vertical right top
plot "2901_opti_impact_cache_".FIRST."_".LAST.".out" using X:11 @USING_M title FIRST."->".LAST ls 1

@TITLE_CACHE
@RMARGIN
set key vertical right top
plot "2901_opti_impact_cache_".FIRST."_".LAST.".out" using X:14 @USING_M title FIRST."->".LAST ls 1

FIRST="PPQ"
LAST="MMPQAMM"
@TITLE_INST
@LMARGIN
set key vertical right top
plot "2901_opti_impact_cache_".FIRST."_".LAST.".out" using X:11 @USING_M title FIRST."->".LAST ls 1

@TITLE_CACHE
@RMARGIN
set key vertical right top
plot "2901_opti_impact_cache_".FIRST."_".LAST.".out" using X:14 @USING_M title FIRST."->".LAST ls 1




#@TITLE_MPQMPQ
#@LMARGIN
#set key vertical right top
#plot "2901_opti_impact_cache_MPQMPQ_PQPQ.out" using X:9 @USING_M title "inst" ls 1
#
#@RMARGIN
#set key vertical right top
#plot "2901_opti_impact_cache_MPQMPQ_PQPQ.out" using X:11 @USING_M title "cache" ls 2
#
#
#@TITLE_PQPQ
#@LMARGIN
#set key vertical right top
#plot "2901_opti_impact_cache_MPQMPQ_PQPQ.out" using X:10 @USING_M title "inst" ls 1
#
#@RMARGIN
#set key vertical right top
#plot "2901_opti_impact_cache_MPQMPQ_PQPQ.out" using X:12 @USING_M title "cache" ls 2
#
#
#@TITLE_MPMPQ
#@LMARGIN
#set key vertical right top
#plot "2901_opti_impact_cache_MPQMPQ_MPMPQ.out" using X:10 @USING_M title "inst" ls 1
#
#@RMARGIN
#set key vertical right top
#plot "2901_opti_impact_cache_MPQMPQ_MPMPQ.out" using X:12 @USING_M title "cache" ls 2
#
#
#@TITLE_PPQ
#@LMARGIN
#set key vertical right top
#plot "2901_opti_impact_cache_PQPQ_PPQ.out" using X:10 @USING_M title "inst" ls 1
#
#@RMARGIN
#set key vertical right top
#plot "2901_opti_impact_cache_PQPQ_PPQ.out" using X:12 @USING_M title "cache" ls 2
#
#
#@TITLE_MMPQAMM
#@LMARGIN
#set key vertical right top
#plot "2901_opti_impact_cache_PPQ_MMPQAMM.out" using X:10 @USING_M title "inst" ls 1
#
#@RMARGIN
#set key vertical right top
#plot "2901_opti_impact_cache_PPQ_MMPQAMM.out" using X:12 @USING_M title "cache" ls 2



