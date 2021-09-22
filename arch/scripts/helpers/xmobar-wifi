#!/bin/sh

iwconfig eth2 2>&1 | grep -q no\ wireless\ extensions\. && {
  echo wired
  exit 0
}

essid=`nmcli -t -f active,ssid dev wifi | egrep '^yes' | cut -d\' -f2`
if [ "$essid" == "" ]
then
	echo '睊'
else
	echo '直'
fi

exit 0
