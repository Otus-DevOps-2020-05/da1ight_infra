#!/bin/bash

# Check if git installed and install it if it's not
if [ $(dpkg-query -W -f='${Status}' git 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  apt-get install -y git
else
echo "Git installed!"
fi

# Git clone project to app directory
git clone -b monolith https://github.com/express42/reddit.git /opt/app

# Install project dependencies
cd /opt/app && /usr/bin/bundle install

# Check exit code
if test $? -ne 0
then
     echo "Exit code: '$?'. Please review log and fix errors manually!"
else
     echo "App deployment complete succesfully!"
fi
