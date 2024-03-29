#!/usr/bin/env bash

mvn clean package

echo 'Copy file...'

scp -i ~/.ssh/sweater-London.pem\
target/sweater-1.0-SNAPSHOT.jar\
ec2-user@ec2-52-56-129-110.eu-west-2.compute.amazonaws.com:/home/ec2-user

echo 'Restart server...'

ssh -i ~/.ssh/sweater-London.pem ec2-user@ec2-52-56-129-110.eu-west-2.compute.amazonaws.com <<EOF


pgrep java |  | xargs kill -9
nohup java -jar sweater-1.0-SNAPSHOT.jar > log.txt &


EOF

echo 'Bye'
