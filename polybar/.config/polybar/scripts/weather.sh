#!/bin/bash
res=$(curl -s 'wttr.in?format="%c+%t"')
res="${res%\"}"
res="${res#\"}"
IFS=' ' read -ra ADDR <<< $res
echo '%{T10}'${ADDR[0]}'%{T-}' ${ADDR[1]}
