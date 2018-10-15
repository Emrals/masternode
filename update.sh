#!/bin/bash
wget https://github.com/Emrals/emrals/releases/download/v0.12.2.5.2/linux-x64.tar.gz
tar xzfv linux-x64.tar.gz
cp -r ~/.emralscore ~/.emralscore-bak-v0.12.2.5.2
cp /usr/local/bin/emralsd emralsd-bak-v0.12.2.5.2
killall emralsd
sudo cp emralsd /usr/local/bin/emralsd
sudo cp emrals-cli /usr/local/bin/emrals-cli
#emralsd -reindex
emralsd
