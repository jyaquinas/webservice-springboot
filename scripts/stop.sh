#!/bin/bash

ABSPATH=$(readlink -f $0)
# get current directory of stop.sh
ABSDIR=$(dirname $ABSPATH)
# import profile.sh to use its function
source ${ABSDIR}/profile.sh

IDLE_PORT=$(find_idle_port)

echo "> Check pid of application running on port: $IDLE_PORT"
IDLE_PID=$(lsof -ti tcp:${IDLE_PORT})

if [ -z ${IDLE_PID} ]
then
  echo "> No current running application."
else
  echo "> kill -15 $IDLE_PID"
  kill -15 ${IDLE_PID}
  sleep 5
fi

