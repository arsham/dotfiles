#! /bin/bash
# Beryl Property Finder 1.1
# 2007-01-04
#
# Uses code from
# http://wiki.beryl-project.org/wiki/Plugins/Set_Window_Attributes
#

tmpFile=$(mktemp)

echo "Detecting all attributes"
echo "Click on a window"
echo

xprop >${tmpFile}

winType=$(grep 'WINDOW_TYPE' ${tmpFile} |sed 's/^.*_\([^_]*\)$/\1/')
winClass=$(grep '^WM_CLASS' ${tmpFile} |cut -d\" -f4)
className=$(grep '^WM_CLASS' ${tmpFile} |cut -d\" -f2)
winTitle=$(grep '^WM_NAME(STRING)' ${tmpFile} |cut -d\" -f2)
Xid=$(grep "WM_CLIENT_LEADER(WINDOW)" ${tmpFile} | cut -d ' ' -f 5)
Pid=$(grep "_NET_WM_PID(CARDINAL)" ${tmpFile} | cut -d ' ' -f 3)
owningProg=$(grep '^_NET_WM_PID(CARDINAL)' ${tmpFile} |sed 's/.*= //g' |\
    xargs ps -o comm= -p)
    classRole=$(grep '^WM_WINDOW_ROLE(STRING)' ${tmpFile} |cut -d\" -f2)

    rm -f ${tmpFile}

    cat <<EOF
    window type     ${winType}
    window class    ${winClass}
    class name      ${className}
    window title    ${winTitle}
    owning program  ${owningProg}
    class role      ${classRole}
    xid		    ${Xid}
    Pid		    ${Pid}
    EOF

    exit 0


EOF
