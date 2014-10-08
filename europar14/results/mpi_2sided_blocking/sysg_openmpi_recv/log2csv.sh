#!/bin/bash

MIN_WRK_SIZE="1"
MAX_WRK_SIZE="1048576"
MIN_MSG_NUM="1"
MAX_MSG_NUM="1048576"
INPUT="$1"

X=$MIN_WRK_SIZE

session=0
while  [ $X -le $MAX_WRK_SIZE ] ; 
do
Y=$MIN_MSG_NUM
while  [ $Y -le $MAX_MSG_NUM ] && [ $Y -le $X ] ; 
do

	begin=`grep -n  "BEGIN: $session " $INPUT | cut -f1 -d:`
	end=`grep -n  "END: $session " $INPUT | cut -f1 -d:`
    : $(( begin += 1 ))
	if [[ -z "$end" ]]; then
		end=`wc -l < $INPUT`
	else
        : $(( end -= 1 ))
	fi

    : $((rec_num=end-begin+1))
	if [[  -z "$begin" || "$begin" -gt "$end" || "$begin" == "1" ]]; then
	#    echo "No records for $X $Y : session $session"
        : $(( session=session+1 ))
        : $(( Y=Y*2 ))
        continue	
    #else
    #    echo "$X $Y =$rec_num"
	fi
    
    sed -n ${begin},${end}p $INPUT  > temp_file
    ipmi_sys_pow=0
    pp_sys_pow=0
    pp_cpu_pow=0
    pp_mem_pow=0
    pp_disk_pow=0
    pp_mb_pow=0

    ipmi_sys_pow_sd=0
    pp_sys_pow_sd=0
    pp_cpu_pow_sd=0
    pp_mem_pow_sd=0
    pp_disk_pow_sd=0
    pp_mb_pow_sd=0
    
        #timestamp ipmi_system_power PowerPack_Sys_Power PowerPack_CPU_Power PowerPack_Mem_Power PowerPack_Disk_Power PowerPack_Mb_Power 
    while read line; 
    do
    	myarr=($line)
    	timestamp=${myarr[0]}
    	
    	myarr[1]=`echo "${myarr[1]} "| sed -e 's/\*\*\*//' | sed -e 's/[eE]+*/\\*10\\^/' `
    	myarr[2]=`echo "${myarr[2]} "| sed -e 's/\*\*\*//' | sed -e 's/[eE]+*/\\*10\\^/' `
    	myarr[3]=`echo "${myarr[3]} "| sed -e 's/\*\*\*//' | sed -e 's/[eE]+*/\\*10\\^/' `
    	myarr[4]=`echo "${myarr[4]} "| sed -e 's/\*\*\*//' | sed -e 's/[eE]+*/\\*10\\^/' `
    	myarr[5]=`echo "${myarr[5]} "| sed -e 's/\*\*\*//' | sed -e 's/[eE]+*/\\*10\\^/' `
    	myarr[6]=`echo "${myarr[6]} "| sed -e 's/\*\*\*//' | sed -e 's/[eE]+*/\\*10\\^/' `

    	ipmi_sys_pow=`echo "scale=12; ${ipmi_sys_pow} + ${myarr[1]} "| bc`
    	pp_sys_pow=`echo "scale=12; ${pp_sys_pow}   + ${myarr[2]} "| bc`
    	pp_cpu_pow=`echo "scale=12; ${pp_cpu_pow}   + ${myarr[3]} "| bc`
    	pp_mem_pow=`echo "scale=12; ${pp_mem_pow}   + ${myarr[4]} "| bc`
    	pp_disk_pow=`echo "scale=12; ${pp_disk_pow}  + ${myarr[5]} "| bc`
    	pp_mb_pow=`echo "scale=12; ${pp_mb_pow}    + ${myarr[6]} "| bc`
    
    done < temp_file
    ipmi_sys_pow=`echo "scale=12; ${ipmi_sys_pow}/${rec_num} "| bc`
    pp_sys_pow=`echo "scale=12; ${pp_sys_pow}  /${rec_num} "| bc`
    pp_cpu_pow=`echo "scale=12; ${pp_cpu_pow}  /${rec_num} "| bc`
    pp_mem_pow=`echo "scale=12; ${pp_mem_pow}  /${rec_num} "| bc`
    pp_disk_pow=`echo "scale=12; ${pp_disk_pow} /${rec_num} "| bc`
    pp_mb_pow=`echo "scale=12; ${pp_mb_pow}   /${rec_num} "| bc`

    while read line; 
    do
    	myarr=($line)
    	timestamp=${myarr[0]}
    	
    	myarr[1]=`echo "${myarr[1]} "| sed -e 's/\*\*\*//' | sed -e 's/[eE]+*/\\*10\\^/' `
    	myarr[2]=`echo "${myarr[2]} "| sed -e 's/\*\*\*//' | sed -e 's/[eE]+*/\\*10\\^/' `
    	myarr[3]=`echo "${myarr[3]} "| sed -e 's/\*\*\*//' | sed -e 's/[eE]+*/\\*10\\^/' `
    	myarr[4]=`echo "${myarr[4]} "| sed -e 's/\*\*\*//' | sed -e 's/[eE]+*/\\*10\\^/' `
    	myarr[5]=`echo "${myarr[5]} "| sed -e 's/\*\*\*//' | sed -e 's/[eE]+*/\\*10\\^/' `
    	myarr[6]=`echo "${myarr[6]} "| sed -e 's/\*\*\*//' | sed -e 's/[eE]+*/\\*10\\^/' `

    	ipmi_sys_pow_sd=`echo "scale=12; ${ipmi_sys_pow_sd}+((${ipmi_sys_pow} - ${myarr[1]})^2) "| bc`
    	pp_sys_pow_sd=`echo "scale=12; ${pp_sys_pow_sd}+((${pp_sys_pow} - ${myarr[2]})^2) "| bc`
    	pp_cpu_pow_sd=`echo "scale=12; ${pp_cpu_pow_sd}+((${pp_cpu_pow} - ${myarr[3]})^2) "| bc`
    	pp_mem_pow_sd=`echo "scale=12; ${pp_mem_pow_sd}+((${pp_mem_pow} - ${myarr[4]})^2) "| bc`
    	pp_disk_pow_sd=`echo "scale=12; ${pp_disk_pow_sd}+((${pp_disk_pow} - ${myarr[5]})^2) "| bc`
    	pp_mb_pow_sd=`echo "scale=12; ${pp_mb_pow_sd}+((${pp_mb_pow} - ${myarr[6]})^2) "| bc` 

    done < temp_file
    ipmi_sys_pow_sd=`echo "scale=12; sqrt(${ipmi_sys_pow_sd}/(${rec_num}-1)) "| bc`
    pp_sys_pow_sd=`echo "scale=12; sqrt(${pp_sys_pow_sd} /(${rec_num}-1)) "| bc`
    pp_cpu_pow_sd=`echo "scale=12; sqrt(${pp_cpu_pow_sd} /(${rec_num}-1)) "| bc`
    pp_mem_pow_sd=`echo "scale=12; sqrt(${pp_mem_pow_sd} /(${rec_num}-1)) "| bc`
    pp_disk_pow_sd=`echo "scale=12; sqrt(${pp_disk_pow_sd} /(${rec_num}-1)) "| bc`
    pp_mb_pow_sd=`echo "scale=12; sqrt(${pp_mb_pow_sd} /(${rec_num}-1)) "| bc`

    echo "$X $Y ${ipmi_sys_pow} ${pp_sys_pow} ${pp_cpu_pow} ${pp_mem_pow} ${pp_disk_pow} ${pp_mb_pow} ${ipmi_sys_pow_sd} ${pp_sys_pow_sd} ${pp_cpu_pow_sd} ${pp_mem_pow_sd} ${pp_disk_pow_sd} ${pp_mb_pow_sd}  ${rec_num}" 
        
    : $(( session=session+1 ))
    : $(( Y=Y*2 ))
done
echo ""
: $(( X=X*2 ))
done
echo ""
rm -rf temp_file
