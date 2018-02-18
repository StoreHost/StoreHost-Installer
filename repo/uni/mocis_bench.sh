#!/bin/bash
# $Id: mixedgauge,v 1.7 2010/01/13 10:20:03 tom Exp $
#: ${DIALOG=dialog}
: ${DIALOG=dialog --no-lines}
: ${DIALOG_OK=0}
: ${DIALOG_CANCEL=1}
: ${DIALOG_HELP=2}
: ${DIALOG_EXTRA=3}
: ${DIALOG_ITEM_HELP=4}
: ${DIALOG_ESC=255}

: ${SIG_NONE=0}
: ${SIG_HUP=1}
: ${SIG_INT=2}
: ${SIG_QUIT=3}
: ${SIG_KILL=9}
: ${SIG_TERM=15}
do_network=0
do_io=0
do_cpu=0
network_1=0
network_2=0
network_3=0
network_4=0
network_5=0
network_6=0
network_7=0
network_8=0
network_9=0
network_10=0
network_11=0
network_12=0
network_13=0
network_14=0
network_15=0
network_16=0
network_17=0
network_18=0
network_19=0
network_20=0
network_21=0
sysupdate="started"
systeminfo="preparing"
netspeed="classified"
datatest="classified"
cpubench="classified"

############################################################
# Installation von "dialog --no-lines"
#

if [ -d "/etc/apt" ]; then
	pmgr=apt
fi
if [ -d "/etc/yum" ]; then
	pmgr=yum
fi

if [ $pmgr == "apt" ]; then
	apt-get install dialog curl -y
fi
if [ $pmgr == "yum" ]; then
	yum install dialog curl -y
fi


############################################################
# Men�
#

cmd=(dialog --no-lines --separate-output --checklist "Please choose your preference" 22 76 16)
options=(1 "Systeminformation" on
         2 "Network Benchmark" on
         3 "I/O Performance" on
         4 "CPU Benchmark" on)
main=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $main
do
    case $choice in
        1)
			do_informations=1
            ;;
        2)
			cmd=(dialog --no-lines --separate-output --checklist "Please choose the network servers" 22 76 16)
			options=(1  "OVH (FR)" on
					 2  "IP-Projects (DE)" on
					 3  "combahton (DE)" on
					 4  "meerfabig (DE)" off
					 5  "myloc (DE)" on
					 6  "FSIT (CH)" off
					 7  "Leaseweb (DE)" off
					 8  "Leaseweb (US)" off
					 9  "Leaseweb (NL)" off
					 10  "Leaseweb (SG)" off
					 11  "Softlayer (NL)" off
					 12 "Softlayer (CN)" off
					 13 "Softlayer (GB)" off
					 14 "Softlayer (JP)" off
					 15 "Softlayer (US)" off
					 16 "Softlayer (CA)" off
					 17 "Softlayer (DE)" off
					 18 "EDIS (AT)" off
					 19 "Linode (DE)" off
					 20 "CacheFly (CDN)" off
					 21 "Cloudflare (CDN)" off
					 22 "Mocis (DE) 100MB" on
					 23 "Mocis (DE) 1GB" on
					)
			network=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
			clear
			for choice in $network
			do
				case $choice in
					1)
						network_1=1
						;;
					2)
						network_2=1
						;;
					3)
						network_3=1
						;;
					4)
						network_4=1
						;;
					5)
						network_5=1
						;;
					6)
						network_6=1
						;;
					7)
						network_7=1
						;;
					8)
						network_8=1
						;;
					9)
						network_9=1
						;;
					10)
						network_10=1
						;;
					11)
						network_11=1
						;;
					12)
						network_12=1
						;;
					13)
						network_13=1
						;;
					14)
						network_14=1
						;;
					15)
						network_15=1
						;;
					16)
						network_16=1
						;;
					17)
						network_17=1
						;;
					18)
						network_18=1
						;;
					19)
						network_19=1
						;;
					20)
						network_20=1
						;;
					21)
						network_21=1
						;;
					22)
						network_22=1
						;;
					23)
						network_23=1
						;;
				esac
			done
			do_network=1
            ;;
        3)
            do_io=1
            ;;
        4)
			dialog --no-lines --yesno "Um den CPU Benchmark ausfuehren zu koennen, muss ein Programm namens 'bc' installiert werden. Soll der CPU Benchmark nach wie vor ausgefuehrt und das Programm installiert werden?" 0 0
			choice=$?
			clear
			if [ $choice = 0 ]
			then
			   do_cpu=1
			else
			  echo " "
			fi
            ;;
    esac
