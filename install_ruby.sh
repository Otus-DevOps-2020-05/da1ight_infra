#!/bin/bash

# Update packets database
apt update &> ./log

# Install ruby, bundler and build essential packets
apt install -y ruby-full ruby-bundler build-essential &>> ./log

# Check exit code
if test $? -ne 0
then
     echo "Exit code: '$?'. Please review log and fix errors manually!"
else
     echo "Ruby, bundler and build essential installed succesfully. Continue to the next step."
fi
