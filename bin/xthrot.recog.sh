#!/bin/bash
tmpFile=$(mktemp)
xprop >${tmpFile}

winTitle=$(grep '^WM_NAME(STRING)' ${tmpFile} |cut -d\" -f2)
Pid=$(grep "_NET_WM_PID(CARDINAL)" ${tmpFile} | cut -d ' ' -f 3)

before=`ionice -p $Pid`
kdialog --msgbox "${before}"

#dcopRef=`kdialog --progressbar "Initialising" 128`
#	dcop $dcopRef setLabel "New pirority would be like this"
#	amount=`echo "8*(3 - ${class}) * (${sched}+1)" |bc -l`
#	dcop $dcopRef setProgress $amount
#	sleep 2
#	dcop $dcopRef close

#	kdialog --msgbox "${winTitle} status was : ${before}\nNow is : ${after}"

rm -f ${tmpFile}