done

############################
# Mixedgauge for the Update
#
for i in 5 10 20 30 40 50 60 70 80 90 100
do
$DIALOG \
  --colors --title "Benchmark Overview" \
	--mixedgauge "Tipp: \nAn updated Operatingsystem is more worth than no Operatingsystem." \
		0 0 10 \
    "Updating System"	  "$sysupdate" \
        ""		          "8" \
		"systeminformations"	  "$systeminfo" \
    ""		          "8" \
		"Network Benchmark"	  "$netspeed" \
    ""  		        "8" \
		"Data storage"	"$datatest" \
    ""          		"8" \
		"CPU Benchmark"	"$cpubench" \
		""		"8" \

done
############################
# Loop for updateing the System --> "Mixedgauge Update"
#
sysupdate=0
until [ $sysupdate -gt 0 ]
do
  ((sysupdate++))
  apt-get update -y > /dev/null
  apt-get upgrade -y > /dev/null

  echo "all updated and upgraded"
done
sysupdate=0
############################
# Mixedgauge for systeminformations Start /SysUpdate Done
#
systeminfo="starting"
for i in 5 10 20 30 40 50 60 70 80 90 100
do
$DIALOG \
  --colors --title "Benchmark Overview" \
	--mixedgauge "This is a prompt message,\nand this is the second line." \
		0 0 25 \
    "Updating System"	  "$sysupdate" \
        ""		          "8" \
		"systeminformations"	  "$systeminfo" \
    ""		          "8" \
		"Network Benchmark"	  "$netspeed" \
    ""  		        "8" \
		"Data storage"	"$datatest" \
    ""          		"8" \
		"CPU Benchmark"	"$cpubench" \
		""		"8" \

done
############################
# Loop to get the systeminformations --> Gauge systeminformations
#
systeminfo=0
until [ $systeminfo -gt 0 ]
do
  ((systeminfo++))
  cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
  cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
  freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
  tram=$( free -m | awk 'NR==2 {print $2}' )
  swap=$( free -m | awk 'NR==4 {print $2}' )
  up=$(uptime|awk '{ $1=$2=$(NF-6)=$(NF-5)=$(NF-4)=$(NF-3)=$(NF-2)=$(NF-1)=$NF=""; print }')
  sleep 2

done
if [ $core >= 1 ]; then
systeminfo=0
echo "$swap"
else
 systeminfo="failed"
fi
sleep 1
############################
# Mixedgauge for Networktest Start / Systeminformation Done
#
netspeed="starting"
for i in 5 10 20 30 40 50 60 70 80 90 100
do
$DIALOG \
  --colors --title "Benchmark Overview" \
	--mixedgauge "This is a prompt message,\nand this is the second line." \
		0 0 35 \
    "Updating System"	  "$sysupdate" \
        ""		          "8" \
		"systeminformations"	  "$systeminfo" \
    ""		          "8" \
		"Network Benchmark"	  "$netspeed" \
    ""  		        "8" \
		"Data storage"	"$datatest" \
    ""          		"8" \
		"CPU Benchmark"	"$cpubench" \
		""		"8" \

