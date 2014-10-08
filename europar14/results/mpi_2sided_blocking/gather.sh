#!/bin/bash

#openib_2mb
#CORE_SEND_FILE="rapl_openmpi_send/openib_2MB.dat.bak2"
#CORE_RECV_FILE="rapl_openmpi_recv/openib_2MB.dat.bak2"
#MEM_SEND_FILE="sysg_openmpi_send/openib2mb.dat.2"
#MEM_RECV_FILE="sysg_openmpi_recv/openib2mb.dat.1"

#openib_72b
#CORE_SEND_FILE="rapl_openmpi_send/openib_72B.dat.bak1"
#CORE_RECV_FILE="rapl_openmpi_recv/openib_72B.dat.bak2"
#MEM_SEND_FILE="sysg_openmpi_send/openib72b.dat.2"
#MEM_RECV_FILE="sysg_openmpi_recv/openib72b.dat.3"

#tcp_2mb
#CORE_SEND_FILE="rapl_openmpi_send/tcp_2MB.dat.bak3"
#CORE_RECV_FILE="rapl_openmpi_recv/tcp_2MB.dat.bak4"
#MEM_SEND_FILE="sysg_openmpi_send/tcp2mb.dat.4"
#MEM_RECV_FILE="sysg_openmpi_recv/tcp2mb.dat.1"

#tcp_72b
CORE_SEND_FILE="rapl_openmpi_send/tcp_72B.dat.3"
CORE_RECV_FILE="rapl_openmpi_recv/tcp_72B.dat.bak2"
MEM_SEND_FILE="sysg_openmpi_send/tcp72b.dat.1"
MEM_RECV_FILE="sysg_openmpi_recv/tcp72b.dat.1"


ENERGY_COL_CORE="6"
POWER_COL_CORE="5"
POWER_COL_MEM="5"
TIME_COL_CORE="4"

MIN_WRK_SIZE="1"
MAX_WRK_SIZE="1048576"
MIN_MSG_NUM="1"
MAX_MSG_NUM="1048576"

X="$MIN_WRK_SIZE"


while  [ $X -le $MAX_WRK_SIZE ] ; 
do
  Y=$MIN_MSG_NUM
  while  [ $Y -le $MAX_MSG_NUM ] && [ $Y -le $X ] ; 
  do
  
    message_size=$X
    fragment=$Y


    energy_core_send="`cat $CORE_SEND_FILE | awk -v c1=$X -v c2=$Y '$1==c1 && $2==c2' | awk -v c1=$ENERGY_COL_CORE '{print $c1}'`" 
    energy_core_recv="`cat $CORE_RECV_FILE | awk -v c1=$X -v c2=$Y '$1==c1 && $2==c2' | awk -v c1=$ENERGY_COL_CORE '{print $c1}'`" 
    power_core_send="`cat $CORE_SEND_FILE  | awk -v c1=$X -v c2=$Y '$1==c1 && $2==c2' | awk -v c1=$POWER_COL_CORE '{print $c1}'`" 
    power_core_recv="`cat $CORE_RECV_FILE  | awk -v c1=$X -v c2=$Y '$1==c1 && $2==c2' | awk -v c1=$POWER_COL_CORE '{print $c1}'`" 
    time_core_send="`cat $CORE_SEND_FILE   | awk -v c1=$X -v c2=$Y '$1==c1 && $2==c2' | awk -v c1=$TIME_COL_CORE '{print $c1}'`" 
    time_core_recv="`cat $CORE_RECV_FILE   | awk -v c1=$X -v c2=$Y '$1==c1 && $2==c2' | awk -v c1=$TIME_COL_CORE '{print $c1}'`" 
    power_mem_send="`cat $MEM_SEND_FILE    | awk -v c1=$X -v c2=$Y '$1==c1 && $2==c2' | awk -v c1=$POWER_COL_MEM '{print $c1}'`" 
    power_mem_recv="`cat $MEM_RECV_FILE    | awk -v c1=$X -v c2=$Y '$1==c1 && $2==c2' | awk -v c1=$POWER_COL_MEM '{print $c1}'`" 


    if [ "$energy_core_send" == "" -o "$energy_core_recv" == "" -o "$power_core_send" == "" -o "$power_core_recv" == "" -o "$time_core_send" == "" -o "$time_core_recv" == "" -o "$power_mem_send" == "" -o "$power_mem_recv" == "" ]; then

#    echo ${X}_${Y} "$energy_core_send" -o "$energy_core_recv"  -o "$power_core_send"  -o "$power_core_recv" -o "$time_core_send" -o "$time_core_recv" -o "$power_mem_send" -o "$power_mem_recv"  

       : $((Y=Y*2))
       continue; 
    fi


    energy_mem_send=`echo "scale=12; ($power_mem_send) * ($time_core_send)" | bc`
    energy_mem_recv=`echo "scale=12; ($power_mem_recv)*($time_core_recv)" | bc`

    tot_power_send=`echo "scale=12; ($power_mem_send)+($power_core_send)" | bc`
    tot_power_recv=`echo "scale=12; ($power_mem_recv)+($power_core_recv)" | bc`
    tot_power=`echo "scale=12; ($tot_power_recv)+($tot_power_send)" | bc`

    tot_energy_send=`echo "scale=12; ($energy_mem_send)+($energy_core_send)" | bc`
    tot_energy_recv=`echo "scale=12; ($energy_mem_recv)+($energy_core_recv)"| bc`
    tot_energy=`echo "scale=12; ($tot_energy_recv)+($tot_energy_send)" | bc`

    tot_byte_joule=`echo "scale=12; ($X)/($tot_energy)" | bc`

    echo -e "$X\t$Y\t$tot_power\t$tot_power_send\t$tot_power_recv\t$tot_energy\t$tot_energy_send\t$tot_energy_recv\t$tot_byte_joule" 
    : $((Y=Y*2))
  done
  echo ""
  : $((X=X*2))
done
