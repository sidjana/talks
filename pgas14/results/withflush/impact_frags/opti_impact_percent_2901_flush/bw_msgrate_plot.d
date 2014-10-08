

set format x "%10.0f"
set format y "%10.0f"
set xrange [1:524288] 
set logscale x 2
X=2 ; 
set title font "Times-Roman, 4" 

set terminal pdf size 4in,6in 
set output "graph_bw_msg_rate.pdf"
#set terminal pngcairo
#set output "graph_bw_msg_rate.png"

set multiplot layout 5,2 rowsfirst scale 1,1 # \
#title "%age Drop in Energy Parameters (Cores+DRAM) for different optimizations due to fragmentation of a 0.5MB payload" \
#font 'Times-Roman,4' 

set macros
#set key box
set key spacing 0.5 font 'Times-Roman,2.5' samplen 2 \
        width -10

NOXTICS = "unset xtics; unset xlabel;"
XTICS = "set xtics nomirror font 'Times-Roman,3' offset \
0,-1.5 rotate by 90; set xlabel 'Total number of fragments \
[Log-scale]'\ font 'Times-Roman,4' offset 0,5"
NOYTICS = "unset ylabel; unset ytics" 
YTICS = "set ytics nomirror font 'Times-Roman,3' offset \
0.5,0,0 ;set ylabel 'Fragments/sec' font 'Times-Roman, \
4' offset 8,-1"
Y2TICS = "set y2tics nomirror font 'Times-Roman,3' offset \
0.5,0,0 ;set y2label 'Reduction(%)' font 'Times-Roman, \
4' offset 8,-1"

TMARGIN = "set tmargin at screen 0.88; set bmargin at screen 0.60"
BMARGIN = "set tmargin at screen 0.38; set bmargin at screen 0.10"
LMARGIN = "set lmargin at screen 0.10; set rmargin at screen 0.38"
RMARGIN = "set lmargin at screen 0.60; set rmargin at screen 0.90" 

TITLE_MR = "set title 'Message Rate (Fragments/sec)' \
font 'Times-Roman, 4' offset -3,-1"
TITLE_BW = "set title 'Bandwidth (Bytes/sec)' \
font 'Times-Roman, 4' offset -3,-1"

USING_M_INI = "using X:28 with linespoints axes x1y1"
USING_M_FINAL = "using X:29 with linespoints axes x1y1"
USING_M2 = "using X:27 with linespoints axes x1y2"

USING_BW_INI = "using X:31 with linespoints axes x1y1"
USING_BW_FINAL = "using X:32 with linespoints axes x1y1"
USING_BW2 = "using X:30 with linespoints axes x1y2"

set style line 1 lw 2 pt 1 ps 0.3 lc rgb "#AA4499" 
set style line 2 lw 2 pt 4 ps 0.3 lc rgb "#332288" 
set style line 6 lt 3 lc rgb "red" lw 1
set arrow from 1,0 to 524288,0 back nohead  ls 6 

FIRST="MPQMPQ"
LAST="PQPQ"
@NOXTICS
@YTICS
@Y2TICS

@TITLE_MR
@LMARGIN
set key vertical right top
#set yrange[-5:25]
plot "2901_opti_impact_".FIRST."_".LAST.".out" @USING_M_INI title FIRST ls 1 , \
     "2901_opti_impact_".FIRST."_".LAST.".out" @USING_M_FINAL title LAST ls 2 , \
     "2901_opti_impact_".FIRST."_".LAST.".out" @USING_M2 title FIRST."->".LAST ls 3

@TITLE_BW
@RMARGIN
set key vertical right top
#set yrange[-5:25]
plot "2901_opti_impact_".FIRST."_".LAST.".out" @USING_BW_INI title FIRST ls 1 , \
     "2901_opti_impact_".FIRST."_".LAST.".out" @USING_BW_FINAL title LAST ls 2 , \
     "2901_opti_impact_".FIRST."_".LAST.".out" @USING_BW2 title FIRST."->".LAST ls 3


FIRST="MPQMPQ"
LAST="MPMPQ"
@NOXTICS
@YTICS
@Y2TICS

