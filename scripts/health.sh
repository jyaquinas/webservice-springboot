#!/bin/bash

ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH)
source ${ABSDIR}/profile.sh
source ${ABSDIR}/switch.sh

IDLE_PORT=$(find_idle_port)

# check if application has been successfully deployed on idle port (green zone)
echo "> Staring health check..."
echo "> IDLE_PORT: $IDLE_PORT"
echo "> curl -s http://localhost:$IDLE_PORT/profile "
sleep 10

for RETRY_COUNT in {1..10}
do
  RESPONSE=$(curl -s http://localhost:${IDLE_PORT}/profile)
  UP_COUNT=$(echo ${RESPONSE} | grep 'real' | wc -l)

  if [ ${UP_COUNT} -ge 1 ]
  then
    echo "> Health check success."
    # switch proxy if green zone deployment successful
    switch_proxy
    break
  else
    echo "> Cannot get health check response or application not running."
    echo "> Health check: ${RESPONSE}"
  fi

  if [ ${RETRY_COUNT} -eq 10 ]
  then
    echo "> Health check failed."
    echo "> Not connecting to nginx and stopping deployment process."
    exit 1
  fi

  echo "> Health check connection failed. Retrying..."
  sleep 10
done