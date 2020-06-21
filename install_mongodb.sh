#!/bin/bash

# Install mongo repo key
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add - &>> ./log

# Add mongo repo to sources list
add-apt-repository 'deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse'

# Update packets database
apt-get update &>> ./log

# Install mongodb
apt-get install -y mongodb-org &>> ./log

# Start mongodb service
systemctl start mongod &>> ./log

# Enable mongodb service
systemctl enable mongod &>> ./log

# Check exit code
if test $? -ne 0
then
     echo "Exit code: '$?'. Please review log file and fix errors manually!"
else
     echo "MongoDB installed succesfully. Continue to the next step."
fi
