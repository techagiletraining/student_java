#!/bin/bash

echo "running setup"

# Install dependencies.
#sudo apt-get -y update
sudo yum -y install unzip
sudo yum -y install unzip openjdk-8-jre-headless xvfb libxi6 libgconf-2-4

# Install Python
sudo add-apt-repository -y ppa:fkrull/deadsnakes
sudo apt-get -y install python2.7
sudo apt-get -y install python-pip python-dev build-essential

# Install RobotFramework
sudo -H pip install robotframework

# Install ChromeDriver.
CHROME_DRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`
wget -N http://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip -P ~/
unzip ~/chromedriver_linux64.zip -d ~/
rm ~/chromedriver_linux64.zip
sudo mv -f ~/chromedriver /usr/local/bin/chromedriver
sudo chown root:root /usr/local/bin/chromedriver
sudo chmod 0755 /usr/local/bin/chromedriver

# Install Chrome.
wget -N https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P ~/
sudo dpkg -i --force-depends ~/google-chrome-stable_current_amd64.deb
sudo apt-get -f install -y
sudo dpkg -i --force-depends ~/google-chrome-stable_current_amd64.deb

# Install Selenium2Library
sudo -H pip install robotframework-selenium2library

echo "setup complete"
