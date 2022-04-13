#!/bin/bash

ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH)
source ${ABSDIR}/profile.sh

REPOSITORY=/home/ec2-user/app/step3

PROJECT_NAME=webservice-springboot

echo "> Copying build files"
echo "> cp $REPOSITORY/zip/*.jar $REPOSITORY/"

cp $REPOSITORY/zip/*.jar $REPOSITORY/

echo "> Deploying new application"
JAR_NAME=$(ls -tr $REPOSITORY/*.jar | tail -n 1)

echo "> JAR name: $JAR_NAME"
echo "> Add execution permission to JAR_NAME"

chmod +x $JAR_NAME

echo "> Execute $JAR_NAME"

# get idle profile
IDLE_PROFILE=$(find_idle_profile)

echo "> Executing $JAR_NAME on profile=$IDLE_PROFILE"

nohup java -jar \
  -Dspring.config.location=classpath:/application.yml, classpath:/application-$IDLE_PROFILE.yml,/home/ec2-user/app/application-oauth.yml,/home/ec2-user/app/application-real-db.yml \
  -Dspring.profiles.active=$IDLE_PROFILE \
  $JAR_NAME > $REPOSITORY/nohup.out 2>&1 &
