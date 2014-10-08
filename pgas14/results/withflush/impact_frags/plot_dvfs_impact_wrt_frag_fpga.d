

set format x "%10.0f"
set format y "%10.6f"
set xrange [1:524288] 
set logscale x 2
X=2 ; 
set title font "Times-Roman, 4" 

set terminal pdf size 4in,3in
set output "MMPQ_dvfs_impact_frag_fpga.pdf" 
#set terminal pngcairo
#set output "MMPQ_dvfs_impact_frag_fpga.png"

set multiplot layout 2,2 rowsfirst scale 1,1 \
        title "Impact of DVFS: %age reduction in metrics: 2.901MHz->2.4MHz" \
        font 'Times-Roman,4' 

set macros
#set key box
set key spacing 0.5 font 'Times-Roman,2' samplen 2 \
        width -2

NOXTICS = "unset xtics; unset xlabel;"
XTICS = "set xtics font 'Times-Roman,3' offset \
0,-1.5 rotate by 90; set xlabel 'Total number of fragments \
[Log-scale]'\ font 'Times-Roman,4' offset 0,5"
NOYTICS = "unset ylabel; unset ytics" 
YTICS_POW = "set ytics font 'Times-Roman,3' offset \
0.5,0,0 ;set ylabel '% Reduction' font 'Times-Roman, \
4' offset 7.5,-1"
YTICS_ENERGY = "set ytics font 'Times-Roman,3' offset \
0.5,0,0 ;set ylabel '% Reduction' font 'Times-Roman, \
4' offset 7.5,-1,0"
YTICS_TIME = "set ytics font 'Times-Roman,3' offset \
0.5,0,0 ;set ylabel '% Reduction' font 'Times-Roman, \
4' offset 7.5,-1,0"
YTICS_TIME = "set ytics font 'Times-Roman,3' offset \
0.5,0,0 ;set ylabel '% Reduction' font 'Times-Roman, \
4' offset 7.5,-1,0"

TMARGIN = "set tmargin at screen 0.88; set bmargin at screen 0.6"
BMARGIN = "set tmargin at screen 0.38; set bmargin at screen 0.10"
LMARGIN = "set lmargin at screen 0.15; set rmargin at screen 0.43"
RMARGIN = "set lmargin at screen 0.55; set rmargin at screen 0.85" 

TITLE_CORE_ENERGY = "set title 'Reduction in CPU Energy' font \
'Times-Roman, 4' offset -3,-1"
TITLE_DRAM_ENERGY = "set title 'Reduction in DRAM Energy' font \
'Times-Roman, 4' offset -3,-1"
TITLE_TOT_ENERGY = "set title 'Reduction in Total Energy' font \
'Times-Roman, 4' offset -3,-1"
TITLE_TIME = "set title 'Reduction in Latency' \
font 'Times-Roman, 4' offset -3,-1"
TITLE_EDP = "set title 'Reduction in EDP' \
font 'Times-Roman, 4' offset -3,-1"

USING_M = "using X:Y with linespoints"
set style line 1 lw 2 pt 1 ps 0.3 lc rgb "#AA4499" 
set style line 2 lw 2 pt 2 ps 0.3 lc rgb "#88CCEE" 
set style line 3 lw 2 pt 3 ps 0.3 lc rgb "#882255" 
set style line 4 lw 2 pt 4 ps 0.3 lc rgb "#332288" 
set style line 5 lw 2 pt 5 ps 0.3 lc rgb "#999933" 
set style line 6 lw 2 pt 7 ps 0.3 lc rgb "#117733" 

# 1.Msg_size 2.Frag 3.Blade_pow 4.Blade_ener 5.CPU_pow 6.CPU_ener 7.DRAM_pow 8.DRAM_ener
# 9.Msg_size 10.Frag 11.Blade_pow 12.Blade_ener 13.CPU_pow 14.CPU_ener 15.DRAM_pow 16.DRAM_ener
# 17.Msg_size 18.Frag 19.Blade_pow 20.Blade_ener 21.CPU_pow 22.CPU_ener 23.DRAM_pow 24.DRAM_ener
# 25.Msg_size 26.Frag 27.Blade_pow 28.Blade_ener 29.CPU_pow 30.CPU_ener 31.DRAM_pow 32.DRAM_ener
# 33.Msg_size 34.Frag 35.Time 36.Start_TS 37.End_TS 
# 38.Msg_size 39.Frag 40.Time 41.Start_TS 42.End_TS 

# 1.Msg_size 2.Frag 3.Time 4.Start_TS 5.End_TS 
# 6.Msg_size 7.Frag 8.Time 9.Start_TS 10.End_TS 

