#!/bin/sh
appName="w_oss"
_LAUNCHER_DAEMON_OUT="server.out"

pid=`ps -ef | grep "appName=$appName" | grep -v "grep" | awk '{print $2}'`
if [ "$pid" = "" ]
then
	java -DappName=$appName -Xms512M -Xmx2048M -jar ./w_oss-1.0.jar --spring.config.location=./application.properties > "$_LAUNCHER_DAEMON_OUT" 2>&1 < /dev/null &
	echo "$appName is started!"
else
	echo "$appName is running"
fi
