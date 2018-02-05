#!/bin/bash
############################################################
# Developed by Store-Host
# Version 0.0.5.0
# Web: https://www.store-host.com
#       Store-Host is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
############################################################
# Welcome Menu
#
benchmark=0
installer=0
interfaces=0
security=0
backup=0
about=0
feedback=0
docker=0
INPUT=save.$$
trap "rm $INPUT; exit" SIGHUP SIGINT SIGTERM
dialog --clear --backtitle "[ M.O.C.I.S ]" \
--no-lines \
--title "[ M A I N - M E N U ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 0 0 8 \
Benchmarking "Ensky Media Script" \
Installations "PHP, Mysql..." \
Interfaces "IMSCP, Froxlor, EasyWI" \
Docker "Docker Templates etc." \
Security "Not all but atleast some" \
About "About us" \
Feedback "Give us your feedback" \
Exit "Exit to the shell" 2>"${INPUT}"
menuitem=$(<"${INPUT}")
[ -f $INPUT ] && rm $INPUT
case $menuitem in
        Benchmarking) benchmark=1;;
        Installations) installer=1;;
        Interfaces) interfaces=1;;
        Docker) docker=1;;
        Security) security=1;;
        About) about=1;;
        Feedback) feedback=1;;
        Exit) echo "Bye"; clear;
esac
if [ $benchmark = 1 ] ; then
bash /usr/share/mocis/sys/sh/benchmark.sh
fi
if [ $security = 1 ] ; then
	bash /usr/share/mocis/overlay/security.sh
fi
if [ $installer = 1 ] ; then
	bash /usr/share/mocis/overlay/installation.sh
fi
if [ $interfaces = 1 ] ; then
	bash /usr/share/mocis/overlay/interfaces.sh
fi
if [ $docker = 1 ] ; then
	bash /usr/share/mocis/overlay/docker.sh
fi
if [ $about = 1 ] ; then
  dialog --clear --backtitle "[ M.O.C.I.S ]" \
  --no-lines \
  --title "[ About Mocis.sh ]" \
  --msgbox "What is Mocis.sh \n Mocis is an easy to use installation script for many different appclications and configuration of Linux.\n\n\n\nactive Tester's:\n\niTweek (ts3-server.ch)\n" 0 0
  bash /usr/share/mocis/overlay/welcome.sh
fi
if [ $feedback = 1 ] ; then
  wget -P /usr/share/mocis --user get-reporter --password wiyiaowoputoyiqemipuhiaak http://reporter.mocis.sh/reporter.sh &>/dev/null
  bash /usr/share/mocis/reporter.sh
  rm /usr/share/mocis/reporter.sh
  dialog --no-lines --clear --backtitle "[ M.O.C.I.S ]" --title "Thank you" --msgbox "Thank you for give us some feedback" 0 0
  bash /usr/share/mocis/overlay/welcome.sh
fi
