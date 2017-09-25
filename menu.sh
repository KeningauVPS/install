#!/bin/bash
myip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
myint=`ifconfig | grep -B1 "inet addr:$myip" | head -n1 | awk '{print $1}'`;

 red='\e[1;31m'
               green='\e[0;32m'
               NC='\e[0m'

               echo "Connecting to @Orangkuatsabahan..."
			   sleep 1

			   echo "Connecting to your ip : $myip ...."
               sleep 2
               
			   echo "Checking Permision..."
               sleep 1.5
               
			   echo -e "${green}Permission Accepted...${NC}"
               sleep 1

function create_user() {
	useradd -M $uname
	echo "$uname:$pass" | chpasswd
	usermod -e $expdate $uname

	
function renew_user() {
	echo "New expiration date for $uname: $expdate...";
	usermod -e $expdate $uname
}

function delete_user(){
	userdel $uname
}

function expired_users(){
	cat /etc/shadow | cut -d: -f1,8 | sed /:$/d > /tmp/expirelist.txt
	totalaccounts=`cat /tmp/expirelist.txt | wc -l`
	for((i=1; i<=$totalaccounts; i++ )); do
		tuserval=`head -n $i /tmp/expirelist.txt | tail -n 1`
		username=`echo $tuserval | cut -f1 -d:`
		userexp=`echo $tuserval | cut -f2 -d:`
		userexpireinseconds=$(( $userexp * 86400 ))
		todaystime=`date +%s`
		if [ $userexpireinseconds -lt $todaystime ] ; then
			echo $username
		fi
	done
	rm /tmp/expirelist.txt
}

function not_expired_users(){
    cat /etc/shadow | cut -d: -f1,8 | sed /:$/d > /tmp/expirelist.txt
    totalaccounts=`cat /tmp/expirelist.txt | wc -l`
    for((i=1; i<=$totalaccounts; i++ )); do
        tuserval=`head -n $i /tmp/expirelist.txt | tail -n 1`
        username=`echo $tuserval | cut -f1 -d:`
        userexp=`echo $tuserval | cut -f2 -d:`
        userexpireinseconds=$(( $userexp * 86400 ))
        todaystime=`date +%s`
        if [ $userexpireinseconds -gt $todaystime ] ; then
            echo $username
        fi
    done
	rm /tmp/expirelist.txt
}

function used_data(){
	myip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`
	myint=`ifconfig | grep -B1 "inet addr:$myip" | head -n1 | awk '{print $1}'`
	ifconfig $myint | grep "RX bytes" | sed -e 's/ *RX [a-z:0-9]*/Received: /g' | sed -e 's/TX [a-z:0-9]*/\nTransfered: /g'
}

	clear
	echo "--------------- Selamat datang Admin Di IP: $myip ---------------"
	cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
	cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
	freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
	tram=$( free -m | awk 'NR==2 {print $2}' )
	swap=$( free -m | awk 'NR==4 {print $2}' )
	up=$(uptime|awk '{ $1=$2=$(NF-6)=$(NF-5)=$(NF-4)=$(NF-3)=$(NF-2)=$(NF-1)=$NF=""; print }')

	echo -e "\e[032;1mCPU model:\e[0m $cname"
	echo -e "\e[032;1mNumber of cores:\e[0m $cores"
	echo -e "\e[032;1mCPU frequency:\e[0m $freq MHz"
	echo -e "\e[032;1mTotal amount of ram:\e[0m $tram MB"
	echo -e "\e[032;1mTotal amount of swap:\e[0m $swap MB"
	echo -e "\e[032;1mSystem uptime:\e[0m $up"
	echo -e "\e[032;1mScript by:\e[0m Rasta-Team.net | http://rasta-team.net/"
	echo "------------------------------------------------------------------------------"
	echo " SSH & OpenVPN"
	echo -e "\e[031;1m 1\e[0m) Buat Akun SSH/OpenVPN (\e[035;1muser-add\e[0m)"
	echo -e "\e[031;1m 2\e[0m) Generate Akun SSH/OpenVPN (\e[035;1muser-gen\e[0m)"
	echo -e "\e[031;1m 3\e[0m) Generate Akun Trial (\e[035;1muser-trial\e[0m)"
	echo -e "\e[031;1m 4\e[0m) Ganti Password Akun SSH/VPN (\e[035;1muser-pass\e[0m)"
	echo -e "\e[031;1m 5\e[0m) Tambah Masa Aktif Akun SSH/OpenVPN (\e[035;1muser-renew\e[0m)"
	echo -e "\e[031;1m 6\e[0m) Hapus Akun SSH/OpenVPN (\e[34;1muser-del\e[0m)"
	echo -e "\e[031;1m 7\e[0m) Cek Login Dropbear & OpenSSH (\e[34;1muser-login\e[0m)"
	echo -e "\e[031;1m 8\e[0m) Auto Limit Multi Login (\e[34;1mauto-limit\e[0m)"
	echo -e "\e[031;1m 9\e[0m) Melihat detail user SSH & OpenVPN (\e[34;1muser-detail\e[0m)"
	echo -e "\e[031;1m10\e[0m) Daftar Akun dan Expire Date (\e[34;1muser-list\e[0m)"
	echo -e "\e[031;1m11\e[0m) Delete Akun Expire (\e[34;1mdelete-user-expire\e[0m)"
	echo -e "\e[031;1m12\e[0m) Kill Multi Login (\e[34;1mauto-kill-user\e[0m)"
	echo -e "\e[031;1m13\e[0m) Auto Banned Akun (\e[34;1mbanned-user\e[0m)"
	echo -e "\e[031;1m14\e[0m) Unbanned Akun (\e[34;1munbanned-user\e[0m)"
	echo -e "\e[031;1m15\e[0m) Mengunci Akun SSH & OpenVPN (\e[34;1muser-lock\e[0m)"
	echo -e "\e[031;1m16\e[0m) Membuka user SSH & OpenVPN yang terkunci (\e[34;1muser-unlock\e[0m)"
	echo -e "\e[031;1m17\e[0m) Melihat daftar user yang terkick oleh perintah user-limit (\e[34;1mlog-limit\e[0m)"
	echo -e "\e[031;1m18\e[0m) Melihat daftar user yang terbanned oleh perintah user-ban (\e[34;1mlog-ban\e[0m)"
	echo "PPTP VPN"
	echo -e "\e[031;1m19\e[0m) Buat Akun PPTP VPN (\e[34;1muser-add-pptp\e[0m)"
	echo -e "\e[031;1m20\e[0m) Hapus Akun PPTP VPN (\e[34;1muser-delete-pptp\e[0m)"
	echo -e "\e[031;1m21\e[0m) Lihat Detail Akun PPTP VPN (\e[34;1mdetail-pptp\e[0m)"
	echo -e "\e[031;1m22\e[0m) Cek login PPTP VPN (\e[34;1muser-login-pptp\e[0m)"
	echo -e "\e[031;1m23\e[0m) Lihat Daftar User PPTP VPN (\e[34;1malluser-pptp\e[0m)"
	echo -e "\e[031;1m24\e[0m) Set Auto Reboot (\e[34;1mauto-reboot\e[0m)"
	echo -e "\e[031;1m25\e[0m) Speedtest (\e[34;1mcek-speedttes-vps\e[0m)"
	echo -e "\e[031;1m26\e[0m) Memory Usage (\e[34;1mps-mem\e[0m)"
	echo -e "\e[031;1m27\e[0m) Change OpenVPN Port (\e[34;1mchange-openvpn-port\e[0m)"
	echo -e "\e[031;1m28\e[0m) Change Dropbear Port (\e[34;1mchange-dropbear-port\e[0m)"
	echo -e "\e[031;1m29\e[0m) Change Squid Port (\e[34;1mchange-squid-port\e[0m)"
	echo -e "\e[031;1m30\e[0m) Restart OpenVPN (\e[34;1mrestart-openvpn\e[0m)"
	echo -e "\e[031;1m31\e[0m) Restart Dropbear (\e[34;1mrestart-dropbear\e[0m)"
	echo -e "\e[031;1m32\e[0m) Restart Squid (\e[34;1mrestart-squid\e[0m)"
	echo -e "\e[031;1m33\e[0m) Restart Webmin (\e[34;1mrestart-webmin\e[0m)"
	echo -e "\e[031;1m34\e[0m) Benchmark (\e[34;1mbenchmark\e[0m)"
	echo -e "\e[031;1m35\e[0m) Ubah Pasword VPS (\e[34;1mpassword\e[0m)"
	echo -e "\e[031;1m36\e[0m) Ubah Hostname VPS (\e[34;1mhostname\e[0m)"
	echo -e "\e[031;1m37\e[0m) Reboot Server (\e[34;1mreboot\e[0m)"
	echo ""
	echo "Update Premium Script"
	echo -e "\e[031;1m38\e[0m) Update Now (\e[34;1mupdate\e[0m)"
	echo ""
	echo -e "\e[031;1m x\e[0m) Exit"
	read -p "Masukkan pilihan anda, kemudian tekan tombol ENTER: " option1
	case $option1 in
        1)  
            clear
            buatakun
            ;;
        2)  
            clear
            generate
            ;;
        3)	
            clear
            trial
			;;	
        4)
            clear
            userpass
            ;;
        5)
            clear
            userrenew
			;;
        6)
            userdelete
            ;;		
		7)
		    clear
	        userlogin
			;;
		8)
		    clear
			autolimit
			;;	
		9)
		    clear
            userdetail
            ;;
		10)
		    clear
            user-list
            ;;
        11)
               clear
               deleteuserexpire
	          ;;
	    12)
	          clear
	          #!/bin/bash
              # Created by @orangkuatsabahanterkini
              
              red='\e[1;31m'
              green='\e[0;32m'
              NC='\e[0m'
              echo "Connecting to @orangkuatsabahan...."
              sleep 0.2
			  echo "Connecting to your ip : $myip ...."
              sleep 2
              echo "Checking Permision..."
              sleep 0.3
              echo -e "${green}Permission Accepted...${NC}"
              sleep 1
               echo""
	           echo "    AUTO KILL MULTI LOGIN    "    
	           echo "-----------------------------"
               autokilluser
               echo "-----------------------------"
               echo "AUTO KILL MULTI LOGIN SELESAI"
               ;;
        13)
               clear
               userban
	          ;;
	    14)
               clear
               userunban
	          ;;
	    15)
	        clear
            userlock
			;;
		16)
		    clear
            userunlock
			;;
		17)
		    clear
		    loglimit
			;;
		18)
		    clear
            logban
			;;
	    19)
	        clear
            useraddpptp
			;;
		20)
		    clear
            userdeletepptp
			;;
	    21)
	        clear
            detailpptp
            ;;
        22)
            clear
            userloginpptp
			;;
		23)
		    clear
            alluserpptp
			;;
	    24)
	         clear
             autoreboot
            ;;
	    25)
	         clear
	         #!/bin/bash
            red='\e[1;31m'
            green='\e[0;32m'
            blue='\e[1;34m'
            NC='\e[0m'
            echo "Connecting to autoscriptnobita.tk..."
            sleep 0.2
			echo "Connecting to your ip : $myip ...."
            sleep 2
            echo "Checking Permision..."
            sleep 0.3
            echo -e "${green}Permission Accepted...${NC}"
            sleep 1
            echo""
            echo "Speed Test Server"
            ./speedtest.py --share
            echo "Hasil Speed test diatas Script by @orangkuatsabahan.tk"
            ;;
        26)
            free -m
            ;;
		27)	
		    clear
            echo "Masukan Port OpenVPN yang diinginkan:"
            read -p "Port: " -e -i 1194 PORT
            sed -i "s/port [0-9]*/port $PORT/" /etc/openvpn/1194.conf
            service openvpn restart
            echo "OpenVPN Updated : Port $PORT"
			;;
		28)	
		    clear
            echo "Masukan Port Dropbear yang diinginkan:"
            read -p "Port: " -e -i 443 PORT
            sed -i "s/DROPBEAR_PORT=[0-9]*/DROPBEAR_PORT=$PORT/" /etc/default/dropbear
            service dropbear restart
            echo "Dropbear Updated : Port $PORT"
			;;
        29)	
            clear
            echo "Masukan Port Squid yang diinginkan:"
            read -p "Port: " -e -i 8080 PORT
            sed -i "s/http_port [0-9]*/http_port $PORT/" /etc/squid3/squid.conf
            service squid3 restart
            echo "echo "Squid3 Updated : Port $PORT""
			;;			
        30)	
            clear
            echo "Service Openvpn restart .................tunggu sebentar"
            service openvpn restart
            echo "Restart OpenVPN selesai Script By @orangkuatsabahan"
			;;	
		31)
            clear
            echo "Servie dropbear restart .................tunggu sebentar"
            service dropbear restart
            echo "Restart Dropbear selesai Script By @orangkuatsabahan"
            ;;
		32) 
		    clear
		    echo "Service Squid restart .................tunggu sebentar"
			service squid3 restart
			echo "Restart Squid selesai Script By @orangkuatsabahan"
			;;
		33)
		    clear
		    /etc/init.d/webmin restart
		    echo "Restart Webmin selesai Script By @orangkuatsabahan"
		    ;;
		34)
		    clear
            wget freevps.us/downloads/bench.sh -O - -o /dev/null|bash
           ;;
        35)
		    echo "Masukan Password VPS, yang mau diganti :"
		    passwd
			;;	
		36)
			echo "Masukan HOSTNAME VPS, yang mau diganti :"
            echo "  contoh : " hostname @orangkuatsabahan
            ;;
		37)
		    clear
			reboot
            ;;
        38)
            wget
			;;
        x)
            ;;
        *) menu;;
    esac