MMPQ_2901_2901="readings_MMPQ_2901_2901/fpga_active.out readings_MMPQ_2901_2901/fpga_passive.out"
MMPQ_2901_2400="readings_MMPQ_2901_2400/fpga_active.out readings_MMPQ_2901_2400/fpga_passive.out"
MMPQ_2400_2901="readings_MMPQ_2400_2901/fpga_active.out readings_MMPQ_2400_2901/fpga_passive.out"
MMPQ_2400_2400="readings_MMPQ_2400_2400/fpga_active.out readings_MMPQ_2400_2400/fpga_passive.out"

MMPQ_2901_2901_time="readings_MMPQ_2901_2901/time_active.out"
MMPQ_2901_2400_time="readings_MMPQ_2901_2400/time_active.out"
MMPQ_2400_2901_time="readings_MMPQ_2400_2901/time_active.out"
MMPQ_2400_2400_time="readings_MMPQ_2400_2400/time_active.out"

set key vertical left bot
@TITLE_CORE_ENERGY; 
@TMARGIN; 
@LMARGIN
@XTICS; @YTICS_ENERGY

USING_M_TOT = "using X:(((($6)+($14))-(($22)+($30)))*100/(($6)+($14))) with linespoints"
#set logscale y 1.00001
set yrange[-10:60]
plot '< paste '.MMPQ_2901_2901.' '.MMPQ_2901_2400.' ' @USING_M_TOT title "Reduce Passive" ls 1 , \
     '< paste '.MMPQ_2901_2901.' '.MMPQ_2400_2901.' ' @USING_M_TOT title "Reduce Active" ls 2 , \
     '< paste '.MMPQ_2901_2901.' '.MMPQ_2400_2400.' ' @USING_M_TOT title "Reduce Both" ls 3


set key vertical left bot
@TITLE_DRAM_ENERGY; 
@TMARGIN; 
@RMARGIN
@XTICS; @YTICS_ENERGY
USING_M_TOT = "using X:(((($8)+($16))-(($24)+($32)))*100/(($8)+($16))) with linespoints"
#set logscale y 1.0001
unset logscale y
set yrange[-10:60]
plot '< paste '.MMPQ_2901_2901.' '.MMPQ_2901_2400.' ' @USING_M_TOT title "Reduce Passive" ls 1 , \
     '< paste '.MMPQ_2901_2901.' '.MMPQ_2400_2901.' ' @USING_M_TOT title "Reduce Active" ls 2 , \
     '< paste '.MMPQ_2901_2901.' '.MMPQ_2400_2400.' ' @USING_M_TOT title "Reduce Both" ls 3

set key vertical left bot
@TITLE_EDP; 
@BMARGIN; @LMARGIN
@XTICS; @YTICS_ENERGY
EDP1="((($6)+($14)+($8)+($16))*($35))"
EDP2="((($22)+($30)+($24)+($32))*($40))"
USING_M_TOT = "using X:(((".EDP1.")-(".EDP2."))*100/(".EDP1.")) with linespoints"
#set logscale y 1.0001
set yrange[-60:60]
plot '< paste '.MMPQ_2901_2901.' '.MMPQ_2901_2400.' '.MMPQ_2901_2901_time.' '.MMPQ_2901_2400_time \
        @USING_M_TOT title "Reduce Passive" ls 1 , \
     '< paste '.MMPQ_2901_2901.' '.MMPQ_2400_2901.' '.MMPQ_2901_2901_time.' '.MMPQ_2400_2901_time \
        @USING_M_TOT title "Reduce Active" ls 2 , \
     '< paste '.MMPQ_2901_2901.' '.MMPQ_2400_2400.' '.MMPQ_2901_2901_time.' '.MMPQ_2400_2400_time \
        @USING_M_TOT title "Reduce Both" ls 3

set key vertical left bot
@TITLE_TIME; 
@BMARGIN; @RMARGIN
@XTICS; @YTICS_TIME
USING_M_TOT = "using X:((($3)-($8))*100/(($3))) with linespoints"
set format y "%10.5f"
#set logscale y 1.00001
set yrange[-70:10]
plot '< paste '.MMPQ_2901_2901_time.' '.MMPQ_2901_2400_time.' ' @USING_M_TOT title "Reduce Passive" ls 1 , \
     '< paste '.MMPQ_2901_2901_time.' '.MMPQ_2400_2901_time.' ' @USING_M_TOT title "Reduce Active" ls 2 , \
     '< paste '.MMPQ_2901_2901_time.' '.MMPQ_2400_2400_time.' ' @USING_M_TOT title "Reduce Both" ls 3

#pause -1 "Hit any key to continue" 