@TITLE_MR
@LMARGIN
set key vertical right top
#set yrange[-5:25]
plot "2901_opti_impact_".FIRST."_".LAST.".out" @USING_M_INI title FIRST ls 1 , \
     "2901_opti_impact_".FIRST."_".LAST.".out" @USING_M_FINAL title LAST ls 2 , \
     "2901_opti_impact_".FIRST."_".LAST.".out" @USING_M2 title FIRST."->".LAST ls 3

@TITLE_BW
@RMARGIN
set key vertical right top
#set yrange[-5:25]
plot "2901_opti_impact_".FIRST."_".LAST.".out" @USING_BW_INI title FIRST ls 1 , \
     "2901_opti_impact_".FIRST."_".LAST.".out" @USING_BW_FINAL title LAST ls 2 , \
     "2901_opti_impact_".FIRST."_".LAST.".out" @USING_BW2 title FIRST."->".LAST ls 3


FIRST="PQPQ"
LAST="PPQ"
@NOXTICS
@YTICS
@Y2TICS

@TITLE_MR
@LMARGIN
set key vertical right top
#set yrange[-5:25]
plot "2901_opti_impact_".FIRST."_".LAST.".out" @USING_M_INI title FIRST ls 1 , \
     "2901_opti_impact_".FIRST."_".LAST.".out" @USING_M_FINAL title LAST ls 2 , \
     "2901_opti_impact_".FIRST."_".LAST.".out" @USING_M2 title FIRST."->".LAST ls 3

@TITLE_BW
@RMARGIN
set key vertical right top
#set yrange[-5:25]
plot "2901_opti_impact_".FIRST."_".LAST.".out" @USING_BW_INI title FIRST ls 1 , \
     "2901_opti_impact_".FIRST."_".LAST.".out" @USING_BW_FINAL title LAST ls 2 , \
     "2901_opti_impact_".FIRST."_".LAST.".out" @USING_BW2 title FIRST."->".LAST ls 3


FIRST="MPMPQ"
LAST="PPQ"
@NOXTICS
@YTICS
@Y2TICS

@TITLE_MR
@LMARGIN
set key vertical right top
#set yrange[-5:25]
plot "2901_opti_impact_".FIRST."_".LAST.".out" @USING_M_INI title FIRST ls 1 , \
     "2901_opti_impact_".FIRST."_".LAST.".out" @USING_M_FINAL title LAST ls 2 , \
     "2901_opti_impact_".FIRST."_".LAST.".out" @USING_M2 title FIRST."->".LAST ls 3

@TITLE_BW
@RMARGIN
set key vertical right top
#set yrange[-5:25]
plot "2901_opti_impact_".FIRST."_".LAST.".out" @USING_BW_INI title FIRST ls 1 , \
     "2901_opti_impact_".FIRST."_".LAST.".out" @USING_BW_FINAL title LAST ls 2 , \
     "2901_opti_impact_".FIRST."_".LAST.".out" @USING_BW2 title FIRST."->".LAST ls 3

FIRST="PPQ"
LAST="MMPQAMM"
@NOXTICS
@YTICS
@Y2TICS

@TITLE_MR
@LMARGIN
set key vertical right top
#set yrange[-5:25]
plot "2901_opti_impact_".FIRST."_".LAST.".out" @USING_M_INI title FIRST ls 1 , \
     "2901_opti_impact_".FIRST."_".LAST.".out" @USING_M_FINAL title LAST ls 2 , \
     "2901_opti_impact_".FIRST."_".LAST.".out" @USING_M2 title FIRST."->".LAST ls 3

@TITLE_BW
@RMARGIN
set key vertical right top
#set yrange[-5:25]
plot "2901_opti_impact_".FIRST."_".LAST.".out" @USING_BW_INI title FIRST ls 1 , \
     "2901_opti_impact_".FIRST."_".LAST.".out" @USING_BW_FINAL title LAST ls 2 , \
     "2901_opti_impact_".FIRST."_".LAST.".out" @USING_BW2 title FIRST."->".LAST ls 3


#pause -1 "Hit any key to continue" 
