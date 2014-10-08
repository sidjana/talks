
FIRST1 = "`echo $FIRST1`"
LAST1 = "`echo $LAST1`"
FIRST2 = "`echo $FIRST2`"
LAST2 = "`echo $LAST2`"
PREFIX1 = "Unpinned Source : "
PREFIX2 = "Pinned Source : "
PE = "`echo $PE`"

set format x "%10.0f"
set format y "%10.0f"
set xrange [1:524288] 
set logscale x 2
X=2 ; 
set title font "Times-Roman, 4" 

set terminal pdf
set output "impact_blocking_".PE.".pdf"
#set terminal pngcairo
#set output "impact_blocking_".PE.".png"

set multiplot layout 2,2 rowsfirst scale 1,1 # \
#title "%age Drop in Energy Parameters (CPU+DRAM) for different optimizations due to fragmentation of a 0.5MB payload" \
#font 'Times-Roman,4' 

set macros
#set key box
set key spacing 0.5 font 'Times-Roman,2.5' samplen 2 \
        width -17.5

NOXTICS = "unset xtics; unset xlabel;"
XTICS = "set xtics font 'Times-Roman,3' offset \
0,-1.5 rotate by 90; set xlabel 'Total number of fragments \
[Log-scale]'\ font 'Times-Roman,4' offset 0,5"
NOYTICS = "unset ylabel; unset ytics" 
YTICS_POW = "set ytics font 'Times-Roman,3' offset \
0.5,0,0 ;set ylabel 'Energy Reduction (%)' font 'Times-Roman, \
4' offset 8,-1"
YTICS_ENERGY = "set ytics font 'Times-Roman,3' offset \
0.5,0,0 ;set ylabel 'Energy Reduction (%)' font 'Times-Roman, \
4' offset 8,-1,0"
YTICS_TIME = "set ytics font 'Times-Roman,3' offset \
0.5,0,0 ;set ylabel 'Latency Reduction (%)' font 'Times-Roman, \
4' offset 8,-1,0"
YTICS_ED = "set ytics font 'Times-Roman,3' offset \
0.5,0,0 ;set ylabel 'Energy-Delay Product Reduction (%)' font 'Times-Roman, \
4' offset 8,0,0"

TMARGIN = "set tmargin at screen 0.88; set bmargin at screen 0.60"
BMARGIN = "set tmargin at screen 0.38; set bmargin at screen 0.10"
LMARGIN = "set lmargin at screen 0.15; set rmargin at screen 0.43"
RMARGIN = "set lmargin at screen 0.55; set rmargin at screen 0.85" 

TITLE_CORE_ENERGY = "set title '(I) CPU Energy Reduction (%)' font \
'Times-Roman, 4' offset -3,-1"
TITLE_DRAM_ENERGY = "set title '(II) DRAM Energy Reduction (%)' font \
'Times-Roman, 4' offset -3,-1"
TITLE_TIME = "set title '(III) Reduction in Latency (%)' \
font 'Times-Roman, 4' offset -3,-1"
TITLE_ED = "set title '(IV) Reduction in Energy-Delay Product (%)' \
font 'Times-Roman, 4' offset -3,-1"

USING_M = "using X:Y with linespoints"
set style line 1 lw 2 pt 1 ps 0.3 lc rgb "#AA4499" 
set style line 2 lw 2 pt 4 ps 0.3 lc rgb "#332288" 
set style line 6 lt 3 lc rgb "red" lw 1
set arrow from 1,0 to 524288,0 back nohead  ls 6 

set key vertical left top
@TITLE_CORE_ENERGY;
@TMARGIN; @LMARGIN
@XTICS; @YTICS_ENERGY
Y=11 #combined
#Y=10 #passive
#Y=9  #active
#set logscale y 1.0001
set yrange[0:100]
plot "2901_opti_impact_".FIRST1."_".LAST1.".out" @USING_M title PREFIX1.FIRST1."->".LAST1 ls 1 , \
     "2901_opti_impact_".FIRST2."_".LAST2.".out" @USING_M title PREFIX2.FIRST2."->".LAST2 ls 2

set key vertical right bot
@TITLE_DRAM_ENERGY; 
@TMARGIN; @RMARGIN
@XTICS; @YTICS_ENERGY
Y=17 #combined
#Y=16 #passive
#Y=15 #active
#set logscale y 1.0001
set yrange[-50:100]
plot "2901_opti_impact_".FIRST1."_".LAST1.".out" @USING_M title PREFIX1.FIRST1."->".LAST1 ls 1 , \
     "2901_opti_impact_".FIRST2."_".LAST2.".out" @USING_M title PREFIX2.FIRST2."->".LAST2 ls 2

set key vertical left top 
@TITLE_TIME; 
@BMARGIN; @LMARGIN
@XTICS; @YTICS_TIME
Y=5 #combined
#Y=4 #passive
#Y=3 #active
#set logscale y 1.001
set yrange[0:100]
plot "2901_opti_impact_".FIRST1."_".LAST1.".out" @USING_M title PREFIX1.FIRST1."->".LAST1 ls 1 , \
     "2901_opti_impact_".FIRST2."_".LAST2.".out" @USING_M title PREFIX2.FIRST2."->".LAST2 ls 2

set key vertical right bot
@TITLE_ED;
@BMARGIN; @RMARGIN
@XTICS; @YTICS_ED
Y=24
#set logscale y 1.001
set yrange[0:100]
plot "2901_opti_impact_".FIRST1."_".LAST1.".out" @USING_M title PREFIX1.FIRST1."->".LAST1 ls 1 , \
     "2901_opti_impact_".FIRST2."_".LAST2.".out" @USING_M title PREFIX2.FIRST2."->".LAST2 ls 2

#pause -1 "Hit any key to continue" 
