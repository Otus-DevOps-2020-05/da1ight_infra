#!/bin/bash

# Get Nat IP
IP=`curl -sS ifconfig.co`

# Check if git installed and install it if it's not
if [ $(dpkg-query -W -f='${Status}' git 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  apt-get install -y git &>> ./log
else
echo "Git installed!" >> log
fi

# Git clone project to yc-client home directory
git clone -b monolith https://github.com/express42/reddit.git /home/yc-user/app &>> ./log

# Install project dependencies
cd /home/yc-user/app && bundle install &>> ./log

# Start App on port 3030
cd /home/yc-user/app && puma -d -p 3030 &>> ./log

# Check exit code
if test $? -ne 0
then
     echo "Exit code: '$?'. Please review log and fix errors manually!"
else
     echo "App deployment complete succesfully! Please visit '$IP':3030"
fi
