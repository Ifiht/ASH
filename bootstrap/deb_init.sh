#!/bin/sh
### Must run manually ### 
#dpkg-reconfigure tzdata
#add ssh keys via google web
#nano /etc/sysctl.conf -> SEE DIR
##sysctl -p
### Security Hardening ###
	sed -i -e 's/UMASK.*022/UMASK  027/g' /etc/login.defs
	sed -i -e 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
	sed -i -e 's/Port 22/Port 272/g' /etc/ssh/sshd_config
### Install Packages & Software ###
	apt-get -y update
	apt-get -y upgrade
	apt-get -y install ruby less file telnet lynis mailutils git psmisc lsof locate man-db dirmngr zsh
### Setup Files and Folders ###
	mkdir /home/git
	mkdir /opt/bin
	touch /var/log/daily.log
	chmod 640 /var/log/daily.log
### Firewall Setup ###
#	iptables-restore < /root/4last_castle.sav
#	ip6tables-restore < /root/6last_castle.sav' > /etc/network/if-up.d/iptables 
#	chmod +x /etc/network/if-up.d/iptables
### GIT SETUP ###
	groupadd git
	chmod 770 /home/git
	chmod g+s /home/git
	git config --global user.name "Red"
	git config --global user.email Red@$HOSTNAME
	git config --global push.default current
	git config --global core.symlinks false
###### System Hardening ######
echo "HISTFILESIZE=100" >> /etc/profile
echo "TMOUT=3600" >> /etc/profile
userdel news
userdel games
### ROOT CONFIG ###
echo "export LS_OPTIONS='--color=auto'" > /root/.bashrc
echo "export PATH=$PATH:/opt/bin" >> /root/.bashrc
echo "eval "`dircolors`"" >> /root/.bashrc
echo "alias ll='ls $LS_OPTIONS -la'" >> /root/.bashrc
echo "alias rm='rm -i'" >> /root/.bashrc
echo "alias cp='cp -i'" >> /root/.bashrc
echo "alias mv='mv -i'" >> /root/.bashrc
echo "cd ~" >> /root/.bashrc
### End Script ###
updatedb
echo "All Done"
exit 0;
