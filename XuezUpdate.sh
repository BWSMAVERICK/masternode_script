#/bin/bash
cd ~
	rm Xuez_Setup.sh
	rm Xuez_Setup.sh.1
	rm Xuez_Setup.sh.2
	rm Xuez_Setup.sh.3
	rm XuezUpdate.sh
	rm XuezUpdate.sh.1
	rm XuezUpdate.sh.2
	rm XuezUpdate.sh.3
echo "****************************************************************************"
echo "* This script will install and configure your XUEZ Coin masternodes.       *"
echo "*                    Love from A_Block_Nut(Thermo) ;)                      *"
echo "*    If you have any issues please ask for help on the XUEZ discord.       *"
echo "*                      https://discord.gg/QWcK5Yk                          *"
echo "*                        https://xuezcoin.com/                             *"
echo "****************************************************************************"
echo "" 
echo ""
echo ""
echo ""
echo ""
echo "Do you want TOR Integrated into this VPS? [y/n], followed by [ENTER]"
echo ""
echo ""
read TSETUP
	if 
	[[ $TSETUP =~ "y" ]] || [[$TSETUP =~ "Y" ]] ; then
sudo su -c "echo 'deb http://deb.torproject.org/torproject.org '$(lsb_release -c | cut -f2)' main' > /etc/apt/sources.list.d/torproject.list"
	gpg --keyserver keys.gnupg.net --recv A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89
	gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | sudo apt-key add -
	sudo apt-get update
	sudo apt-get install tor deb.torproject.org-keyring -y
	sudo usermod -a -G debian-tor $(whoami)

	sudo sed -i 's/#ControlPort 9051/ControlPort 9051/g' /etc/tor/torrc
	sudo sed -i 's/#CookieAuthentication 1/CookieAuthentication 1/g' /etc/tor/torrc 
	sudo su -c "echo 'CookieAuthFileGroupReadable 1' >> /etc/tor/torrc"
	sudo su -c "echo 'LongLivedPorts 9033' >> /etc/tor/torrc"
	sudo systemctl restart tor.service
	rm Xuez_Setup.sh
	rm Xuez_Setup.sh.1
	rm Xuez_Setup.sh.2
	rm Xuez_Setup.sh.3
	rm XuezUpdate.sh
	rm XuezUpdate.sh.1
	rm XuezUpdate.sh.2
	rm XuezUpdate.sh.3
	./xuez-cli stop
	fi
	
	
echo "Are you running this script as the root user? [y/n], followed by [ENTER]"
echo "!!!!!!!!!!PLEASE READ BELOW!!!!!!!!!!!!!!!"
echo "It is very important to program your masternode under a user rather than root."
echo "By entering Yes you will create a new user. You Dont need to enter any personal details but you do need to create password."
echo "OPTIONS BELOW"
echo "Please enter Yes If you are running this Script as root then re-run the script"
echo "Please enter Yes If you want to get into your created user"
echo ""
echo "Please Enter No if you are running this Script under your new user."
read USETUP
	if 
	[[ $USETUP =~ "y" ]] || [[$USETUP =~ "Y" ]] ; then
	
sudo adduser xuez
usermod -aG sudo xuez
su - xuez
fi

echo "Do you want to configure your VPS with Xuez recommended settings? [y/n], followed by [ENTER]"
read DOSETUP
	if 
	[[ $DOSETUP =~ "y" ]] || [[$DOSETUP =~ "Y" ]] ; then
	sudo apt-get update
	sudo apt-get -y upgrade
	sudo apt-get -y dist-upgrade
	
	sudo apt-get install -y ufw
	sudo ufw allow ssh/tcp
	sudo ufw limit ssh/tcp
	sudo ufw logging on
	sudo ufw allow 22
	sudo ufw allow 41798
        sudo ufw allow 9051
        sudo ufw allow 9033
	echo "y" | sudo ufw enable
	sudo ufw status
	sudo cp /root/.xuez/xuez.conf /home/xuez/.xuez/xuez.conf 
    	sudo cp /root/.xuez/masternode.conf /home/xuez/.xuez/masternode.conf 
    	sudo cp /root/.xuez/wallet.dat /home/xuez/.xuez/wallet.dat
	fi
	
