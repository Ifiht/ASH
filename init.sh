#!/bin/sh

os=`uname -a`;
echo "Beginning bootstrap..."

case "$os" in
	macos)
		echo "Assuming host is OS X";
		os=1;
	;;
	*Microsoft*)
		echo "Assuming host is WSL";
		sudo apt install coreutils dbus dbus-x11 figlet file findutils fortune-mod geoip-database git gnupg gzip less lsb-base lsb-release lshw lsof make minicom nano ncurses-base net-tools openjdk-8-jdk pngcrush rand readline-common screen tcpdump telnet tmux toilet x11proto-core-dev xauth xdelta3 xfsprogs zsh net-tools;
		os=2;
	;;
	*linux* | *Linux*)
		echo "Assuming host is Linux";
		sudo apt install coreutils dbus figlet file findutils fortune-mod geoip-database git gnupg gzip less lsb-base lsb-release lshw lsof make nano ncurses-base net-tools openjdk-8-jdk pngcrush rand readline-common screen tcpdump telnet tmux zsh;
		sudo dpkg-reconfigure --priority=low unattended-upgrades # start auto-upgrades
		os=2;
	;;
	bsd)
		os=3;
		if [[ `groups` == *wheel* ]] || [[ `groups` == *sudo* ]]; then
			sudo pkg install gnupg zsh bash nano node10 npm-node10 ruby screen;
#			sudo pw group mod rvm -m `whoami`;
		fi
	;;
	*)
	exit 1
esac


#RVM installation:
if ! [ -d $HOME/.rvm ]; then
	echo "Installing RVM..."
	#gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
	gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
	command curl -sSL https://rvm.io/mpapis.asc | gpg --import -
	command curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
	curl -sSL https://get.rvm.io | bash -s stable && . $HOME/.rvm/scripts/rvm
	. $HOME/.rvm/scripts/rvm
	rvm install 2.7
fi

#NVM installation:
if ! [ -d $HOME/.nvm ]; then
	echo "Installing NVM..."
	mkdir $HOME/.nvm
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
	. $HOME/.nvm/nvm.sh
	nvm install 16
fi
