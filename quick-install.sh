#!/bin/bash
sudo touch /var/swap.img
sudo chmod 600 /var/swap.img
sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=2000
mkswap /var/swap.img
sudo swapon /var/swap.img
sudo echo "/var/swap.img none swap sw 0 0" >> /etc/fstab
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get install -y nano htop git build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils software-properties-common libboost-all-dev
sudo add-apt-repository -y ppa:bitcoin/bitcoin
sudo apt-get update -y
sudo apt-get install -y libdb4.8-dev libdb4.8++-dev
sudo apt-get install -y pwgen

wget https://github.com/Emrals/emrals/releases/download/v1.0.2.6/linux-x64.tar.gz
tar xzfv linux-x64.tar.gz

sudo cp emralsd /usr/local/bin/
sudo cp emrals-cli /usr/local/bin
sudo chmod -R 755 /usr/local/bin/emralsd
sudo chmod -R 755 /usr/local/bin/emrals-cli
mkdir ~/.emralscore
chmod -R 755 ~/.emralscore

GEN_PASS=$(pwgen -1 -n 30)
echo -e "rpcuser=emralscoinuser\nrpcpassword=${GEN_PASS}\nrpcport=30000\nport=30001\nlisten=1\nmaxconnections=256" > ~/.emralscore/emrals.conf

emralsd -daemon
sleep 10
masternodekey=$(./emrals-cli masternode genkey)
emrals-cli stop
echo -e "masternode=1\nmasternodeprivkey=$masternodekey" >> /root/.emralscore/emrals.conf
emralsd -daemon

echo "Masternode private key: $masternodekey"
echo "Job completed successfully" 
