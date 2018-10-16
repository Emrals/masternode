#!/bin/bash
echo "Updating EMRALS to v0.12.2.5"
if systemctl|grep EMRALS > /dev/null
then
    systemctl stop EMRALS.service
fi
sleep 10
wget https://github.com/Emrals/emrals/releases/download/v0.12.2.5.2/linux-x64.tar.gz
tar xzfv linux-x64.tar.gz
cp -r ~/.emralscore ~/.emralscore-bak-v0.12.2.5.2
cp /usr/local/bin/emralsd emralsd-bak-v0.12.2.5.2
cp /usr/local/bin/emrals-cli emrals-cli-bak-v0.12.2.5.2

if pgrep -x "emralsd" > /dev/null
then
    killall -9 emralsd
fi

sudo cp emralsd /usr/local/bin/emralsd
sudo cp emrals-cli /usr/local/bin/emrals-cli
if systemctl|grep EMRALS > /dev/null
then
    systemctl start EMRALS.service
fi
sleep 10
if ! pgrep -x "emralsd" > /dev/null
then
    emralsd
fi
echo "Update Complete"

