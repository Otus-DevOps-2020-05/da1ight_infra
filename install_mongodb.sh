#!/bin/bash

# Install mongo repo key
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -

# Add mongo repo to sources list
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list

# Update packets database
apt-get update

# Install mongodb
apt-get install -y mongodb-org

# Start mongodb service
systemctl start mongod

# Enable mongodb service
systemctl enable mongod

# Check exit code
if test $? -ne 0
then
     echo "Exit code: '$?'. Please review log file and fix errors manually!"
else
     echo "MongoDB installed succesfully. Continue to the next step."
fi
