#!/bin/bash

## Remember when plotting data for MAX_MSG_NUM=1, comment the 
## extra call to echo ""

MIN_WRK_SIZE="524288"
MAX_WRK_SIZE="524288"
MIN_MSG_NUM="1"
MAX_MSG_NUM="524288"

INI_OPTI="$1"
INI_ACT_FREQ="2901"
INI_PASS_FREQ="2901"

FINAL_OPTI="$2"
FINAL_ACT_FREQ="2901"
FINAL_PASS_FREQ="2901"

INI_FOLDER="readings_${INI_OPTI}_${INI_ACT_FREQ}_${INI_PASS_FREQ}"
FINAL_FOLDER="readings_${FINAL_OPTI}_${FINAL_ACT_FREQ}_${FINAL_PASS_FREQ}"

X=$MIN_WRK_SIZE

        echo "#1.Msg_size 2.Frags " \
        " 3.Timer_active 4.Timer_passive 5.Timer_tot " \
        " 6.Power_cpu_active 7.Power_cpu_passive 8.Power_cpu_tot " \
        " 9.Energy_cpu_active 10.Energy_cpu_passive 11.Energy_cpu_tot " \
        " 12.Power_dram_active 13.Power_dram_passive 14.Power_dram_tot " \
        " 15.Energy_dram_active 16.Energy_dram_passive 17.Energy_dram_tot " \
        " 18.Power_blade_active 19.Power_blade_passive 20.Power_blade_tot " \
        " 21.Energy_blade_active 22.Energy_blade_passive 23.Energy_blade_tot " \
        " 24.Edprod_impact 25.Edprod_ini 26.Edprod_final " \
        " 27.Msg_rate_impact 28.Msg_rate_ini 29.Msg_rate_final " \
        " 30.Bw_impact 31.Bw_ini 32.Bw_final"

