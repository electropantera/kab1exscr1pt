#!/bin/bash

# kab1exscr1pt v.0.1

# Script collection to help with installation and deployment of software packages

clear
sudo mkdir -p /var/log/kab1exscr1pt
echo "kabl1exscr1pt v.0.1 for Debian/Ubuntu"
echo ""
echo "Select software package to install"
echo ""
echo "1. Update System"
echo ""
echo "2. TeamViewer 10"


echo "Enter the package name"
read NUM


case $NUM in


	1)
		echo ""
		echo "Updating package list..."
		apt-get update >> /var/log/kab1exscr1pt/updatesystem.log
		echo "Updating system...Please wait..."
		apt-get dist-upgrade -y >> /var/log/kab1exscr1pt/updatesystem.log
		;;
	2)
		echo "Downloading TeamViewer..."
		mkdir -p /tmp/teamviewer 
		wget http://download.teamviewer.com/download/teamviewer_i386.deb -O /tmp/teamviewer/teamviewer.dpkg  >> /var/log/kab1exscr1pt/teamviewerinstall.log  
		echo "Configuring system..."
		dpkg --add-architecture i386  >> /var/log/kab1exscr1pt/teamviewerinstall.log 
		apt-get update >> /var/log/kab1exscr1pt/teamviewerinstall.log 
		echo "Installing Teamviewer..."
		dpkg -i /tmp/teamviewer/teamviewer.dpkg  >> /var/log/kab1exscr1pt/teamviewerinstall.log 
		apt-get -f install  >> /var/log/kab1exscr1pt/teamviewerinstall.log 
	;;


esac
