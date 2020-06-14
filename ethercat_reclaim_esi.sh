#!/bin/bash
#
# ethercat_reclaim_esi.sh
#
# Reclaim access to the ESI/EEPROM of a EtherCAT ASIC.

ECATCMD="/opt/etherlab/bin/ethercat"
optstring="hn:"

node=0

if [ ! -e ${ECATCMD} ]
then
	ECATCMD=`which ethercat`
	if [ $? -eq 0 ]
	then
		echo "Error could not find IgH command ethercat, please check your master implementation"
		exit 1
	fi
fi

# get the node number from the command line
while getopts "${optstring}" opt
do
	case ${opt} in
	'h')
		echo "Usage: $0 [-h] [-n <nodenumber>]"
		exit 0
		;;
	'n')
		node=${OPTARG}
		;;
	*)
		echo "Usage: $0 [-h] [-n <nodenumber>]"
		exit 1
		;;
	esac
done

# procedure taken from ET1100 datasheet, works also for LAN9252


if ! ${ECATCMD} reg_write -p ${node} --type int8 0x500 2 2> /dev/null
then
	echo "Error writing 2 to register of node ${node}"
	exit 1
fi


if ! ${ECATCMD} reg_write -p ${node} --type int8 0x500 0 2> /dev/null
then
	echo "Error writing 1 to register of node ${node}"
	exit 1
fi

value=$( ${ECATCMD} reg_read -p ${node}  0x500 1 2> /dev/null )
if [ $? != 0 ]
then
	echo "Error reading to register of node ${node}"
	exit 1
fi

echo ${value}
if (( value != 0 ))
then
	echo "ERROR Reset failed"
	exit 1
fi

exit 0
