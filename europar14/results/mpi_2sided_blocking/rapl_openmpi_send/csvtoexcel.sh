#!/bin/bash

ORIGINAL="$1"
TEMP="temp_result.csv"

COUNTER1="FUNCTION"
COUNTER2="PP0_ENERGY"
COUNTER3="PAPI_TOT_INS"
COUNTER4="PAPI_L3_TCM"
COUNTER5="DRAM_ENERGY"

MIN_WRK_SIZE="1"
MAX_WRK_SIZE="1048576"
MIN_MSG_NUM="1"
MAX_MSG_NUM="1048576"

PROCID="1"
rm -rf $TEMP
X=$MIN_WRK_SIZE

echo  "# `seq  -s '     ' 1 1 19 `"
printf '# 1:%s 2:%s 3:%6s 4:%20s 5:%12s 6:%12s 7:%12s 8:%12s 9:%12s 10:%12s 11:%12s 12:%12s  13:%12s  14:%8s  15:%12s  16:%8s 17:%12s 18:%14s 19:%14s 20:%14s 21:%14s 22:%14s 23:%14s\n' \
"message_size" "fragment"  "iterations" "timer" "core_power" \
"core_energy" "dram_power" "dram_energy" \
"tot_power" "tot_energy" "totinst" "cachemiss" \
"floatinst" "bw" "bytesperfrag" "fragperbyte" "byteperwatt" "Normwatt" "NormEnergy" \
"BWperWatt" "NormBW" "RatioBWperWatt" "id_tag"



while  [ $X -le $MAX_WRK_SIZE ] ; 
do
Y=$MIN_MSG_NUM
while  [ $Y -le $MAX_MSG_NUM ] && [ $Y -le $X ] ; 
do

grep -i "($PROCID)" $ORIGINAL | grep ";${X}_${Y}" >$TEMP

message_size=$X
fragment=$Y

tot_time=(`grep $COUNTER1 $TEMP |  tr ';' ' '`)
iter=(`echo "${tot_time[3]}" |  sed -e 's/[eE]+*/\\*10\\^/' | tr '_' ' '`)
tot_time_mod=`echo "${tot_time[6]}" | sed -e 's/[eE]+*/\\*10\\^/'`
timer=`echo "scale=20; ($tot_time_mod)/(${iter[2]})" | bc`

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

printf '%d %d %13s %20.16lf %12.10lf %12.10lf %12.10lf %12.10lf %12.10lf %12.10lf %12lf %12.10lf %12.10lf %8.10lf %12lf %8.10lf %12.10lf %14.12lf %14.12lf %14.12lf %14.12lf %14.12lf %d_%d\n' \
"$message_size" "$fragment" "${iter[2]}" "$timer" "$core_power_mod" \
"$core_energy" "$dram_power_mod" "$dram_energy" \
"$tot_power" "$tot_energy" "$totinst" "$cachemiss" \
"$bw" "$bytesperfrag" "$fragperbyte" "$byteperwatt" "$norm_watt" "$norm_ener" \
 "$bwperwatt" "$norm_bw" "$norm_bwwatt" "$X" "$Y"


: $((Y=Y*2))
done
echo ""
: $((X=X*2))
done
echo ""
rm -rf $TEMP