echo "Are you installing/updating your Masternode? [y/n]"
read MSETUP
if
[[ $MSETUP =~ "y" ]] || [[$MSETUP =~ "Y" ]] ; then
echo "Masternode Configuration"
echo "Your recognised IP address is:"
sudo hostname -I 
echo "Is this the IP you wish to use for MasterNode ? [y/n] , followed by [ENTER]"
read IPDEFAULT
	if
	[[ $IPDEFAULT =~ "y" ]] || [[$IPDEFAULT =~ "Y" ]] ; then
	echo ""
	echo "We are using your default IP address"
	echo "Enter masternode private key for node, followed by [ENTER]: $ALIAS"
	read PRIVKEY
	CONF_DIR=~/.xuez\/
	CONF_FILE=xuez.conf
	PORT=41798
	IP=$(hostname -I)
	mkdir -p $CONF_DIR
	echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> $CONF_DIR/$CONF_FILE
	echo "rpcpassword=passw"`shuf -i 100000-10000000 -n 1` >> $CONF_DIR/$CONF_FILE
	echo "rpcallowip=127.0.0.1" >> $CONF_DIR/$CONF_FILE
	echo "listen=1" >> $CONF_DIR/$CONF_FILE
	echo "server=1" >> $CONF_DIR/$CONF_FILE
	echo "daemon=1" >> $CONF_DIR/$CONF_FILE
	echo "logtimestamps=1" >> $CONF_DIR/$CONF_FILE
	echo "maxconnections=256" >> $CONF_DIR/$CONF_FILE
	echo "masternode=1" >> $CONF_DIR/$CONF_FILE
	echo "" >> $CONF_DIR/$CONF_FILE
	echo "" >> $CONF_DIR/$CONF_FILE
	echo "port=$PORT" >> $CONF_DIR/$CONF_FILE
	echo "masternodeaddr=$IP:$PORT" >> $CONF_DIR/$CONF_FILE
	echo "masternodeprivkey=$PRIVKEY" >> $CONF_DIR/$CONF_FILE
	./xuezd -daemon
	echo "if server start failure try ./xuezd -reindex"
	echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	echo "!                                                 !"
	echo "! Your MasterNode Is setup please close terminal  !"
	echo "!   and continue the local wallet setup guide     !"
	echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	echo ""
else	
	echo "Type the custom IP of this node, followed by [ENTER]:"
	read DIP
	echo ""
	echo "Enter masternode private key for node, followed by [ENTER]: $ALIAS"
	read PRIVKEY
	CONF_DIR=~/.xuez\/
	CONF_FILE=xuez.conf
	PORT=41798
	mkdir -p $CONF_DIR
	echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> $CONF_DIR/$CONF_FILE
	echo "rpcpassword=passw"`shuf -i 100000-10000000 -n 1` >> $CONF_DIR/$CONF_FILE
	echo "rpcallowip=127.0.0.1" >> $CONF_DIR/$CONF_FILE
	echo "listen=1" >> $CONF_DIR/$CONF_FILE
	echo "server=1" >> $CONF_DIR/$CONF_FILE
	echo "daemon=1" >> $CONF_DIR/$CONF_FILE
	echo "logtimestamps=1" >> $CONF_DIR/$CONF_FILE
	echo "maxconnections=256" >> $CONF_DIR/$CONF_FILE
	echo "masternode=1" >> $CONF_DIR/$CONF_FILE
	echo "" >> $CONF_DIR/$CONF_FILE
	echo "" >> $CONF_DIR/$CONF_FILE
	echo "port=$PORT" >> $CONF_DIR/$CONF_FILE
	echo "masternodeaddr=$DIP:$PORT" >> $CONF_DIR/$CONF_FILE
	echo "masternodeprivkey=$PRIVKEY" >> $CONF_DIR/$CONF_FILE
	./xuezd -daemon
	echo "if server start failure try ./xuezd -reindex"
	echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	echo "!                                                 !"
	echo "! Your MasterNode Is setup please close terminal  !"
	echo "!   and continue the local wallet setup guide     !"
	echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	echo ""
fi
fi
