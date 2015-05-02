#!/bin/bash
tmpFile=$(mktemp)
xprop >${tmpFile}

winTitle=$(grep '^WM_NAME(STRING)' ${tmpFile} |cut -d\" -f2)
Pid=$(grep "_NET_WM_PID(CARDINAL)" ${tmpFile} | cut -d ' ' -f 3)

class=`kdialog --cmap --radiolist "Choose throttle for ${winTitle}:" 3 "Idle" off 2 "Best effort" on 1 "Real time" off`

before=`ionice -p $Pid`

if [ $? = 0 ] ; then
	if [ $class != 3 ]; then
		sched=4
		sched=`kdialog --radiolist "Choose niceness :" 0 "0" off \
								1 "1" off \
								2 "2" off \
								3 "3" off \
								4 "4" on \
								5 "5" off \
								6 "6" off \
								7 "7" off `
	else
		sched=0
	fi
	ionice -c $class -n $sched -p $Pid
	after=`ionice -p $Pid`

	dcopRef=`kdialog --progressbar "Initialising" 128`
	dcop $dcopRef setLabel "New pirority would be like this"
	amount=`echo "8*(3 - ${class}) * (${sched}+1)" |bc -l`
	dcop $dcopRef setProgress $amount
	sleep 2
	dcop $dcopRef close

#	kdialog --msgbox "${winTitle} status was : ${before}\nNow is : ${after}"
fi

rm -f ${tmpFile}
