#!/bin/bash
#
# install Jumpcloud agent
#
# Author: Koen Veys
# script is maintained in https://github.com/kveys/jumpcloud.git

#
# Setting variables 

#program
curl=/usr/bin/curl
rm=/bin/rm

#global
tmpdir=/tmp
installdir=/tmp/jumpcloud
logfile=$installdir/installation.log
servername=`hostname`

clear

###################
# start of script #
###################

echo "####################################################"
echo "# Jumpcloud Linux agent installation on $servername"
echo -e "####################################################\n"


#Check if connect key is supplied as argument
if [ $# -eq 0 ]; then
	echo "No connect-key found!"
	echo "1) retrieve your key in the Jumpcloud console > Systems > + > Linux"
	echo "2) re-run this script with the key as argument"
	exit 1
fi

if ! [ -d $installdir ]; then
	mkdir $installdir
fi

#DOWNLOADING AGENT FROM JUMPCLOUD

echo "1) Downloading the latest installer script."

#setting the header
header="x-connect-key:`echo $1`"

cd $installdir
$curl --tlsv1.2 --silent --show-error --header `echo $header` https://kickstart.jumpcloud.com/Kickstart > $installdir/jcagent.sh
chmod 755 $installdir/jcagent.sh

#INSTALLING THE AGENT FROM JUMPCLOUD
echo -e "\n 2) Installing the Jumpcloud agent"
$installdir/jcagent.sh

#Cleaning up
#rm -rf $installdir
