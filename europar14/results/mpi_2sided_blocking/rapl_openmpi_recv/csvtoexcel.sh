#!/bin/bash

ORIGINAL="$1"
TEMP="temp_result.csv"

COUNTER1="FUNCTION"
COUNTER2="PP0_ENERGY"
COUNTER3="PAPI_TOT_INS"
COUNTER4="PAPI_L3_TCM"
COUNTER5="DRAM_ENERGY"
COUNTER6="PAPI_FP_INS"

MIN_WRK_SIZE="1"
MAX_WRK_SIZE="65536"
MIN_MSG_NUM="1"
MAX_MSG_NUM="65536"

PROCID="1"
rm -rf $TEMP
X=$MIN_WRK_SIZE

echo  "# `seq  -s '     ' 1 1 19 `"
printf '# %6s %6s %6s %20s %12s %12s %12s %12s %12s %12s %12s %12s  %12s  %8s  %12s  %8s %12s %14s %14s %14s %14i %14ss\n' \
"message_size" "fragment"  "iterations" "timer" "core_power" \
"core_energy" "dram_power" "dram_energy" \
"tot_power" "tot_energy" "totinst" "cachemiss" \
"floatinst" "bw" "bytesperfrag" "fragperbyte" "byteperwatt" "Normalized watt" "Normalized Energy" \
 "BW/Watt" "Normalized BW" "Ratio BW / Watt"



while  [ $X -le $MAX_WRK_SIZE ] ; 
do
Y=$MIN_MSG_NUM
while  [ $Y -le $MAX_MSG_NUM ] && [ $Y -le $X ] ; 
do

grep -i "($PROCID)" $ORIGINAL | grep ";${X}_${Y}" >$TEMP

message_size=$X
fragment=$Y

tot_time=(`grep $COUNTER1 $TEMP |  tr ';' ' '`)
iter=(`echo "${tot_time[3]}" | tr '_' ' '`)
tot_time_mod=`echo "${tot_time[6]}" | sed -e 's/[eE]+*/\\*10\\^/'`
timer=`echo "scale=16; ($tot_time_mod)/${iter[2]}" | bc`

core_power=(`grep $COUNTER2 $TEMP |  tr ';' ' '`)
core_power_mod=`echo "${core_power[6]}" | sed -e 's/[eE]+*/\\*10\\^/'`
core_power_mod=`echo "scale=12; ($core_power_mod)*10^-9" | bc`
core_energy=`echo "scale=12; ($core_power_mod)*$timer" | bc`

totinst_rate=(`grep $COUNTER3 $TEMP |  tr ';' ' '`)
totinst_rate_mod=`echo "${totinst_rate[6]}" | sed -e 's/[eE]+*/\\*10\\^/'`
totinst=`echo "scale=10; ($totinst_rate_mod)*$timer" | bc`

cachemiss_rate=(`grep $COUNTER4 $TEMP |  tr ';' ' '`)
cachemiss_rate_mod=`echo "${cachemiss_rate[6]}" | sed -e 's/[eE]+*/\\*10\\^/'`
cachemiss=`echo "scale=10; ($cachemiss_rate_mod)*$timer" | bc`

dram_power=(`grep $COUNTER5 $TEMP |  tr ';' ' '`)
dram_power_mod=`echo "${dram_power[6]}" | sed -e 's/[eE]+*/\\*10\\^/'`
dram_power_mod=`echo "scale=10; ($dram_power_mod)*10^-9" | bc`
dram_energy=`echo "scale=10; ($dram_power_mod)*$timer" | bc`

floatinst_rate=(`grep $COUNTER6 $TEMP |  tr ';' ' '`)
floatinst_rate_mod=`echo "${floatinst_rate[6]}" | sed -e 's/[eE]+*/\\*10\\^/'`
floatinst=`echo "scale=10; ($floatinst_rate_mod)*$timer" | bc`

bw=`echo "scale=10; $message_size/$timer" | bc`
bytesperfrag=`echo "scale=10; $message_size/$fragment" | bc`
fragperbyte=`echo "scale=10; $fragment/$message_size" | bc`

tot_power=`echo "scale=10; ($dram_power_mod)+($core_power_mod)" | bc`
tot_energy=`echo "scale=10; $dram_energy+$core_energy" | bc`

byteperwatt=`echo "scale=10; $message_size/$tot_power " | bc`
bwperwatt=`echo "scale=10; $bw/$tot_power " | bc`


if [ "$fragment" == "1"  ]; then 
  ONEWORK_POW=$tot_power
  ONEWORK_ENER=$tot_energy
  ONEWORK_BW=$bw
fi
norm_watt=`echo "scale=12; $tot_power/$ONEWORK_POW " | bc`
norm_ener=`echo "scale=12; $tot_energy/$ONEWORK_ENER " | bc`
norm_bw=`echo "scale=12; $bw/$ONEWORK_BW " | bc`
norm_bwwatt=`echo "scale=12; $norm_bw/$norm_watt " | bc`

printf '%6d %6d %6d %20.16lf %12.10lf %12.10lf %12.10lf %12.10lf %12.10lf %12.10lf %12lf %12.10lf %12.10lf %8.10lf %12lf %8.10lf %12.10lf %14.12lf %14.12lf %14.12lf %14.12lf %14.12lf \n' \
"$message_size" "$fragment" "${iter[2]}" "$timer" "$core_power_mod" \
"$core_energy" "$dram_power_mod" "$dram_energy" \
"$tot_power" "$tot_energy" "$totinst" "$cachemiss" \
"$floatinst" "$bw" "$bytesperfrag" "$fragperbyte" "$byteperwatt" "$norm_watt" "$norm_ener" \
 "$bwperwatt" "$norm_bw" "$norm_bwwatt"

: $((Y=Y*2))
done
echo ""
: $((X=X*2))
done
echo ""
rm -rf $TEMP
