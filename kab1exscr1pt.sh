#!/bin/bash

# kab1exscr1pt v.0.1

# Script collection to help with installation and deployment of software packages


if [ "$(id -u)" != "0" ]; then
	echo "You need to execute this tool as root. Try with sudo ./kab1exscr1pt"
	exit 1
fi


clear
sudo mkdir -p /var/log/kab1exscr1pt
echo "kab1exscr1pt v.0.1 for Debian/Ubuntu"
echo ""
echo "Select software package to install"
echo ""
echo "1. Update System"
echo "2. TeamViewer 10"
echo "3. Sopcast Player"
echo "4. Spotify"
echo "5. AceStream"

echo ""
echo "Enter the package name"
read NUM


case $NUM in


	1)
		echo ""
		echo "Updating package list..."
		apt-get update 
		echo "Updating system...Please wait..."
		apt-get dist-upgrade -y 
		;;
	2)
		echo "Downloading TeamViewer..."
		mkdir -p /tmp/teamviewer 
		wget http://download.teamviewer.com/download/teamviewer_i386.deb -O /tmp/teamviewer/teamviewer.dpkg  >> /var/log/kab1exscr1pt/teamviewerinstall.log  
		echo "Configuring system..."
		dpkg --add-architecture i386  >> /var/log/kab1exscr1pt/teamviewerinstall.log 
		apt-get update >> /var/log/kab1exscr1pt/teamviewerinstall.log 
		echo "Installing Teamviewer..."
		dpkg -i /tmp/teamviewer/teamviewer.dpkg  
		apt-get -f install -y 
	;;

	3)
		add-apt-repository ppa:venerix/pkg -y
		apt-get update
		apt-get install sp-auth build-essential python-glade2 vlc -y
		wget http://sopcast-player.googlecode.com/files/sopcast-player-0.8.5.tar.gz -O /tmp/sopcastplayer.tar.gz
		mkdir -p /tmp/sopcastplayer
		tar zxvf /tmp/sopcastplayer.tar.gz -C /tmp/
		cd /tmp/sopcast-player
		make
		make install
		;;
	4)
		echo "deb http://repository.spotify.com stable non-free" >> /etc/apt/source.list
		apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 94558F59
		apt-get update && apt-get install spotify-client -y
		;;

	5)
		echo 'deb http://repo.acestream.org/ubuntu/ raring main' | tee /etc/apt/sources.list.d/acestream.list 
		wget -O – http://repo.acestream.org/keys/acestream.public.key | apt-key add 
		apt-get update
		wget https://dl.dropboxusercontent.com/u/6545640/Ace-stream-U14.04.tar -O /tmp/acestream.tar
		cd /tmp/
		tar xvf /tmp/acestream.tar
		cd /tmp/Ace-stream-U14.04/
		dpkg -i /tmp/Ace-stream-U14.04/acestream-engine-fix-Ubuntu_14.04.deb
		apt-get install python-apsw python-m2crypto
		cd /tmp && wget http://cz.archive.ubuntu.com/ubuntu/pool/universe/liba/libav-extra/libavutil-extra-51_0.8.10ubuntu0.12.04.1_amd64.deb http://cz.archive.ubuntu.com/ubuntu/pool/universe/libd/libdvbpsi/libdvbpsi7_0.2.2-1_amd64.deb http://cz.archive.ubuntu.com/ubuntu/pool/universe/libe/libebml/libebml3_1.2.2-2_amd64.deb http://cz.archive.ubuntu.com/ubuntu/pool/universe/libm/libmatroska/libmatroska5_1.3.0-1_amd64.deb http://cz.archive.ubuntu.com/ubuntu/pool/universe/x/x264/libx264-120_0.120.2151+gita3f4407-2_amd64.deb http://cz.archive.ubuntu.com/ubuntu/pool/universe/x/x264/libx264-123_0.123.2189+git35cf912-1_amd64.deb http://cz.archive.ubuntu.com/ubuntu/pool/universe/liba/libav-extra/libavcodec-extra-53_0.8.10ubuntu0.12.04.1_amd64.deb http://cz.archive.ubuntu.com/ubuntu/pool/universe/liba/libav-extra/libavformat-extra-53_0.8.10ubuntu0.12.04.1_amd64.deb http://cz.archive.ubuntu.com/ubuntu/pool/universe/liba/libav-extra/libavdevice-extra-53_0.8.10ubuntu0.12.04.1_amd64.deb && dpkg -i *.deb 
		apt-get install acestream-full
		apt-mark hold acestream-engine
		;;
		
		
		
		
esac
