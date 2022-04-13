#!/bin/bash
#!/usr/bin/env bash ??

# Find profile that isn't running
function find_idle_profile(){
  # gets html response code of current service
  RESPONSE_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost/profile)

  if [ ${RESPONSE_CODE} -ge 400 ]
  then
    CURRENT_PROFILE=real2
  else
    # get active profile name
    CURRENT_PROFILE=$(curl -s http://localhost/profile)
  fi

  if [ ${CURRENT_PROFILE} == real1 ]
  then
    IDLE_PROFILE=real2
  else
    IDLE_PROFILE=real1
  fi

  echo "${IDLE_PROFILE}"

}

# Find idle profile's port
# outputs port -> will be used by the client
function find_idle_port(){
  IDLE_PROFILE=$(find_idle_profile)

  if [ ${IDLE_PROFILE} == real1 ]
  then
    echo "8081"
  else
    echo "8082"
  fi

}