while  [ $X -le $MAX_WRK_SIZE ] ; 
do
Y=$MIN_MSG_NUM
while  [ $Y -le $MAX_MSG_NUM ] && [ $Y -le $X ] ; 
do

        line_high_active=` grep "$X[[:space:]]$Y[[:space:]]" ${INI_FOLDER}/fpga_active.out`
        line_high_passive=` grep "$X[[:space:]]$Y[[:space:]]" ${INI_FOLDER}/fpga_passive.out`
        latency_high_active=` grep "$X[[:space:]]$Y[[:space:]]" ${INI_FOLDER}/time_active.out`
        latency_high_passive=` grep "$X[[:space:]]$Y[[:space:]]" ${INI_FOLDER}/time_passive.out`

        line_low_active=` grep "$X[[:space:]]$Y[[:space:]]" ${FINAL_FOLDER}/fpga_active.out`
        line_low_passive=` grep "$X[[:space:]]$Y[[:space:]]" ${FINAL_FOLDER}/fpga_passive.out`
        latency_low_active=` grep "$X[[:space:]]$Y[[:space:]]" ${FINAL_FOLDER}/time_active.out`
        latency_low_passive=` grep "$X[[:space:]]$Y[[:space:]]" ${FINAL_FOLDER}/time_passive.out`

    	myarr_low_active=($line_low_active)
    	myarr_low_passive=($line_low_passive)
        myarr_high_active=($line_high_active)
    	myarr_high_passive=($line_high_passive)


        timer_high_active=($latency_high_active)
        timer_high_passive=($latency_high_passive)
        timer_low_active=($latency_low_active)
        timer_low_passive=($latency_low_passive)
	
        timer_active=` echo "scale=12; (${timer_high_active[3]}-${timer_low_active[3]})*100/${timer_high_active[3]}   "| bc`
        timer_passive=`echo "scale=12; (${timer_high_passive[3]}-${timer_low_passive[3]})*100/${timer_high_passive[3]}"| bc`
        timer_tot=${timer_active}
         

        power_cpu_active=` echo "scale=12; (${myarr_high_active[4]}-${myarr_low_active[4]})*100/${myarr_high_active[4]}   "| bc`
        power_cpu_passive=`echo "scale=12; (${myarr_high_passive[4]}-${myarr_low_passive[4]})*100/${myarr_high_passive[4]}"| bc`
        power_cpu_tot=`echo "scale=12; (${myarr_high_passive[4]}-${myarr_low_passive[4]}+${myarr_high_active[4]}-${myarr_low_active[4]})*100/(${myarr_high_passive[4]}+${myarr_high_active[4]})"| bc`

        energy_cpu_active=` echo "scale=12; (${myarr_high_active[5]}-${myarr_low_active[5]})*100/${myarr_high_active[5]}   "| bc`
        energy_cpu_passive=`echo "scale=12; (${myarr_high_passive[5]}-${myarr_low_passive[5]})*100/${myarr_high_passive[5]}"| bc`
        energy_cpu_tot=`echo "scale=12; (${myarr_high_passive[5]}-${myarr_low_passive[5]}+${myarr_high_active[5]}-${myarr_low_active[5]})*100/(${myarr_high_passive[5]}+${myarr_high_active[5]})"| bc`

        power_dram_active=` echo "scale=12; (${myarr_high_active[6]}-${myarr_low_active[6]})*100/${myarr_high_active[6]}   "| bc`
        power_dram_passive=`echo "scale=12; (${myarr_high_passive[6]}-${myarr_low_passive[6]})*100/${myarr_high_passive[6]}"| bc`
        power_dram_tot=`echo "scale=12; (${myarr_high_passive[6]}-${myarr_low_passive[6]}+${myarr_high_active[6]}-${myarr_low_active[6]})*100/(${myarr_high_passive[6]}+${myarr_high_active[6]})"| bc`

        energy_dram_active=` echo "scale=12; (${myarr_high_active[7]}-${myarr_low_active[7]})*100/${myarr_high_active[7]}   "| bc`
        energy_dram_passive=`echo "scale=12; (${myarr_high_passive[7]}-${myarr_low_passive[7]})*100/${myarr_high_passive[7]}"| bc`
        energy_dram_tot=`echo "scale=12; (${myarr_high_passive[7]}-${myarr_low_passive[7]}+${myarr_high_active[7]}-${myarr_low_active[7]})*100/(${myarr_high_passive[7]}+${myarr_high_active[7]})"| bc`

        power_blade_active=` echo "scale=12; (${myarr_high_active[2]}-${myarr_low_active[2]})*100/${myarr_high_active[2]}   "| bc`
        power_blade_passive=`echo "scale=12; (${myarr_high_passive[2]}-${myarr_low_passive[2]})*100/${myarr_high_passive[2]}"| bc`
        power_blade_tot=`echo "scale=12; (${myarr_high_passive[2]}-${myarr_low_passive[2]}+${myarr_high_active[2]}-${myarr_low_active[2]})*100/(${myarr_high_passive[2]}+${myarr_high_active[2]})"| bc`

        energy_blade_active=` echo "scale=12; (${myarr_high_active[3]}-${myarr_low_active[3]})*100/${myarr_high_active[3]}   "| bc`
        energy_blade_passive=`echo "scale=12; (${myarr_high_passive[3]}-${myarr_low_passive[3]})*100/${myarr_high_passive[3]}"| bc`
        energy_blade_tot=`echo "scale=12; (${myarr_high_passive[3]}-${myarr_low_passive[3]}+${myarr_high_active[3]}-${myarr_low_active[3]})*100/(${myarr_high_passive[3]}+${myarr_high_active[3]})"| bc`

        edprod_ini=` echo "scale=12; (${myarr_high_active[5]}+${myarr_high_passive[5]}+${myarr_high_active[7]}+${myarr_high_passive[7]})*${timer_high_active[3]}"| bc`
        edprod_final=`  echo "scale=12; (${myarr_low_active[5]}+${myarr_low_passive[5]}+${myarr_low_active[7]}+${myarr_low_passive[7]})*${timer_low_active[3]}"| bc`
        edprod_impact=`  echo "scale=12; (${edprod_ini}-${edprod_final})*100/${edprod_ini}"| bc`

        msg_rate_ini=`echo "scale=12; (${Y}/${timer_high_active[3]})"| bc`
        msg_rate_final=`echo "scale=12; (${Y}/${timer_low_active[3]})"| bc`
        msg_rate_impact=`echo "scale=12; ((${Y}/${timer_high_active[3]})-(${Y}/${timer_low_active[3]}))*100/(${Y}/${timer_high_active[3]})"| bc`

        bw_ini=`echo "scale=12; (${X}/${timer_high_active[3]})"| bc`
        bw_final=`echo "scale=12; (${X}/${timer_low_active[3]})"| bc`
        bw_impact=`echo "scale=12; ((${X}/${timer_high_active[3]})-(${X}/${timer_low_active[3]}))*100/(${X}/${timer_high_active[3]})"| bc`

        echo $X $Y \
        ${timer_active} ${timer_passive} ${timer_tot} \
        ${power_cpu_active} ${power_cpu_passive} ${power_cpu_tot} \
        ${energy_cpu_active} ${energy_cpu_passive} ${energy_cpu_tot} \
        ${power_dram_active} ${power_dram_passive} ${power_dram_tot} \
        ${energy_dram_active} ${energy_dram_passive} ${energy_dram_tot} \
        ${power_blade_active} ${power_blade_passive} ${power_blade_tot} \
        ${energy_blade_active} ${energy_blade_passive} ${energy_blade_tot} \
        ${edprod_impact} ${edprod_ini} ${edprod_final} \
        ${msg_rate_impact} ${msg_rate_ini} ${msg_rate_final} \
        ${bw_impact} ${bw_ini} ${bw_final}

        : $(( Y=Y*2 ))

    done
    : $(( X=X*2 ))
done
