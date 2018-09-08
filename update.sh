#!/bin/bash
wget https://github.com/Emrals/emrals/releases/download/v0.12.2.4.2/linux-x64.tar.gz
tar xzfv linux-x64.tar.gz
cp -r ~/.emralscore ~/.emralscore-bak
cp /usr/local/bin/emralsd emralsd-bak
killall emralsd
sudo cp emralsd /usr/local/bin/emralsd
emralsd -reindex
