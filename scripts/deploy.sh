#!/bin/bash

REPOSITORY=/home/ec2-user/app/step2
PROJECT_NAME=webservice-springboot

echo "> Copying build files."

cp $REPOSITORY/zip/*.jar $REPOSITORY

echo "> Checking pid of current application running"

CURRENT_PID=$(pgrep -fl webservice-springboot | grep jar | awk '{print $1}')

echo "> pid of current application running: $CURRENT_PID"

if [ -z "$CURRENT_PID" ]; then
  echo "> No application running."
else
  echo "> kill -15 $CURRENT_PID"
  kill -15 $CURRENT_PID
  sleep 5
fi

echo "> Deploying new application"

JAR_NAME=$(ls -tr $REPOSITORY/*.jar | tail -n 1)

echo "> JAR Name: $JAR_NAME"

echo "> Adding execution permission to $JAR_NAME"

chmod +x $JAR_NAME

echo "> Executing $JAR_NAME"

nohup java -jar \
  -Dspring.config.location=classpath:/application.yml,\
  classpath:application-real.yml,\
  /home/ec2-user/app/application-oauth.yml,\
  /home/ec2-user/app/application-real-db.yml \
  -Dspring.profiles.active=real \
  $JAR_NAME > $REPOSITORY/nohup.out 2>&1 &