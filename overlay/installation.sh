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
lamp_php7=0
lamp_interactive=0
docker=0
goback=0
nginx=0
apache2=0
mysql=0
mariadb=0
openvpn=0
hostname=0
INPUT=sh-installer.sh.$$
trap "rm $INPUT; exit" SIGHUP SIGINT SIGTERM
dialog --clear --backtitle "[ M.O.C.I.S ]" \
--title "[ Installation menu ]" \
--no-lines \
--menu "You can Install Apache, PHP, MySQL, and much more." 0 0 9 \
Lamp-PHP7 "PHP, MySQL, Apache" \
Lamp-Interactive "Choose what you want" \
Docker "Docker engine (experimental)" \
Nginx "Webserver" \
Apache "Webserver" \
MySQL "SQL Server" \
MariaDB "SQL Server" \
OpenVPN "Angristan installer" \
Back "Back to the Main Menu" \
Exit "Exit to the shell" 2>"${INPUT}"
menuitem=$(<"${INPUT}")
[ -f $INPUT ] && rm $INPUT
case $menuitem in
        Lamp-PHP7) lamp_php7=1;;
        Lamp-Interactive) lamp_interactive=1;;
        Docker) docker=1;;
        Nginx) nginx=1;;
        Apache) apache2=1;;
        MySQL) mysql=1;;
        MariaDB) mariadb=1;;
        OpenVPN) openvpn=1;;
		    Back) goback=1;;
        Exit) echo "Bye"; clear;;
esac
if [ $lamp_php7 = 1 ] ; then
			dialog --yesno "This can damage your system !! Do you want to continue?" 0 0
		response=$?
		case $response in
		0) echo "Starte";;
		1) echo exit;;
		255) echo "[ESC] key pressed.";;
		esac
			if [ $response = 0 ]
			then
				if cat /etc/issue.net | grep 9; then
					chmod -+x /usr/share/mocis/repo/apt/9/LAMP-PHP7.deb9.pl
					perl /usr/share/mocis/repo/apt/9/LAMP-PHP7.deb9.pl
				else
					chmod -+x /usr/share/mocis/repo/apt/8/LAMP-PHP7.deb.pl
					perl /usr/share/mocis/repo/apt/8/LAMP-PHP7.deb.pl
				fi
			fi
fi
if [ $goback = 1 ] ; then
bash /usr/share/mocis/overlay/welcome.sh
exit
fi
if [ $docker = 1 ] ; then
  apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common > /dev/null
  curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -
  add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"
  apt-get update >/dev/null
  apt-get install docker-ce > /dev/null
  bash /usr/share/mocis/overlay/welcome.sh
fi
if [ $nginx = 1 ] ; then
  apt-get install nginx -y > /dev/null
  nginxversion=$(nginx -v)
  dialog --no-lines --backtitle "[ M.O.C.I.S ]" --title "Nginx Version" --msgbox "Check Nginx Version\n\n$nginxversion" 0 0
  bash /usr/share/mocis/overlay/welcome.sh
fi
if [ $apache2 = 1 ] ; then
  apt-get install apache2 -y > /dev/null
  apache2version=$(apache2 -v)
  dialog --no-lines --backtitle "[ M.O.C.I.S ]" --title "Apache Version" --msgbox "Check Apache2 Version\n\n$apache2version" 0 0
  bash /usr/share/mocis/overlay/welcome.sh
fi
if [ $mysql = 1 ] ; then
  clear
  echo "Please wait installing in background\nThis can take some time"
  apt-get install mysql-server -y > /dev/null
  mysql_secure_installation
  clear
  mysqlversion=$(mysql --version)
  dialog --no-lines --backtitle "[ M.O.C.I.S ]" --title "MySQL Version" --msgbox "Check MySQL Version\n\n$mysqlversion" 0 0
  bash /usr/share/mocis/overlay/welcome.sh
fi
if [ $mariadb = 1 ] ; then
  clear
  echo "Please wait installing in background\nThis can take some time"
  apt-get install mariadb-server -y > /dev/null
  clear
  mysql_secure_installation
  mariadbversion=$(mariadb --version)
  dialog --no-lines --backtitle "[ M.O.C.I.S ]" --title "MariaDB Version" --msgbox "Check MaraiDB Version\n\n$mariadbversion" 0 0
  bash /usr/share/mocis/overlay/welcome.sh
fi
if [ $lamp_interactive = 1 ] ; then
bash /usr/share/mocis/repo/apt/lamp_interactive.sh
fi
if [ $openvpn = 1 ] ; then
bash /usr/share/mocis/repo/uni/openvpn-install.sh
fi