done
############################
# Loop to get the Networkspeedtest --> Gauge systeminformations
#
netspeed=0
until [ $netspeed -gt 0 ]
do
  ((netspeed++))
  if [ $do_network = 1 ]; then

  #OVH (DE)
  if [ $network_1 = 1 ]
  then
    result1=$( wget -O /dev/null http://proof.ovh.net/files/100Mb.dat 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
    echo -e "\033[36mOVH(FR) - \033[33m100MB Testfile \033[0m: $result1" > /dev/null
    echo "OVH-FR%20100MB:%20$result1§" >> net.tmp
  fi

  #IP Projects (DE)
  if [ $network_2 = 1 ]
  then
    result2=$( wget -O /dev/null http://lg.ip-projects.de/100MB.test 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
    echo -e "\033[36mIP-Projects(DE) - \033[33m100MB Testfile \033[0m: $result2" > /dev/null
    echo "IP-Project-DE%20100MB:%20$result2§" >> net.tmp
  fi

  #combahton (DE)
  if [ $network_3 = 1 ]
  then
    result3=$( wget -O /dev/null http://lg.combahton.net/100MB.test 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
    echo -e "\033[36mcombahton(DE) - \033[33m100MB Testfile \033[0m: $result" > /dev/null
    echo "combahton-DE%20100MB:%20$result§" >> net.tmp
  fi

  #meerfabig (DE)
  if [ $network_4 = 1 ]
  then
    result4=$( wget -O /dev/null http://mirror.meerfarbig.io/testfiles/1G 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
    echo -e "\033[36mmeerfabig(DE) - \033[33m1GB Testfile \033[0m: $result" > /dev/null
    echo "mmeerfabig-DE%201GB:%20$result§" >> net.tmp
  fi

  #myloc (DE)
  if [ $network_5 = 1 ]
  then
    result=$( wget -O /dev/null http://speed.myloc.de/100MB.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
    echo -e "\033[36mmyloc(DE) - \033[33m100MB Testfile \033[0m: $result" > /dev/null
    echo "myloc-DE%20100MB:%20$result§" >> net.tmp
  fi

  #FSIT (CH)
  if [ $network_6 = 1 ]
  then
    result=$( wget -O /dev/null http://fsit.ch/speed/100mebibyte.dat 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
    echo -e "\033[36mFSIT(CH) - \033[33m100MB Testfile \033[0m: $result" > /dev/null
    echo "FSIT-CH%20100MB:%20$result§" >> net.tmp
  fi

  #Leaseweb (DE)
  if [ $network_7 = 1 ]
  then
    result=$( wget -O /dev/null http://mirror.de.leaseweb.net/speedtest/100mb.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
    echo -e "\033[36mLeaseweb(DE) - \033[33m100MB Testfile \033[0m: $result" > /dev/null
    echo "Leaseweb-DE%20100MB:%20$result§" >> net.tmp
  fi

  #Leaseweb (US)
  if [ $network_8 = 1 ]
  then
    result=$( wget -O /dev/null http://mirror.us.leaseweb.net/speedtest/100mb.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
    echo -e "\033[36mLeaseweb(US) - \033[33m100MB Testfile \033[0m: $result" > /dev/null
    echo "Leaseweb-US%20100MB:%20$result§" >> net.tmp
  fi

  #Leaseweb (NL)
  if [ $network_9 = 1 ]
  then
    result=$( wget -O /dev/null http://mirror.nl.leaseweb.net/speedtest/100mb.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
    echo -e "\033[36mLeaseweb(NL) - \033[33m100MB Testfile \033[0m: $result" > /dev/null
    echo "Leaseweb-NL%20100MB:%20$result§" >> net.tmp
  fi

  #Leaseweb (SG)
  if [ $network_10 = 1 ]
  then
    result=$( wget -O /dev/null http://mirror.sg.leaseweb.net/speedtest/100mb.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
    echo -e "\033[36mLeaseweb(SG) - \033[33m100MB Testfile \033[0m: $result" > /dev/null
    echo "Leaseweb-SG%20100MB:%20$result§" >> net.tmp
  fi

  #Softlayer (NL)
  if [ $network_11 = 1 ]
  then
    result=$( wget -O /dev/null http://speedtest.ams01.softlayer.com/downloads/test100.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
    echo -e "\033[36mSoftlayer(NL) - \033[33m100MB Testfile \033[0m: $result" > /dev/null
    echo "Softlayer-NL%20100MB:%20$result§" >> net.tmp
  fi

  #Softlayer (CN)
  if [ $network_12 = 1 ]
  then
    result=$( wget -O /dev/null http://speedtest.hkg02.softlayer.com/downloads/test100.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
    echo -e "\033[36mSoftlayer(CN) - \033[33m100MB Testfile \033[0m: $result" > /dev/null
    echo "Softlayer-CN%20100MB:%20$result§" >> net.tmp
  fi

  #Softlayer (GB)
  if [ $network_13 = 1 ]
  then
    result=$( wget -O /dev/null http://speedtest.lon02.softlayer.com/downloads/test100.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
    echo -e "\033[36mSoftlayer(GB) - \033[33m100MB Testfile \033[0m: $result" > /dev/null
    echo "Softlayer-GB%20100MB:%20$result§" >> net.tmp
  fi

  #Softlayer (JP)
  if [ $network_14 = 1 ]
  then
    result=$( wget -O /dev/null http://speedtest.tok02.softlayer.com/downloads/test100.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
    echo -e "\033[36mSoftlayer(JP) - \033[33m100MB Testfile \033[0m: $result" > /dev/null
    echo "Softlayer-JP%20100MB:%20$result§" >> net.tmp
  fi

  #Softlayer (US)
  if [ $network_15 = 1 ]
  then
    result=$( wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test100.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
    echo -e "\033[36mSoftlayer(US) - \033[33m100MB Testfile \033[0m: $result" > /dev/null
    echo "Softlayer-US%20100MB:%20$result§" >> net.tmp
  fi

  #Softlayer (CA)
  if [ $network_16 = 1 ]
  then
    result=$( wget -O /dev/null http://speedtest.tor01.softlayer.com/downloads/test100.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
    echo -e "\033[36mSoftlayer(CA) - \033[33m100MB Testfile \033[0m: $result" > /dev/null
    echo "Softlayer-CA%20100MB:%20$result§" >> net.tmp
  fi

  #Softlayer (DE)
  if [ $network_17 = 1 ]
  then
    result=$( wget -O /dev/null http://speedtest.fra02.softlayer.com/downloads/test100.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
    echo -e "\033[36mSoftlayer(DE) - \033[33m100MB Testfile \033[0m: $result" > /dev/null
    echo "Softlayer-DE%20100MB:%20$result§" >> net.tmp
  fi

  #EDIS (AT)
  if [ $network_18 = 1 ]
  then
    result=$( wget -O /dev/null http://at.edis.at/100MB.test 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
    echo -e "\033[36mEDIS(AT) - \033[33m100MB Testfile \033[0m: $result" > /dev/null
    echo "EDIS-AT%20100MB:%20$result§" >> net.tmp
  fi

  #Linode Frankfurt (DE)
  if [ $network_19 = 1 ]
  then
    result=$( wget -O /dev/null http://speedtest.frankfurt.linode.com/100MB-frankfurt.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
    echo -e "\033[36mLinode Frankfurt(DE) - \033[33m100MB Testfile \033[0m: $result" > /dev/null
    echo "Linode-DE%20100MB:%20$result§" >> net.tmp
  fi

  #CacheFly CDN
  if [ $network_20 = 1 ]
  then
    result=$( wget -O /dev/null http://cachefly.cachefly.net/100mb.test 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
    echo -e "\033[36mCacheFly CDN - \033[33m100MB Testfile \033[0m: $result" > /dev/null
    echo "ChacheFly-CND%20100MB:%20$result§" >> net.tmp
  fi

  #Cloudflare CDN
  if [ $network_21 = 1 ]
  then
    result=$( wget -O /dev/null http://playground.host/mini/speedtest/funny.jpg 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
    echo -e "\033[36mCloudflare CDN - \033[33m100MB Testfile \033[0m: $result" > /dev/null
    echo "Cloudflare-CDN%20100MB:%20$result§" >> net.tmp
  fi

  #Mocis 100MB
  if [ $network_22 = 1 ]; then
    result=$( wget -O /dev/null http://100mb.mocis.sh/100MB.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
    echo -e "\033[36mMocis DE - \033[33m100MB Testfile \033[0m: $result" > /dev/null
    echo "Mocis-DE%20100MB:%20$result§" >> net.tmp
  fi

  #Mocis 1GB
  if [ $network_23 = 1 ]; then
    result=$( wget -O /dev/null http://1gb.mocis.sh/1GB.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
    echo -e "\033[36mMocis DE - \033[33m1GB Testfile \033[0m: $result" > /dev/null
    echo "Mocis-DE%201GB:%20$result§" >> net.tmp
  fi
fi

done
if [ $do_network = 1 ]; then
  netspeed=0
fi
if [ $do_network = 0 ]; then
  netspeed=2
fi
############################
# Mixedgauge for Networktest completed /Start Data Bench
#
datatest="starting"
for i in 5 10 20 30 40 50 60 70 80 90 100
do
$DIALOG \
  --colors --title "Benchmark Overview" \
	--mixedgauge "This is a prompt message,\nand this is the second line." \
		0 0 50 \
    "Updating System"	  "$sysupdate" \
        ""		          "8" \
		"systeminformations"	  "$systeminfo" \
    ""		          "8" \
		"Network Benchmark"	  "$netspeed" \
    ""  		        "8" \
		"Data storage"	"$datatest" \
    ""          		"8" \
		"CPU Benchmark"	"$cpubench" \
		""		"8" \

done
############################
# Loop to get Data speed
#
datatest=0
until [ $datatest -gt 0 ]
do
  ((datatest++))
  if [ $do_io = 1 ]
  then
      io1=$( ( dd if=/dev/zero of=io-test bs=16k count=64k conv=fdatasync && rm -f io-test ) 2>&1 | awk -Fs, '{io=$NF} END { print io}' )
      echo -e "\033[36mI/O Performance [1]:\033[0m $io1" > /dev/null
      io2=$( ( dd if=/dev/zero of=io-test bs=16k count=64k && rm -f io-test ) 2>&1 | awk -Fs, '{io=$NF} END { print io}' )
      echo -e "\033[36mI/O Performance [2]:\033[0m $io2" > /dev/null
      io3=$( ( dd if=/dev/zero of=io-test bs=64k count=16k conv=fdatasync && rm -f io-test ) 2>&1 | awk -Fs, '{io=$NF} END { print io}' )
      echo -e "\033[36mI/O Performance [3]:\033[0m $io3" > /dev/null
      io4=$( ( dd if=/dev/zero of=io-test bs=64k count=16k && rm -f io-test ) 2>&1 | awk -Fs, '{io=$NF} END { print io}' )
      echo -e "\033[36mI/O Performance [4]:\033[0m $io4" > /dev/null
      echo ""
  fi
done
if [[ $do_io = 1 ]]; then
  datatest=0
fi
if [[ $do_io = 0 ]]; then
  datatest=2
fi
cpubench="starting"
uploadbench="preparing"
############################
# Mixedgauge for Data Done / Start CPU Bench
#
for i in 5 10 20 30 40 50 60 70 80 90 100
do
$DIALOG \
  --colors --title "Benchmark Overview" \
	--mixedgauge "This is a prompt message,\nand this is the second line." \
		0 0 65 \
    "Updating System"	  "$sysupdate" \
        ""		          "8" \
		"systeminformations"	  "$systeminfo" \
    ""		          "8" \
		"Network Benchmark"	  "$netspeed" \
    ""  		        "8" \
		"Data storage"	"$datatest" \
    ""          		"8" \
		"CPU Benchmark"	"$cpubench" \
		""		"8" \
    "Uploading Benchmark"	"$cpubench" \
    ""		"8" \

done
############################
# Loop to get CPU Bench
#
if [ $do_cpu = 1 ]; then
  echo ""
  echo -e "\033[35mCPU Benchmark\033[0m"
	time echo "scale=4000; a(1)*4" | erg=$(bc -l)
  echo ""
  echo ""
	cpubench=0
fi
if [ $do_cpu = 0 ]; then
  cpubench=2
fi
############################
# Mixedgauge for CPU Bench Done / Start Upload
#

for i in 5 10 20 30 40 50 60 70 80 90 100
do
$DIALOG \
  --colors --title "Benchmark Overview" \
	--mixedgauge "This is a prompt message,\nand this is the second line." \
		0 0 90 \
    "Updating System"	  "$sysupdate" \
        ""		          "8" \
		"systeminformations"	  "$systeminfo" \
    ""		          "8" \
		"Network Benchmark"	  "$netspeed" \
    ""  		        "8" \
		"Data storage"	"$datatest" \
    ""          		"8" \
		"CPU Benchmark"	"$cpubench" \
		""		"8" \
    "Uploading Benchmark"	"$uploadbench" \
    ""		"8" \

done
############################
# Loop to get CPU Bench
#
uploadbench=0
#####################
#	CPU-Benchmark
#
cpuname=$cname
CPUNAME=${cpuname// /'%'20}
cpufreq=$freq
CPUFREQ="$(echo -e "${cpufreq}" | tr -d '[:space:]')"

swap2=$swap
SWAP="$(echo -e "${swap2}" | tr -d '[:space:]')"
echo "$SWAP"
####################
# Data-Benchmark
#
io1fin=$io1
IO1FIN="$(echo -e "${io1fin}" | tr -d '[:space:]')"
echo -e "CPUFREQ='${IO1FIN}'" > /dev/null
IOTEST1="Synchronous%20test%20/%20block%20size%2016k%20/%2064,000%20%20%20transits:$IO1FIN"
io2fin=$io2
IO2FIN="$(echo -e "${io2fin}" | tr -d '[:space:]')"
echo -e "CPUFREQ='${IO2FIN}'" > /dev/null
IOTEST2="Asynchronous%20test%20/%20block%20size%2016k%20/%2064,000%20transits:$IO2FIN"
io3fin=$io3
IO3FIN="$(echo -e "${io3fin}" | tr -d '[:space:]')"
echo -e "CPUFREQ='${IO3FIN}'" > /dev/null
IOTEST3="Synchronous%20test%20/%20block%20size%2064k%20/%2016,000%20%20%20transits:$IO3FIN"
io4fin=$io4
IO4FIN="$(echo -e "${io4fin}" | tr -d '[:space:]')"
echo -e "CPUFREQ='${IO4FIN}'" > /dev/null
IOTEST4="Aynchronous%20test%20/%20block%20size%2064k%20/%2016,000%20%20%20transits:$IO4FIN"
#####################
#	Network Benchmark
#
networking=$(sed -e ':a' -e 'N' -e '$!ba' -e 's/\n//g' net.tmp) > /dev/null
echo  "$networking" > /dev/null

#####################
#	Give it to the API
#
curlresponse=$(curl https://api.tjbn.de/imggen/?text=This%20Benchmark%20is%20generated%20by%20Mocis\.sh§§'*'CPU-Benchmark§§Processor:%20$CPUNAME§Cores:%20$cores§MHz:%20$CPUFREQ§Memory:%20$tram%20MB§§'*'Network%20Benchmark§§$networking§'*'Data%20Benchmark§§$IOTEST1§$IOTEST2§$IOTEST3§$IOTEST4) > /dev/null

rm net.tmp
############################
# Mixedgauge for CPU Bench Done / Start Upload
#
uploadbench=0
for i in 5 10 20 30 40 50 60 70 80 90 100
do
$DIALOG \
  --colors --title "Benchmark Overview" \
	--mixedgauge "This is a prompt message,\nand this is the second line." \
		0 0 100 \
    "Updating System"	  "$sysupdate" \
        ""		          "8" \
		"systeminformations"	  "$systeminfo" \
    ""		          "8" \
		"Network Benchmark"	  "$netspeed" \
    ""  		        "8" \
		"Data storage"	"$datatest" \
    ""          		"8" \
		"CPU Benchmark"	"$cpubench" \
		""		"8" \
    "Uploading Benchmark"	"$uploadbench" \
    ""		"8" \

done
sleep 3
clear
echo "$curlresponse"
dialog --no-lines --colors --no-collapse --backtitle "[ M.O.C.I.S ]" --title "Benchmark Result" --msgbox "Please Check your Benchmark under:\n\n\Z8$curlresponse\Zn" 10 70
echo "$curlresponse"
sleep 5
