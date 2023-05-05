#!/bin/bash
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export LANG=en_US.UTF-8
wpygV="23.5.4 V 0.9.9 "
remoteV=`wget -qO- https://gitlab.com/en_project/CFwrap_en/-/raw/main/CFwrap.sh | sed -n 4p | cut -d '"' -f 2`
chmod +x /root/CFwarp.sh
red='\033[0;31m'
bblue='\033[0;34m'
yellow='\033[0;33m'
green='\033[0;32m'
plain='\033[0m'
red(){ echo -e "\033[31m\033[01m$1\033[0m";}
green(){ echo -e "\033[32m\033[01m$1\033[0m";}
yellow(){ echo -e "\033[33m\033[01m$1\033[0m";}
blue(){ echo -e "\033[36m\033[01m$1\033[0m";}
white(){ echo -e "\033[37m\033[01m$1\033[0m";}
bblue(){ echo -e "\033[34m\033[01m$1\033[0m";}
rred(){ echo -e "\033[35m\033[01m$1\033[0m";}
readtp(){ read -t5 -n26 -p "$(yellow "$1")" $2;}
readp(){ read -p "$(yellow "$1")" $2;}
[[ $EUID -ne 0 ]] && yellow "Please run the script as root" && exit
#[[ -e /etc/hosts ]] && grep -qE '^ *172.65.251.78 gitlab.com' /etc/hosts || echo -e '\n172.65.251.78 gitlab.com' >> /etc/ hosts
yellow "Please wait a moment... Scanning vps types and parameters..."
if [[ -f /etc/redhat-release ]]; then
release="Centos"
elif cat /etc/issue | grep -q -E -i "debian"; then
release="Debian"
elif cat /etc/issue | grep -q -E -i "ubuntu"; then
release="Ubuntu"
elif cat /etc/issue | grep -q -E -i "centos|red hat|redhat"; then
release="Centos"
elif cat /proc/version | grep -q -E -i "debian"; then
release="Debian"
elif cat /proc/version | grep -q -E -i "ubuntu"; then
release="Ubuntu"
elif cat /proc/version | grep -q -E -i "centos|red hat|redhat"; then
release="Centos"
else
red "Your current system is not supported, please choose to use Ubuntu, Debian, Centos system." && rm -f CFwarp.sh && exit
the fi
vsid=`grep -i version_id /etc/os-release | cut -d \" -f2 | cut -d . -f1`
sys(){
[ -f /etc/os-release ] && grep -i pretty_name /etc/os-release | cut -d \" -f2 && return
[ -f /etc/lsb-release ] && grep -i description /etc/lsb-release | cut -d \" -f2 && return
[ -f /etc/redhat-release ] && awk '{print $0}' /etc/redhat-release && return;}
op=`sys`
version=`uname -r | awk -F "-" '{print $1}'`
main=`uname -r | awk -F . '{print $1}'`
minor=`uname -r | awk -F . '{print $2}'`
vi=`systemd-detect-virt`
cpujg(){
bit=`uname -m`
if [[ $bit = aarch64 ]]; then
cpu=arm64
elif [[ $bit = x86_64 ]]; then
cpu=amd64
else
red "The current script does not support the $bit architecture" && exit
the fi
}

if [[ $vi = openvz ]]; then
TUN=$(cat /dev/net/tun 2>&1)
if [[ ! $TUN =~ 'in bad state' ]] && [[ ! $TUN =~ 'in bad state' ]] && [[ ! $TUN =~ 'Die Dateizugriffsnummer ist in schlechter Verfassung' ]]; then
red "Detected that TUN is not enabled, now try to add TUN support" && sleep 4
cd /dev
mkdir net
mknod net/tun c 10 200
chmod 0666 net /tun
TUN=$(cat /dev/net/tun 2>&1)
if [[ ! $TUN =~ 'in bad state' ]] && [[ ! $TUN =~ 'in bad state' ]] && [[ ! $TUN =~ 'Die Dateizugriffsnummer ist in schlechter Verfassung' ]]; then
green "Failed to add TUN support, it is recommended to communicate with the VPS manufacturer or enable the background setting" && exit
else
cat <
     /root/tun.sh
#!/bin/bash
cd /dev
mkdir net
mknod net/tun c 10 200
chmod 0666 net /tun
EOF
chmod +x /root/tun.sh
grep -qE "^ *@reboot root bash /root/tun.sh >/dev/null 2>&1" /etc/crontab || echo "@reboot root bash /root/tun.sh >/dev/null 2> &1" >> /etc/crontab
green "TUN daemon function started"
the fi
the fi
the fi

[[ $(type -P yum) ]] && yumapt='yum -y' || yumapt='apt -y'
if [[ ! $(type -P curl) ]]; then
$yumapt update;$yumapt install curl
the fi
if [[ ! $(type -P bc) ]]; then
$yumapt update;$yumapt install bc
the fi
if [[ ! $(type -P qrencode) ]]; then
$yumapt update;$yumapt install qrencode
the fi
if [[ ! $(type -P python3) ]]; then
$yumapt update;$yumapt install python3
the fi
if [[ ! $(type -P screen) ]]; then
$yumapt update;$yumapt install screen
the fi
if [[ ! $(type -P yum) ]]; then
if [[ ! $(type -P cron) ]]; then
$yumapt update;$yumapt install cron
the fi
else
$yumapt update;$yumapt install cronie
the fi

nf4() {
result=`curl --connect-timeout 5 -4sSL "https://www.netflix.com/" 2>&1`
[ "$result" == "Not Available" ] && NF="Give up, Netflix does not serve the current IP region" && return
[[ "$result" == "curl"* ]] && NF="Error, unable to connect to Netflix official website" && return
result=`curl -4sL "https://www.netflix.com/title/80018499" 2>&1`
[[ "$result" == *"page-404"* || "$result" == *"NSEZ-403"* ]] && NF="Crap, current IP cannot watch Netflix" && return
result1=`curl -4sL "https://www.netflix.com/title/70143836" 2>&1`
result2=`curl -4sL "https://www.netflix.com/title/80027042" 2>&1`
result3=`curl -4sL "https://www.netflix.com/title/70140425" 2>&1`
result4=`curl -4sL "https://www.netflix.com/title/70283261" 2>&1`
result5=`curl -4sL "https://www.netflix.com/title/70143860" 2>&1`
result6=`curl -4sL "https://www.netflix.com/title/70202589" 2>&1`
[[ "$result1" == *"page-404"* && "$result2" == *"page-404"* && "$result3" == *"page-404"* && "$result4" == *"page-404"* && "$result5" == *"page-404"* && "$result6" == *"page-404"* ]] && NF="Unfortunately, the current IP can only watch Netflix homemade drama" && return
NF="Congratulations, the current IP supports watching Netflix non-self-produced dramas" && return
}

nf6() {
result=`curl --connect-timeout 5 -6sSL "https://www.netflix.com/" 2>&1`
[ "$result" == "Not Available" ] && NF="Give up, Netflix does not serve the current IP region" && return
[[ "$result" == "curl"* ]] && NF="Error, unable to connect to Netflix official website" && return
result=`curl -6sL "https://www.netflix.com/title/80018499" 2>&1`
[[ "$result" == *"page-404"* || "$result" == *"NSEZ-403"* ]] && NF="Crap, current IP cannot watch Netflix" && return
result1=`curl -6sL "https://www.netflix.com/title/70143836" 2>&1`
result2=`curl -6sL "https://www.netflix.com/title/80027042" 2>&1`
result3=`curl -6sL "https://www.netflix.com/title/70140425" 2>&1`
result4=`curl -6sL "https://www.netflix.com/title/70283261" 2>&1`
result5=`curl -6sL "https://www.netflix.com/title/70143860" 2>&1`
result6=`curl -6sL "https://www.netflix.com/title/70202589" 2>&1`
[[ "$result1" == *"page-404"* && "$result2" == *"page-404"* && "$result3" == *"page-404"* && "$result4" == *"page-404"* && "$result5" == *"page-404"* && "$result6" == *"page-404"* ]] && NF="Unfortunately, the current IP can only watch Netflix homemade drama" && return
NF="Congratulations, the current IP supports watching Netflix non-self-produced dramas" && return
}

nfs5() {
result=`curl -sx socks5h://localhost:$mport --connect-timeout 5 -4sSL "https://www.netflix.com/" 2>&1`
[ "$result" == "Not Available" ] && NF="Give up, Netflix does not serve the current IP region" && return
[[ "$result" == "curl"* ]] && NF="Error, unable to connect to Netflix official website" && return
result=`curl -sx socks5h://localhost:$mport -4sL "https://www.netflix.com/title/80018499" 2>&1`
[[ "$result" == *"page-404"* || "$result" == *"NSEZ-403"* ]] && NF="Crap, current IP cannot watch Netflix" && return
result1=`curl -sx socks5h://localhost:$mport -4sL "https://www.netflix.com/title/70143836" 2>&1`
result2=`curl -sx socks5h://localhost:$mport -4sL "https://www.netflix.com/title/80027042" 2>&1`
result3=`curl -sx socks5h://localhost:$mport -4sL "https://www.netflix.com/title/70140425" 2>&1`
result4=`curl -sx socks5h://localhost:$mport -4sL "https://www.netflix.com/title/70283261" 2>&1`
result5=`curl -sx socks5h://localhost:$mport -4sL "https://www.netflix.com/title/70143860" 2>&1`
result6=`curl -sx socks5h://localhost:$mport -4sL "https://www.netflix.com/title/70202589" 2>&1`
[[ "$result1" == *"page-404"* && "$result2" == *"page-404"* && "$result3" == *"page-404"* && "$result4" == *"page-404"* && "$result5" == *"page-404"* && "$result6" == *"page-404"* ]] && NF="Unfortunately, the current IP can only watch Netflix homemade drama" && return
NF="Congratulations, the current IP supports watching Netflix non-self-produced dramas" && return
}

v4v6(){
v4=$(curl -s4m6 ip.sb -k)
v6=$(curl -s6m6 ip.sb -k)
#v6=$(curl -s6m6 api64.ipify.org -k)
#v4=$(curl -s4m6 api64.ipify.org -k)
}

checkwgcf(){
wgcfv6=$(curl -s6m6 https://www.cloudflare.com/cdn-cgi/trace -k | grep warp | cut -d= -f2)
wgcfv4=$(curl -s4m6 https://www.cloudflare.com/cdn-cgi/trace -k | grep warp | cut -d= -f2)
}

warpip(){
checkpt(){
mkdir -p /root/warpip
if [[ ! -f '/root/warpip/result.csv' ]]; then
cpujg
v4v6
if [[ -z $v4 ]]; then
wget -qO /root/warpip/ip.txt https://gitlab.com/rwkgyg/CFwarp/raw/main/point/ip6.txt
else
wget -qO /root/warpip/ip.txt https://gitlab.com/rwkgyg/CFwarp/raw/main/point/ip.txt
the fi
wget -qO /root/warpip/$cpu https://gitlab.com/rwkgyg/CFwarp/raw/main/point/cpu/$cpu && chmod +x /root/warpip/$cpu
cd /root/warpip
./$cpu >/dev/null 2>&1 &
wait
cd
a=`cat /root/warpip/result.csv | awk -F, '$3!="timeout ms" {print} ' | sed -n '2p' | awk -F ',' '{print $2}'`
if [[ $a = 100.00% ]]; then
rm -rf /root/warpip/*
if [[ -z $v4 ]]; then
n=0
	iplist=100
	while true
	do
		temp[$n]=$(echo [2606:4700:d0::$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n ' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n ' $(($RANDOM*2+$RANDOM%2)))])
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		the fi
		temp[$n]=$(echo [2606:4700:d1::$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n ' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n ' $(($RANDOM*2+$RANDOM%2)))])
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		the fi
	done
	while true
	do
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo [2606:4700:d0::$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n ' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n ' $(($RANDOM*2+$RANDOM%2)))])
			n=$[$n+1]
		the fi
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo [2606:4700:d1::$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n ' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n ' $(($RANDOM*2+$RANDOM%2)))])
			n=$[$n+1]
		the fi
	done
else
	n=0
	iplist=100
	while true
	do
		temp[$n]=$(echo 162.159.192.$(($RANDOM%256)))
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		the fi
		temp[$n]=$(echo 162.159.193.$(($RANDOM%256)))
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		the fi
		temp[$n]=$(echo 162.159.195.$(($RANDOM%256)))
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		the fi
		temp[$n]=$(echo 188.114.96.$(($RANDOM%256)))
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		the fi
		temp[$n]=$(echo 188.114.97.$(($RANDOM%256)))
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		the fi
		temp[$n]=$(echo 188.114.98.$(($RANDOM%256)))
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		the fi
		temp[$n]=$(echo 188.114.99.$(($RANDOM%256)))
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		the fi
	done
	while true
	do
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo 162.159.192.$(($RANDOM%256)))
			n=$[$n+1]
		the fi
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo 162.159.193.$(($RANDOM%256)))
			n=$[$n+1]
		the fi
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo 162.159.195.$(($RANDOM%256)))
			n=$[$n+1]
		the fi
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo 188.114.96.$(($RANDOM%256)))
			n=$[$n+1]
		the fi
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo 188.114.97.$(($RANDOM%256)))
			n=$[$n+1]
		the fi
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo 188.114.98.$(($RANDOM%256)))
			n=$[$n+1]
		the fi
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo 188.114.99.$(($RANDOM%256)))
			n=$[$n+1]
		the fi
	done
the fi
echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u>/root/warpip/ip.txt
wget -qO /root/warpip/$cpu https://gitlab.com/rwkgyg/CFwarp/raw/main/point/$cpu && chmod +x /root/warpip/$cpu
cd /root/warpip
./$cpu >/dev/null 2>&1 &
wait
cd
a=`cat /root/warpip/result.csv | awk -F, '$3!="timeout ms" {print} ' | sed -n '2p' | awk -F ',' '{print $2}'`
if [[ $a = 100.00% ]]; then
rm -rf /root/warpip/*
if [[ -z $v4 ]]; then
export endpoint=[2606:4700:d0::a29f:c001]:2408
else
export endpoint=162.159.193.10:1701
the fi
red "Attention, VPS failed to select warp peer IP address, warp application may fail, temporary address: $endpoint"
else
export endpoint=`cat /root/warpip/result.csv | awk -F, '$3!="timeout ms" {print} ' | sed -n '2p' | awk -F ',' '{print $1}' `
green "The script will automatically apply the preferred warp peer IP address of the local VPS: $endpoint"
the fi
else
export endpoint=`cat /root/warpip/result.csv | awk -F, '$3!="timeout ms" {print} ' | sed -n '2p' | awk -F ',' '{print $1}' `
green "The script will automatically apply the preferred warp peer IP address of the local VPS: $endpoint"
the fi
else
a=`cat /root/warpip/result.csv | awk -F, '$3!="timeout ms" {print} ' | sed -n '2p' | awk -F ',' '{print $2}'`
if [[ $a = 100.00% ]]; then
if [[ -z $v4 ]]; then
export endpoint=[2606:4700:d0::a29f:c001]:2408
else
export endpoint=162.159.193.10:1701
the fi
red "Attention, VPS failed to select warp peer IP address, warp application may fail, temporary address: $endpoint"
else
export endpoint=`cat /root/warpip/result.csv | awk -F, '$3!="timeout ms" {print} ' | sed -n '2p' | awk -F ',' '{print $1}' `
green "The script will automatically apply the preferred warp peer IP address of the local VPS: $endpoint"
the fi
the fi
}

checkwgcf
if [[ ! $wgcfv4 =~ on|plus && ! $wgcfv6 =~ on|plus ]]; then
checkpt
else
systemctl stop wg-quick@wgcf >/dev/null 2>&1
kill -15 $(pgrep warp-go) >/dev/null 2>&1 && sleep 2
checkpt
systemctl start wg-quick@wgcf >/dev/null 2>&1
systemctl restart warp-go >/dev/null 2>&1
systemctl enable warp-go >/dev/null 2>&1
systemctl start warp-go >/dev/null 2>&1
the fi
}
warpip

dig9(){
if [[ -n $(grep 'DiG 9' /etc/hosts) ]]; then
echo -e "search blue.kundencontroller.de\noptions rotate\nnameserver 2a02:180:6:5::1c\nnameserver 2a02:180:6:5::4\nnameserver 2a02:180:6:5::1e\ nnameserver 2a02:180:6:5::1d" > /etc/resolv.conf
the fi
}

mtuwarp(){
v4v6
yellow "Start automatically setting the warp's MTU optimal network throughput value to optimize the WARP network!"
MTUy=1500
MTUc=10
if [[ -n $v6 && -z $v4 ]]; then
ping='ping6'
IP1='2606:4700:4700::1111'
IP2='2001:4860:4860::8888'
else
ping='ping'
IP1='1.1.1.1'
IP2='8.8.8.8'
the fi
while true; do
if ${ping} -c1 -W1 -s$((${MTUy} - 28)) -Mdo ${IP1} >/dev/null 2>&1 || ${ping} -c1 -W1 -s$( (${MTUy} - 28)) -Mdo ${IP2} >/dev/null 2>&1; then
MTUc=1
MTUy=$((${MTUy} + ${MTUc}))
else
MTUy=$((${MTUy} - ${MTUc}))
[[ ${MTUc} = 1 ]] && break
the fi
[[ ${MTUy} -le 1360 ]] && MTUy='1360' && break
done
MTU=$((${MTUy} - 80))
green "MTU optimal network throughput value = $MTU has been set"
}

xyz(){
if [[ -n $(screen -ls | grep '(Attached)' | awk '{print $1}' | awk -F "." '{print $1}') ]]; then
until [[ -z $(screen -ls | grep '(Attached)' | awk '{print $1}' | awk -F "." '{print $1}' | awk 'NR==1{print}') ]]
do
Attached=`screen -ls | grep '(Attached)' | awk '{print $1}' | awk -F "." '{print $1}' | awk 'NR==1{print}'`
screen -d $Attached
done
the fi
if [[ -e /root/WARP-UP.sh ]]; then
screen -ls | awk '/\.up/ {print $1}' | cut -d "." -f 1 | xargs kill 2>/dev/null ; screen -UdmS up bash -c '/bin/bash /root /WARP-UP.sh'
else
green "Install warp online monitoring daemon"
cat>/root/WARP-UP.sh<<-\EOF
#!/bin/bash
red(){ echo -e "\033[31m\033[01m$1\033[0m";}
green(){ echo -e "\033[32m\033[01m$1\033[0m";}
sleep 10
checkwgcf(){
wgcfv6=$(curl -s6m6 https://www.cloudflare.com/cdn-cgi/trace -k | grep warp | cut -d= -f2)
wgcfv4=$(curl -s4m6 https://www.cloudflare.com/cdn-cgi/trace -k | grep warp | cut -d= -f2)
}
warpclose(){
wg-quick down wgcf >/dev/null 2>&1;systemctl stop wg-quick@wgcf >/dev/null 2>&1;systemctl disable wg-quick@wgcf >/dev/null 2>&1;kill -15 $ (pgrep warp-go) >/dev/null 2>&1; systemctl stop warp-go >/dev/null 2>&1; systemctl disable warp-go >/dev/null 2>&1
}
warpopen(){
wg-quick down wgcf >/dev/null 2>&1;systemctl enable wg-quick@wgcf >/dev/null 2>&1;systemctl start wg-quick@wgcf >/dev/null 2>&1;systemctl restart wg- quick@wgcf >/dev/null 2>&1;kill -15 $(pgrep warp-go) >/dev/null 2>&1;systemctl stop warp-go >/dev/null 2>&1;systemctl enable warp-go >/dev/null 2>&1;systemctl start warp-go >/dev/null 2>&1;systemctl restart warp-go >/dev/null 2>&1
}
warpre(){
i=0
while [ $i -le 4 ]; do let i++
warp open
checkwgcf
[[ $wgcfv4 =~ on|plus || $wgcfv6 =~ on|plus ]] && green "The interrupted warp tried to obtain an IP successfully!" && break || red "The interrupted warp failed to obtain an IP!"
done
checkwgcf
if [[ ! $wgcfv4 =~ on|plus && ! $wgcfv6 =~ on|plus ]]; then
warpclose
red "Due to 5 failed attempts to obtain the IP of the warp, the execution is now stopped and the warp is closed, and the VPS returns to the original IP state"
the fi
}
while true; do
green "Detecting whether the warp is starting..."
wp=$(cat /root/warpip/wp.log)
if [[ $wp = w4 ]]; then
checkwgcf
[[ $wgcfv4 =~ on|plus ]] && green "Congratulations! WARP IPV4 status is running! The next round of detection will be automatically executed in 60 seconds" && sleep 60s || (warpre ; green "The next round of detection will be performed after 50 seconds Automatically execute after seconds" ; sleep 50s)
elif [[ $wp = w6 ]]; then
checkwgcf
[[ $wgcfv6 =~ on|plus ]] && green "Congratulations! WARP IPV6 status is running! The next round of detection will be automatically executed in 60 seconds" && sleep 60s || (warpre ; green "The next round of detection will be performed after 50 seconds Automatically execute after seconds" ; sleep 50s)
else
checkwgcf
[[ $wgcfv4 =~ on|plus && $wgcfv6 =~ on|plus ]] && green "Congratulations! WARP IPV4+IPV6 status is running! The next round of detection will be automatically executed in 60 seconds" && sleep 60s || ( warpre ; green "The next round of detection will be executed automatically after 50 seconds" ; sleep 50s)
the fi
done
EOF
#readp "When the warp state is running, re-detect the warp state interval (enter the default 60 seconds), please enter the interval (for example: 50 seconds, enter 50):" stop
#[[ -n $stop ]] && sed -i "s/60s/${stop}s/g;s/60s/${stop}s/g" /root/WARP-UP.sh || green "default interval 60 seconds"
#readp "When the warp state is interrupted (5 consecutive failures to automatically close the warp), continue to detect the WARP state interval time (enter the default 50 seconds), please enter the interval time (for example: 50 seconds, enter 50):" goon
#[[ -n $goon ]] && sed -i "s/50s/${goon}s/g;s/50s/${goon}s/g" /root/WARP-UP.sh || green "default interval 50 seconds"
[[ -e /root/WARP-UP.sh ]] && screen -ls | awk '/\.up/ {print $1}' | cut -d "." -f 1 | xargs kill 2>/dev/null ; screen -UdmS up bash -c '/bin/bash /root/WARP-UP.sh'
the fi
}

first4(){
checkwgcf
if [[ $wgcfv4 =~ on|plus && -z $wgcfv6 ]]; then
[[ -e /etc/gai.conf ]] && grep -qE '^ *precedence ::ffff:0:0/96 100' /etc/gai.conf || echo 'precedence ::ffff:0:0/ 96 100' >> /etc/gai.conf 2>/dev/null
sed -i '/^label 2002::\/16 2/d' /etc/gai.conf 2>/dev/null
else
sed -i '/^precedence ::ffff:0:0\/96 100/d;/^label 2002::\/16 2/d' /etc/gai.conf 2>/dev/null
the fi
}

docker(){
if [[ -n $(ip a | grep docker) ]]; then
red "It is detected that docker has been installed on the VPS. If you continue to install WARP in Solution 1, docker will fail"
red "In order to avoid docker failure, it is recommended to use the second or third option"
sleep 3s
yellow "Continue to install the WARP of Solution 1 after 6 seconds, please press Ctrl+c to exit the installation"
sleep 6s
the fi
}

uncf(){
if [[ -z $(type -P warp-go) && -z $(type -P wg-quick) && -z $(type -P warp-cli) ]]; then
rm -rf /root/CFwarp.sh /usr/bin/cf
the fi
}

upcfwarp(){
wget -N https://gitlab.com/en_project/CFwrap_en/-/raw/main/CFwrap.sh
chmod +x /root/CFwarp.sh
ln -sf /root/CFwarp.sh /usr/bin/cf
green "CFwarp installation script upgraded successfully" && cf
}

cso(){
warp-cli --accept-tos disconnect >/dev/null 2>&1
warp-cli --accept-tos disable-always-on >/dev/null 2>&1
warp-cli --accept-tos delete >/dev/null 2>&1
if [[ $release = Centos ]]; then
yum autoremove cloudflare-warp -y
else
apt purge cloudflare-warp -y
rm -f /etc/apt/sources.list.d/cloudflare-client.list /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg
the fi
$yumapt autoremove
}

lncf(){
if [[ -n $(type -P warp-go) || -n $(type -P warp-cli) || -n $(type -P wg-quick) ]]; then
chmod +x /root/CFwarp.sh
ln -sf /root/CFwarp.sh /usr/bin/cf
the fi
}

WARPtools(){
green "1. View WARP online monitoring (please pay attention before entering! Exit and continue to execute the monitoring command: ctrl+a+d, exit and close the monitoring command: ctrl+c)"
green "2. Restart WARP online monitoring function"
green "3. Brush warp+flow"
readp "Please select:" warptools
if [[ $warptools == 1 ]]; then
name=`screen -ls | grep '(Detached)' | awk '{print $1}' | awk -F "." '{print $2}'`
if [[ $name =~ "up" ]]; then
screen -Ur up
else
red "WARP monitoring function is not enabled, please choose 2 to restart" && WARPtools
the fi
elif [[ $warptools == 2 ]]; then
xyz
name=`screen -ls | grep '(Detached)' | awk '{print $1}' | awk -F "." '{print $2}'`
[[ $name =~ "up" ]] && green "WARP online monitoring started successfully" || red "WARP online monitoring failed to start, check whether the screen is installed successfully"
elif [[ $warptools == 3 ]]; then
wget -N https://gitlab.com/en_project/CFwrap_en/-/raw/main/wp-plus.py
sed -i "27 s/[(][^)]*[)]//g" wp-plus.py
readp "Client configuration ID (36 characters):" ID
sed -i "27 s/input/'$ID'/" wp-plus.py
python3 wp-plus.py
else
WARPtools
the fi
}

ShowSOCKS5(){
if [[ $(systemctl is-active warp-svc) = active ]]; then
mport=`warp-cli --accept-tos settings 2>/dev/null | grep 'WarpProxy on port' | awk -F "port " '{print $2}'`
s5ip=`curl -sx socks5h://localhost:$mport ip.sb -k`
nfs5
#NF=$(./nf -proxy socks5h://localhost:$mport | awk '{print $1}' | sed -n '3p')
[[ $(curl -sx socks5h://localhost:$mport https://chat.openai.com/ -I | grep "text/plain") != "" ]] && chat='Unfortunately, the current IP cannot Visit ChatGPT official website service' || chat='Congratulations, the current IP supports access to ChatGPT official website service'
isp4a=`curl -sx socks5h://localhost:$mport --user-agent "${UA_Browser}" http://ip-api.com/json/$v4?lang=zh-CN -k | cut - f13 -d ":" | cut -f2 -d '"'`
isp4b=`curl -sx socks5h://localhost:$mport --user-agent "${UA_Browser}" https://api.ip.sb/geoip/$v4 -k | awk -F "isp" '{ print $2}' | awk -F "offset" '{print $1}' | sed "s/[,\":]//g"`
[[ -n $isp4a ]] && isp4=$isp4a || isp4=$isp4b
nonf=$(curl -sx socks5h://localhost:$mport --user-agent "${UA_Browser}" http://ip-api.com/json/$v4?lang=zh-CN -k | cut -f2 -d"," | cut -f4 -d '"')
#sunf=$(./nf | awk '{print $1}' | sed -n '4p')
#snnf=$(curl -sx socks5h://localhost:$mport ip.p3terx.com -k | sed -n 2p | awk '{print $3}')
country=$nonf
socks5=$(curl -sx socks5h://localhost:$mport www.cloudflare.com/cdn-cgi/trace -k --connect-timeout 2 | grep warp | cut -d= -f2)
case ${socks5} in
plus)
S5Status=$(white "Socks5 WARP+ status:\c" ; rred "Running, WARP+ common account (remaining WARP+ traffic: $((`warp-cli --accept-tos account | grep Quota | awk '{ print $( NF) }'`/1000000000))GiB)" ; white "Socks5 port:\c" ; rred "$mport" ; white "IPV4 address obtained by service provider Cloudflare:\c" ; rred "$s5ip $country" ; white " Netflix NF unlocking situation:\c" ; rred "$NF" ; white " ChatGPT unlocking situation:\c" ; rred "$chat");;  
on)
S5Status=$(white "Socks5 WARP status:\c" ; green "Running, WARP common account (unlimited WARP traffic)" ; white "Socks5 port:\c" ; green "$mport" ; white "Obtained by service provider Cloudflare IPV4 address: \c" ; green "$s5ip $country" ; white "Netflix NF unlocking situation:\c" ; green "$NF" ; white "ChatGPT unlocking situation:\c" ; green "$chat"); ;  
*)
S5Status=$(white "Socks5 WARP status:\c" ; yellow "Socks5-WARP client is installed, but the port is closed")
esac
else
S5Status=$(white "Socks5 WARP status:\c" ; red "Socks5-WARP client not installed")
the fi
}

SOCKS5ins(){
yellow "Detect Socks5-WARP installation environment..."
if [[ $release = Centos ]]; then
[[ ! ${vsid} =~ 8 ]] && yellow "Current system version number: Centos $vsid \nSocks5-WARP only supports Centos 8 " && bash CFwarp.sh
elif [[ $release = Ubuntu ]]; then
[[ ! ${vsid} =~ 20|22 ]] && yellow "Current system version number: Ubuntu $vsid \nSocks5-WARP only supports Ubuntu 20.04/22.04 system" && bash CFwarp.sh
elif [[ $release = Debian ]]; then
[[ ! ${vsid} =~ 10|11 ]] && yellow "Current system version number: Debian $vsid \nSocks5-WARP only supports Debian 10/11 system" && bash CFwarp.sh
the fi
[[ $(warp-cli --accept-tos status 2>/dev/null) =~ 'Connected' ]] && red "Currently Socks5-WARP is running" && bash CFwarp.sh

systemctl stop wg-quick@wgcf >/dev/null 2>&1
kill -15 $(pgrep warp-go) >/dev/null 2>&1 && sleep 2
v4v6
if [[ -n $v6 && -z $v4 ]]; then
systemctl start wg-quick@wgcf >/dev/null 2>&1
systemctl restart warp-go >/dev/null 2>&1
systemctl enable warp-go >/dev/null 2>&1
systemctl start warp-go >/dev/null 2>&1
red "Pure IPV6 VPS currently does not support the installation of Socks5-WARP" && sleep 2 && bash CFwarp.sh
else
systemctl restart warp-go >/dev/null 2>&1
systemctl enable warp-go >/dev/null 2>&1
systemctl start warp-go >/dev/null 2>&1
#elif [[ -n $v4 && -z $v6 ]]; then
#systemctl start wg-quick@wgcf >/dev/null 2>&1
#checkwgcf
#[[ $wgcfv4 =~ on|plus ]] && red "Pure IPV4 VPS has installed Wgcf-WARP-IPV4, does not support the installation of Socks5-WARP" && bash CFwarp.sh
#elif [[ -n $v4 && -n $v6 ]]; then
#systemctl start wg-quick@wgcf >/dev/null 2>&1
#checkwgcf
#[[ $wgcfv4 =~ on|plus || $wgcfv6 =~ on|plus ]] && red "Native dual-stack VPS has installed Wgcf-WARP-IPV4/IPV6, please uninstall first. Then install Socks5-WARP, and finally install Wgcf-WARP-IPV4/IPV6" && bash CFwarp.sh
the fi
#systemctl start wg-quick@wgcf >/dev/null 2>&1
#checkwgcf
#if [[ $wgcfv4 =~ on|plus && $wgcfv6 =~ on|plus ]]; then
#red "Wgcf-WARP-IPV4+IPV6 has been installed, Socks5-WARP is not supported" && bash CFwarp.sh
#fi
if [[ $release = Centos ]]; then
if [[ ${vsid} =~ 8 ]]; then
cd /etc/yum.repos.d/ && mkdir backup && mv *repo backup/
curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-8.repo
sed -i -e "s|mirrors.cloud.aliyuncs.com|mirrors.aliyun.com|g " /etc/yum.repos.d/CentOS-*
sed -i -e "s|releasever|releasever-stream|g" /etc/yum.repos.d/CentOS-*
yum clean all && yum makecache
the fi
yum -y install epel-release && yum -y install net-tools
rpm -ivh https://pkg.cloudflareclient.com/cloudflare-release-el8.rpm
yum -y install cloudflare-warp
the fi
if [[ $release = Debian ]]; then
[[ ! $(type -P gpg) ]] && apt update && apt install gnupg -y
[[ ! $(apt list 2>/dev/null | grep apt-transport-https | grep installed) ]] && apt update && apt install apt-transport-https -y
the fi
if [[ $release != Centos ]]; then
apt install net-tools -y
curl https://pkg.cloudflareclient.com/pubkey.gpg | gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] http://pkg.cloudflareclient.com/ $(lsb_release -sc) main" | tee /etc /apt/sources.list.d/cloudflare-client.list
apt update; apt install cloudflare-warp -y
the fi
warpip
warp-cli --accept-tos register >/dev/null 2>&1 && sleep 2
warp-cli --accept-tos set-mode proxy >/dev/null 2>&1
warp-cli --accept-tos set-custom-endpoint "$endpoint" >/dev/null 2>&1
warp-cli --accept-tos enable-always-on >/dev/null 2>&1
sleep 2 && ShowSOCKS5 && S5menu && lncf && reswarp
}

WGCFmenu(){
name=`screen -ls | grep '(Detached)' | awk '{print $1}' | awk -F "." '{print $2}'`
[[ $name =~ "up" ]] && keepup="WARP monitoring is on" || keepup="WARP monitoring is off"
white "------------------------------------------------ ------------------------------------"
white "Scheme 1: The current situation of IPV4 taking over outbound traffic is as follows ($keepup)"
white " ${WARPIPv4Status}"
white "------------------------------------------------ ------------------------------------"
white "Scheme 1: The current IPV6 takeover of outbound traffic is as follows ($keepup)"
white " ${WARPIPv6Status}"
white "------------------------------------------------ ------------------------------------"
if [[ "$WARPIPv4Status" == *does not exist* && "$WARPIPv6Status" == *does not exist* ]]; then
yellow "Currently both IPV4 and IPV6 are recognized as non-existent! It is recommended to choose 4 to uninstall first, and then use wgcf or warp-go to reinstall Solution 1, whichever is successful!"
the fi
}
S5menu(){
white "------------------------------------------------ ------------------------------------------------"
white "Scheme 2: The current situation of local agent of Socks5-WARP official client is as follows"
blue " ${S5Status}"
white "------------------------------------------------ ------------------------------------------------"
}

IP_Status_menu(){
WGCFmenu;S5menu
}

reswarp(){
unreswarp
crontab -l > /tmp/crontab.tmp
echo "0 4 * * * systemctl stop warp-go;systemctl restart warp-go;systemctl restart wg-quick@wgcf;systemctl restart warp-svc" >> /tmp/crontab.tmp
echo "@reboot screen -UdmS up /bin/bash /root/WARP-UP.sh" >> /tmp/crontab.tmp
crontab /tmp/crontab.tmp
rm /tmp/crontab.tmp
}

unreswarp(){
crontab -l > /tmp/crontab.tmp
sed -i '/systemctl stop warp-go;systemctl restart warp-go;systemctl restart wg-quick@wgcf;systemctl restart warp-svc/d' /tmp/crontab.tmp
sed -i '/@reboot screen/d' /tmp/crontab.tmp
crontab /tmp/crontab.tmp
rm /tmp/crontab.tmp
}

ONEWARPGO(){
yellow "\n Please wait..." && sleep 2
STOPwgcf(){
if [[ -n $(type -P warp-cli) ]]; then
red "Socks5-WARP has been installed, does not support the currently selected WARP installation scheme"
systemctl restart warp-go ; bash CFwarp.sh
the fi
}

ShowWGCF(){
UA_Browser="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.87 Safari/537.36"
v4v6
warppflow=$((`grep -oP '"quota":\K\d+' <<< $(curl -sm4 "https://api.cloudflareclient.com/v0a884/reg/$(grep 'Device' /usr /local/bin/warp.conf 2>/dev/null | cut -d= -f2 | sed 's# ##g')" -H "User-Agent: okhttp/3.12.1" -H "Authorization: Bearer $(grep 'Token' /usr/local/bin/warp.conf 2>/dev/null | cut -d= -f2 | sed 's# ##g')")`))
flow=`echo "scale=2; $warppflow/1000000000" | bc`
[[ -e /usr/local/bin/warpplus.log ]] && cfplus="WARP+ common account (limited WARP+ traffic: $flow GB), device name: $(sed -n 1p /usr/local/bin/warpplus .log)" || cfplus="WARP+Teams account (unlimited WARP+traffic)"
if [[ -n $v4 ]]; then
nf4
curl -s4 "https://chat.openai.com/" | grep -qw "Sorry, you have been blocked" && chat='Unfortunately, the current IP cannot access the ChatGPT official website service' || chat='Congratulations, the current IP Support access to ChatGPT official website service'
#[[ $(curl -s4 https://chat.openai.com/ -I | grep "text/plain") != "" ]] && chat='Unfortunately, the current IP cannot access the ChatGPT official website service' || chat='Congratulations, the current IP supports access to ChatGPT official website service'
wgcfv4=$(curl -s4 https://www.cloudflare.com/cdn-cgi/trace -k | grep warp | cut -d= -f2)
isp4a=`curl -sm6 --user-agent "${UA_Browser}" http://ip-api.com/json/$v4?lang=zh-CN -k | cut -f13 -d ":" | cut -f2 -d '"'`
isp4b=`curl -sm6 --user-agent "${UA_Browser}" https://api.ip.sb/geoip/$v4 -k | awk -F "isp" '{print $2}' | awk -F "offset" '{print $1}' | sed "s/[,\":]//g"`
[[ -n $isp4a ]] && isp4=$isp4a || isp4=$isp4b
nonf=$(curl -sm6 --user-agent "${UA_Browser}" http://ip-api.com/json/$v4?lang=zh-CN -k | cut -f2 -d"," | cut -f4 -d '"')
#sunf=$(./nf | awk '{print $1}' | sed -n '4p')
#snnf=$(curl -s4m6 ip.p3terx.com -k | sed -n 2p | awk '{print $3}')
country=$nonf
case ${wgcfv4} in
plus)
WARPIPv4Status=$(white "WARP+status:\c" ; rred "Running, $cfplus" ; white "Service provider Cloudflare obtains IPV4 address:\c" ; rred "$v4 $country" ; white "Netflix NF unlocking status ：\c" ; rred "$NF" ; white "ChatGPT unlock situation:\c" ; rred "$chat");;  
on)
WARPIPv4Status=$(white "WARP status:\c" ; green "Running, WARP common account (unlimited WARP traffic)" ; white "Service provider Cloudflare obtains IPV4 address:\c" ; green "$v4 $country" ; white " Netflix NF unlocking situation:\c" ; green "$NF" ; white " ChatGPT unlocking situation:\c" ; green "$chat");;
off)
WARPIPv4Status=$(white "WARP status:\c" ; yellow "Closing" ; white "Service provider $isp4 obtains IPV4 address:\c" ; yellow "$v4 $country" ; white "Netflix NF unlocking status:\ c" ; yellow "$NF" ; white "ChatGPT unlock situation:\c" ; yellow "$chat");;
esac
else
WARPIPv4Status=$(white "IPV4 status:\c" ; red "IPV4 address does not exist")
the fi
if [[ -n $v6 ]]; then
nf6
curl -s6 "https://chat.openai.com/" | grep -qw "Sorry, you have been blocked" && chat='Unfortunately, the current IP cannot access the ChatGPT official website service' || chat='Congratulations, the current IP Support access to ChatGPT official website service'
#[[ $(curl -s6 https://chat.openai.com/ -I | grep "text/plain") != "" ]] && chat='Unfortunately, the current IP cannot access the ChatGPT official website service' || chat='Congratulations, the current IP supports access to ChatGPT official website service'
wgcfv6=$(curl -s6 https://www.cloudflare.com/cdn-cgi/trace -k | grep warp | cut -d= -f2)
isp6a=`curl -sm6 --user-agent "${UA_Browser}" http://ip-api.com/json/$v6?lang=zh-CN -k | cut -f13 -d ":" | cut -f2 -d '"'`
isp6b=`curl -sm6 --user-agent "${UA_Browser}" https://api.ip.sb/geoip/$v6 -k | awk -F "isp" '{print $2}' | awk -F "offset" '{print $1}' | sed "s/[,\":]//g"`
[[ -n $isp6a ]] && isp6=$isp6a || isp6=$isp6b
nonf=$(curl -sm6 --user-agent "${UA_Browser}" http://ip-api.com/json/$v6?lang=zh-CN -k | cut -f2 -d"," | cut -f4 -d '"')
#sunf=$(./nf | awk '{print $1}' | sed -n '8p')
#snnf=$(curl -s6m6 ip.p3terx.com -k | sed -n 2p | awk '{print $3}')
country=$nonf
case ${wgcfv6} in
plus)
WARPIPv6Status=$(white "WARP+status:\c" ; rred "Running, $cfplus" ; white "Service provider Cloudflare obtains IPV6 address:\c" ; rred "$v6 $country" ; white "Netflix NF unlocking status ：\c" ; rred "$NF" ; white "ChatGPT unlock situation:\c" ; rred "$chat");;  
on)
WARPIPv6Status=$(white "WARP status:\c" ; green "Running, WARP common account (unlimited WARP traffic)" ; white "Service provider Cloudflare obtains IPV6 address:\c" ; green "$v6 $country" ; white " Netflix NF unlocking situation:\c" ; green "$NF" ; white " ChatGPT unlocking situation:\c" ; green "$chat");;
off)
WARPIPv6Status=$(white "WARP status:\c" ; yellow "closed" ; white "service provider $isp6 obtains IPV6 address:\c" ; yellow "$v6 $country" ; white "Netflix NF unlocking status:\ c" ; yellow "$NF" ; white "ChatGPT unlock situation:\c" ; yellow "$chat");;
esac
else
WARPIPv6Status=$(white "IPV6 status:\c" ; red "IPV6 address does not exist")
the fi
}

wgo1='sed -i "s#.*AllowedIPs.*#AllowedIPs = 0.0.0.0/0#g" /usr/local/bin/warp.conf'
wgo2='sed -i "s#.*AllowedIPs.*#AllowedIPs = ::/0#g" /usr/local/bin/warp.conf'
wgo3='sed -i "s#.*AllowedIPs.*#AllowedIPs = 0.0.0.0/0,::/0#g" /usr/local/bin/warp.conf'
wgo4="sed -i "/Endpoint6/d" /usr/local/bin/warp.conf && sed -i "s/162.159.*/$endpoint/g" /usr/local/bin/warp.conf"
wgo5="sed -i "/Endpoint6/d" /usr/local/bin/warp.conf && sed -i "s/162.159.*/$endpoint/g" /usr/local/bin/warp.conf"
wgo6='sed -i "20 s/^/PostUp = ip -4 rule add from $(ip route get 162.159.192.1 | grep -oP "src \K\S+") lookup main\n/" /usr/local /bin/warp.conf && sed -i "20 s/^/PostDown = ip -4 rule delete from $(ip route get 162.159.192.1 | grep -oP "src \K\S+") lookup main\n/" /usr/local/bin/warp.conf'
wgo7='sed -i "20 s/^/PostUp = ip -6 rule add from $(ip route get 2606:4700:d0::a29f:c001 | grep -oP "src \K\S+") lookup main\ n/" /usr/local/bin/warp.conf && sed -i "20 s/^/PostDown = ip -6 rule delete from $(ip route get 2606:4700:d0::a29f:c001 | grep -oP "src \K\S+") lookup main\n/" /usr/local/bin/warp.conf'
wgo8='sed -i "20 s/^/PostUp = ip -4 rule add from $(ip route get 162.159.192.1 | grep -oP "src \K\S+") lookup main\n/" /usr/local /bin/warp.conf && sed -i "20 s/^/PostDown = ip -4 rule delete from $(ip route get 162.159.192.1 | grep -oP "src \K\S+") lookup main\n/" /usr/local/bin/warp.conf && sed -i "20 s/^/PostUp = ip -6 rule add from $(ip route get 2606:4700:d0::a29f:c001 | grep -oP "src \ K\S+") lookup main\n/" /usr/local/bin/warp.conf && sed -i "20 s/^/PostDown = ip -6 rule delete from $(ip route get 2606:4700:d0: :a29f:c001 | grep -oP "src \K\S+") lookup main\n/" /usr/local/bin/warp.conf'

CheckWARP(){
i=0
while [ $i -le 9 ]; do let i++
yellow "A total of 10 executions, the $i time to obtain the warp's IP..."
kill -15 $(pgrep warp-go) >/dev/null 2>&1 && sleep 2
systemctl restart warp-go
systemctl enable warp-go
systemctl start warp-go
checkwgcf
if [[ $wgcfv4 =~ on|plus || $wgcfv6 =~ on|plus ]]; then
green "Congratulations! Warp's IP has been obtained successfully!" && dns
break
else
red "Sorry! Warp IP acquisition failed"
the fi
done
if [[ ! $wgcfv4 =~ on|plus && ! $wgcfv6 =~ on|plus ]]; then
red "Failed to install WARP, restore VPS, uninstall WARP"
cwg && rm -rf /root/warpip
echo
[[ $release = Centos && ${vsid} -lt 7 ]] && yellow "Current system version number: Centos $vsid \nIt is recommended to use a system above Centos 7"
[[ $release = Ubuntu && ${vsid} -lt 18 ]] && yellow "Current system version number: Ubuntu $vsid \nIt is recommended to use Ubuntu 18 or above"
[[ $release = Debian && ${vsid} -lt 10 ]] && yellow "Current system version number: Debian $vsid \nIt is recommended to use Debian 10 or above"
yellow "Hint:"
red "You may be able to use Option 2 or 3 for WARP"
red "You can also choose WGCF core to install WARP solution one"
exit
else
green "ok" && systemctl restart warp-go
the fi
}

nat4(){
[[ -n $(ip route get 1.1.1.1 2>/dev/null | grep -oP 'src \K\S+') ]] && wpgo4=$wgo6 || wpgo4=echo
}

WGCFv4(){
yellow "Wait for 3 seconds to detect the warp environment in the VPS"
docker && checkwgcf
if [[ ! $wgcfv4 =~ on|plus && ! $wgcfv6 =~ on|plus ]]; then
v4v6
if [[ -n $v4 && -n $v6 ]]; then
green "Current native v4+v6 dual-stack vps install warp for the first time\nNow add WARP IPV4 (IP outbound performance: native IPV6 + WARP IPV4)" && sleep 2
wpgo1=$wgo1 && wpgo2=$wgo4 && wpgo3=$wgo8 && WGC Fins
the fi
if [[ -n $v6 && -z $v4 ]]; then
green "The current native v6 single-stack vps installs warp for the first time\nNow add WARP IPV4 (IP outbound performance: native IPV6 + WARP IPV4)" && sleep 2
wpgo1=$wgo1 && wpgo2=$wgo5 && wpgo3=$wgo7 && nat4 && WGC Fins
the fi
if [[ -z $v6 && -n $v4 ]]; then
green "The current native v4 single-stack vps installs warp for the first time\nNow add WARP IPV4 (IP outbound performance: only WARP IPV4)" && sleep 2
wpgo1=$wgo1 && wpgo2=$wgo4 && wpgo3=$wgo6 && WGC Fins
the fi
echo 'w4' > /root/warpip/wp.log
first4
else
kill -15 $(pgrep warp-go) >/dev/null 2>&1
sleep 2 && v4v6
if [[ -n $v4 && -n $v6 ]]; then
green "The current native v4+v6 dual-stack vps has warp installed\nquickly switch to WARP IPV4 now (IP outbound performance: native IPV6 + WARP IPV4)" && sleep 2
wpgo1=$wgo1 && wpgo2=$wgo4 && wpgo3=$wgo8 && ABC
the fi
if [[ -n $v6 && -z $v4 ]]; then
green "The current native v6 single-stack vps has installed warp\nquickly switch to WARP IPV4 now (IP outbound performance: native IPV6 + WARP IPV4)" && sleep 2
wpgo1=$wgo1 && wpgo2=$wgo5 && wpgo3=$wgo7 && nat4 && ABC
the fi
if [[ -z $v6 && -n $v4 ]]; then
green "The current native v4 single-stack vps has warp installed\nquickly switch to WARP IPV4 now (IP outbound performance: only WARP IPV4)" && sleep 2
wpgo1=$wgo1 && wpgo2=$wgo4 && wpgo3=$wgo6 && ABC
the fi
echo 'w4' > /root/warpip/wp.log
CheckWARP && first4 && ShowWGCF && WGCFmenu
the fi
}

WGCFv6(){
yellow "Wait for 3 seconds to detect the warp environment in the VPS"
docker && checkwgcf
if [[ ! $wgcfv4 =~ on|plus && ! $wgcfv6 =~ on|plus ]]; then
v4v6
if [[ -n $v4 && -n $v6 ]]; then
green "Current native v4+v6 dual-stack vps install warp for the first time\nNow add WARP IPV6 (IP outbound performance: native IPV4 + WARP IPV6)" && sleep 2
wpgo1=$wgo2 && wpgo2=$wgo4 && wpgo3=$wgo8 && WGC Fins
the fi
if [[ -n $v6 && -z $v4 ]]; then
green "The current native v6 single-stack vps installs warp for the first time\nNow add WARP IPV6 (IP outbound performance: only WARP IPV6)" && sleep 2
wpgo1=$wgo2 && wpgo2=$wgo5 && wpgo3=$wgo7 && nat4 && WGC Fins
the fi
if [[ -z $v6 && -n $v4 ]]; then
green "The current native v4 single-stack vps installs warp for the first time\nNow add WARP IPV6 (IP outbound performance: native IPV4 + WARP IPV6)" && sleep 2
wpgo1=$wgo2 && wpgo2=$wgo4 && wpgo3=$wgo6 && WGC Fins
the fi
echo 'w6' > /root/warpip/wp.log
else
kill -15 $(pgrep warp-go) >/dev/null 2>&1
sleep 2 && v4v6
if [[ -n $v4 && -n $v6 ]]; then
green "The current native v4+v6 dual-stack vps has warp installed\nquickly switch to WARP IPV6 now (IP outbound performance: native IPV4 + WARP IPV6)" && sleep 2
wpgo1=$wgo2 && wpgo2=$wgo4 && wpgo3=$wgo8 && ABC
the fi
if [[ -n $v6 && -z $v4 ]]; then
green "The current native v6 single-stack vps has installed warp\nquickly switch to WARP IPV6 now (IP outbound performance: only WARP IPV6)" && sleep 2
wpgo1=$wgo2 && wpgo2=$wgo5 && wpgo3=$wgo7 && nat4 && ABC
the fi
if [[ -z $v6 && -n $v4 ]]; then
green "The current native v4 single-stack vps has warp installed\nquickly switch to WARP IPV6 now (IP outbound performance: native IPV4 + WARP IPV6)" && sleep 2
wpgo1=$wgo2 && wpgo2=$wgo4 && wpgo3=$wgo6 && ABC
the fi
echo 'w6' > /root/warpip/wp.log
CheckWARP && first4 && ShowWGCF && WGCFmenu
the fi
}

WGCFv4v6(){
yellow "Wait for 3 seconds to detect the warp environment in the VPS"
docker && checkwgcf
if [[ ! $wgcfv4 =~ on|plus && ! $wgcfv6 =~ on|plus ]]; then
v4v6
if [[ -n $v4 && -n $v6 ]]; then
green "Current native v4+v6 dual-stack vps install warp for the first time\nNow add WARP IPV4+IPV6 (IP outbound performance: WARP dual-stack IPV4 + IPV6)" && sleep 2
wpgo1=$wgo3 && wpgo2=$wgo4 && wpgo3=$wgo8 && WGC Fins
the fi
if [[ -n $v6 && -z $v4 ]]; then
green "Current native v6 single-stack vps install warp for the first time\nNow add WARP IPV4+IPV6 (IP outbound performance: WARP dual-stack IPV4 + IPV6)" && sleep 2
wpgo1=$wgo3 && wpgo2=$wgo5 && wpgo3=$wgo7 && nat4 && WGC Fins
the fi
if [[ -z $v6 && -n $v4 ]]; then
green "Current native v4 single-stack vps install warp for the first time\nNow add WARP IPV4+IPV6 (IP outbound performance: WARP dual-stack IPV4 + IPV6)" && sleep 2
wpgo1=$wgo3 && wpgo2=$wgo4 && wpgo3=$wgo6 && WGC Fins
the fi
echo 'w64' > /root/warpip/wp.log
else
kill -15 $(pgrep warp-go) >/dev/null 2>&1
sleep 2 && v4v6
if [[ -n $v4 && -n $v6 ]]; then
green "The current native v4+v6 dual-stack vps has warp installed\nquickly switch to WARP IPV4+IPV6 now (IP outbound performance: WARP dual-stack IPV4 + IPV6)" && sleep 2
wpgo1=$wgo3 && wpgo2=$wgo4 && wpgo3=$wgo8 && ABC
the fi
if [[ -n $v6 && -z $v4 ]]; then
green "The current native v6 single-stack vps has installed warp\nquickly switch to WARP IPV4+IPV6 now (IP outbound performance: WARP dual-stack IPV4 + IPV6)" && sleep 2
wpgo1=$wgo3 && wpgo2=$wgo5 && wpgo3=$wgo7 && nat4 && ABC
the fi
if [[ -z $v6 && -n $v4 ]]; then
green "The current native v4 single-stack vps has installed warp\nquickly switch to WARP IPV4+IPV6 now (IP outbound performance: WARP dual-stack IPV4 + IPV6)" && sleep 2
wpgo1=$wgo3 && wpgo2=$wgo4 && wpgo3=$wgo6 && ABC
the fi
echo 'w64' > /root/warpip/wp.log
CheckWARP && first4 && ShowWGCF && WGCFmenu
the fi
}

ABC(){
echo $wpgo1 | sh
echo $wpgo2 | sh
echo $wpgo3 | sh
echo $wpgo4 | sh
}

dns(){
if [[ ! -f /etc/resolv.conf.bak ]]; then
mv /etc/resolv.conf /etc/resolv.conf.bak
rm -rf /etc/resolv.conf
cp -f /etc/resolv.conf.bak /etc/resolv.conf
chattr +i /etc/resolv.conf >/dev/null 2>&1
else
chattr +i /etc/resolv.conf >/dev/null 2>&1
the fi
}

WGCFins(){
if [[ $release = Centos ]]; then
if [[ ${vsid} =~ 8 ]]; then
cd /etc/yum.repos.d/ && mkdir backup && mv *repo backup/
curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-8.repo
sed -i -e "s|mirrors.cloud.aliyuncs.com|mirrors.aliyun.com|g " /etc/yum.repos.d/CentOS-*
sed -i -e "s|releasever|releasever-stream|g" /etc/yum.repos.d/CentOS-*
yum clean all && yum makecache
the fi
yum install epel-release -y; yum install iproute iputils-ping -y
elif [[ $release = Debian ]]; then
apt install lsb-release -y
echo "deb http://deb.debian.org/debian $(lsb_release -sc)-backports main" | tee /etc/apt/sources.list.d/backports.list
apt update -y;apt install iproute2 openresolv dnsutils iputils-ping -y   		
elif [[ $release = Ubuntu ]]; then
apt update -y;apt install iproute2 openresolv dnsutils iputils-ping -y
the fi
wget -N https://gitlab.com/rwkgyg/CFwarp/-/raw/main/warp-go_1.0.8_linux_${cpu} -O /usr/local/bin/warp-go && chmod +x /usr/ local/bin/warp-go
until [[ -e /usr/local/bin/warp.conf ]]; do
yellow "Applying for a WARP ordinary account, please wait a moment! If it appears multiple times, please press ctrl+c to exit, and select the WGCF core to install WARP" && sleep 1
/usr/local/bin/warp-go --register --config=/usr/local/bin/warp.conf >/dev/null 2>&1
done
mtuwarp
sed -i "s/MTU.*/MTU=$MTU/g" /usr/local/bin/warp.conf
cat > /lib/systemd/system/warp-go.service << EOF
[Unit]
Description=warp-go service
After=network.target
Documentation=https://gitlab.com/ProjectWARP/warp-go
[Service]
WorkingDirectory=/root/
ExecStart=/usr/local/bin/warp-go --config=/usr/local/bin/warp.conf
Environment="LOG_LEVEL=verbose"
RemainAfterExit=yes
Restart=always
[Install]
WantedBy=multi-user.target
EOF
ABC
warpip
systemctl daemon-reload
systemctl enable warp-go
systemctl start warp-go
kill -15 $(pgrep warp-go) >/dev/null 2>&1 && sleep 2
systemctl restart warp-go
systemctl enable warp-go
systemctl start warp-go
checkwgcf
if [[ $wgcfv4 =~ on|plus || $wgcfv6 =~ on|plus ]]; then
green "Congratulations! Warp's IP has been obtained successfully!" && dns
else
CheckWARP
the fi
ShowWGCF && xyz && WGCFmenu && lncf && reswarp
}

warpinscha(){
yellow "Prompt: The local outbound IP of the VPS will be taken over by the warp IP you selected. If the VPS does not have the outbound IP locally, it will be taken over by another warp generated IP"
echo
yellow "If you don't understand anything, press Enter!!!"
echo
green "1. Install/switch WARP single-stack IPV4 (enter default)"
green "2. Install/Switch WARP Single Stack IPV6"
green "3. Install/switch WARP dual-stack IPV4+IPV6"
readp "\nPlease select:" wgcfwarp
if [ -z "${wgcfwarp}" ] || [ $wgcfwarp == "1" ];then
WGCFv4
elif [ $wgcfwarp == "2" ];then
WGCFv6
elif [ $wgcfwarp == "3" ];then
WGCFv4v6
else
red "Input error, please choose again" && warpinscha
the fi
echo
}

WARPup(){
endpost(){
kill -15 $(pgrep warp-go) >/dev/null 2>&1 && sleep 2
v4v6
allowips=$(cat /usr/local/bin/warp.conf | grep AllowedIPs)
if [[ -n $v4 && -n $v6 ]]; then
endpoint=$wgo4
post=$wgo8
elif [[ -n $v6 && -z $v4 ]]; then
endpoint=$wgo5
[[ -n $(ip route get 1.1.1.1 2>/dev/null | grep -oP 'src \K\S+') ]] && post=$wgo8 || post=$wgo7
elif [[ -z $v6 && -n $v4 ]]; then
endpoint=$wgo4
post=$wgo6
the fi
}

freewarp(){
end post
red "Current execution: apply for WARP ordinary account"
rm -rf /usr/local/bin/warp.conf /usr/local/bin/warp.conf.bak /usr/local/bin/warpplus.log
until [[ -e /usr/local/bin/warp.conf ]]; do
yellow "Applying for WARP common account, please wait" && sleep 1
/usr/local/bin/warp-go --register --config=/usr/local/bin/warp.conf
mtuwarp
sed -i "s/MTU.*/MTU=$MTU/g" /usr/local/bin/warp.conf
done
sed -i "s#.*AllowedIPs.*#$allowips#g" /usr/local/bin/warp.conf
echo $endpoint | sh
echo $post | sh
kill -15 $(pgrep warp-go) >/dev/null 2>&1 && sleep 2
systemctl restart warp-go
systemctl enable warp-go
systemctl start warp-go
CheckWARP && ShowWGCF && WGCFmenu
}

[[ ! $(type -P warp-go) ]] && red "WARP not installed" && bash CFwarp.sh
green "1. WARP ordinary account (unlimited traffic)"
green "2. WARP+ account (limited traffic)"
green "3. WARP Teams (Zero Trust) team account (unlimited traffic)"
readp "Please select the account type you want to switch:" warpup
if [[ $warpup == 1 ]]; then
free warp
the fi

if [[ $warpup == 2 ]]; then
green "Please copy the button license key or the network sharing key (26 characters) in the WARP+ state of the mobile WARP client, and enter it at will to have a chance to get a 1G traffic WARP+ account"
readp "Please enter upgrade WARP+ key" ID
readp "Device name renaming (directly enter random name): " dname
if [[ -z $ID ]]; then
red "no content entered" && WARPup
the fi
if [[ -z $dname ]]; then
dname=`date +%s%N |md5sum | cut -c 1-4`
the fi
green "The device name is $dname"
i=0
while [ $i -le 4 ]; do let i++
end post
yellow "A total of 5 executions, the $i upgrade of the WARP+ account..."
/usr/local/bin/warp-go --register --config=/usr/local/bin/warp.conf --license=$ID --device-name=$dname
sed -i "s#.*AllowedIPs.*#$allowips#g" /usr/local/bin/warp.conf
echo $endpoint | sh
echo $post | sh
warpip
kill -15 $(pgrep warp-go) >/dev/null 2>&1 && sleep 2
systemctl restart warp-go
systemctl enable warp-go
systemctl start warp-go
checkwgcf
if [[ $wgcfv4 = plus || $wgcfv6 = plus ]]; then
rm -rf /usr/local/bin/warp.conf.bak /usr/local/bin/warpplus.log
echo "$dname" >> /usr/local/bin/warpplus.log && echo "$ID" >> /usr/local/bin/warpplus.log
green "WARP+ account upgrade successful!" && ShowWGCF && WGCFmenu && break
else
red "WARP+ account upgrade failed!" && sleep 1
the fi
done
if [[ ! $wgcfv4 = plus && ! $wgcfv6 = plus ]]; then
green "Suggest the following:"
yellow "1. Check whether the WARP+ account in 1.1.1.1 APP or the secret key shared by the network has traffic"
yellow "2. Check that the current WARP license key is bound to more than 5 devices, please enter the mobile terminal to remove the device and try to upgrade the WARP+ account" && sleep 2
echo
free warp
the fi
the fi
    
if [[ $warpup == 3 ]]; then
green "Zero Trust team Token acquisition address: https://web--public--warp-team-api--coia-mfs4.code.run/"
readp "Please enter the team account Token: " token
i=0
while [ $i -le 4 ]; do let i++
yellow "A total of 5 executions, the $i upgrade of the WARP Teams account..."
/usr/local/bin/warp-go --register --config=/usr/local/bin/warp.conf.bak --team-config "$token"
sed -i "2s#.*#$(sed -ne 2p /usr/local/bin/warp.conf.bak)#;3s#.*#$(sed -ne 3p /usr/local/bin/warp. conf.bak)#" /usr/local/bin/warp.conf >/dev/null 2>&1
sed -i "4s#.*#$(sed -ne 4p /usr/local/bin/warp.conf.bak)#;5s#.*#$(sed -ne 5p /usr/local/bin/warp. conf.bak)#" /usr/local/bin/warp.conf >/dev/null 2>&1
warpip
kill -15 $(pgrep warp-go) >/dev/null 2>&1 && sleep 2
systemctl restart warp-go
systemctl enable warp-go
systemctl start warp-go
checkwgcf
if [[ $wgcfv4 = plus || $wgcfv6 = plus ]]; then
rm -rf /usr/local/bin/warp.conf.bak /usr/local/bin/warpplus.log
green "WARP Teams account upgrade successful!" && ShowWGCF && WGCFmenu && break
else
red "WARP Teams account upgrade failed!" && sleep 1
the fi
done
if [[ ! $wgcfv4 = plus && ! $wgcfv6 = plus ]]; then
free warp
the fi
the fi
}

WARPonoff(){
[[ ! $(type -P warp-go) ]] && red "WARP is not installed, it is recommended to reinstall" && bash CFwarp.sh
readp "1. Turn off WARP function (turn off WARP online monitoring)\n2. Turn on/restart WARP function (start WARP online monitoring)\n0. Return to the previous layer\n Please select:" unwp
if [ $unwp == "1" ]; then
kill -15 $(pgrep warp-go) >/dev/null 2>&1 && sleep 2
systemctl disable warp-go
screen -ls | awk '/\.up/ {print $1}' | cut -d "." -f 1 | xargs kill 2>/dev/null
unreswarp
checkwgcf
[[ ! $wgcfv4 =~ on|plus && ! $wgcfv6 =~ on|plus ]] && green "close WARP successfully" || red "close WARP failed"
ShowWGCF && WGCFmenu
elif [ $unwp == "2" ]; then
kill -15 $(pgrep warp-go) >/dev/null 2>&1 && sleep 2
systemctl restart warp-go
systemctl enable warp-go
systemctl start warp-go
xyz
name=`screen -ls | grep '(Detached)' | awk '{print $1}' | awk -F "." '{print $2}'`
[[ $name =~ "up" ]] && green "WARP online monitoring started successfully" || red "WARP online monitoring failed to start, check whether the screen is installed successfully"
reswarp
checkwgcf
[[ $wgcfv4 =~ on|plus || $wgcfv6 =~ on|plus ]] && green "start WARP successfully" || red "start WARP failed"
ShowWGCF && WGCFmenu
else
bash CFwarp.sh
the fi
}

cwg(){
screen -ls | awk '/\.up/ {print $1}' | cut -d "." -f 1 | xargs kill 2>/dev/null
systemctl disable warp-go >/dev/null 2>&1
kill -15 $(pgrep warp-go) >/dev/null 2>&1
chattr -i /etc/resolv.conf >/dev/null 2>&1
sed -i '/^precedence ::ffff:0:0\/96 100/d;/^label 2002::\/16 2/d' /etc/gai.conf 2>/dev/null
rm -rf /usr/local/bin/warp-go /usr/local/bin/warpplus.log /usr/local/bin/warp.conf /usr/local/bin/wgwarp.conf /usr/local/bin/ sbwarp.json /usr/bin/warp-go /lib/systemd/system/warp-go.service /root/WARP-UP.sh
}
WARPun(){
ab="1. Only uninstall warp\n2. Only uninstall socks5-warp\n3. Completely uninstall warp (1+2)\n Please choose:"
readp "$ab" cd
case "$cd" in
1) cwg && green "warp uninstall complete" && ShowWGCF && WGCFmenu;;
2) cso && green "socks5-warp uninstall complete" && ShowSOCKS5 && S5menu;;
3) cwg && rm -rf /root/warpip && cso && unreswarp && green "warp and socks5-warp have been uninstalled" && ShowWGCF;ShowSOCKS5;IP_Status_menu;;
esac
}

UPwpyg(){
if [[ ! $(type -P warp-go) && ! $(type -P warp-cli) ]] && [[ ! -f '/root/CFwarp.sh' ]]; then
red "CFwarp script not installed normally!" && exit
the fi
upcfwarp
}

changewarp(){
cwg && ONEWGCFWARP
}

upwarpgo(){
kill -15 $(pgrep warp-go) >/dev/null 2>&1 && sleep 2
wget -N --no-check-certificate https://gitlab.com/rwkgyg/CFwarp/-/raw/main/warp-go_1.0.8_linux_${cpu} -O /usr/local/bin/warp-go && chmod +x /usr/local/bin/warp-go
systemctl restart warp-go
systemctl enable warp-go
systemctl start warp-go
loVERSION="$(/usr/local/bin/warp-go -v | sed -n 1p | awk '{print $1}' | awk -F"/" '{print $NF}')"
green "The current WARP-GO installed kernel version number: ${loVERSION}, which is the latest version"
}

WGproxy(){
if [[ ! $(type -P warp-go) ]]; then
wget -N https://gitlab.com/rwkgyg/CFwarp/-/raw/main/warp-go_1.0.8_linux_${cpu} -O /usr/local/bin/warp-go && chmod +x /usr/ local/bin/warp-go
until [[ -e /usr/local/bin/warp.conf ]]; do
yellow "Applying for WARP common account, please wait" && sleep 1
/usr/local/bin/warp-go --register --config=/usr/local/bin/warp.conf
mtuwarp
sed -i "s/MTU.*/MTU=$MTU/g" /usr/local/bin/warp.conf
done
the fi
/usr/local/bin/warp-go --config=/usr/local/bin/warp.conf --export-wireguard=/usr/local/bin/wgwarp.conf
sed -i '/Endpoint/d' /usr/local/bin/wgwarp.conf
sed -i "11a Endpoint = $endpoint" /usr/local/bin/wgwarp.conf
/usr/local/bin/warp-go --config=/usr/local/bin/warp.conf --export-singbox=/usr/local/bin/sbwarp.json
green "The current Wireguard-warp configuration parameters are as follows" && sleep 1
white "$(cat /usr/local/bin/wgwarp.conf)\n"
yellow "Note:"
yellow "1. This configuration has nothing to do with the current VPS. The IP region of the CF is determined according to the principle of proximity to the local network of each platform\n"
yellow "Second, all this configuration can be copied for the Wireguard client, and individual parameters can be copied for the Wireguard-warp outbound configuration of the Xray protocol\n"
yellow "3. The IP port of the Endpoint in this configuration: $endpoint, which is the preferred test result for the current VPS platform warp"
yellow "If it is applied to other platforms, it is recommended to replace $endpoint with the optimized IP port of the local network test warp of other platforms\n"
yellow "4. In this configuration, PrivateKey, V6 address of Address, reserved (optional), the three parameters are bound to each other"
yellow " The reserved parameter value of the current VPS platform: $(grep -o '"reserved":\[[^]]*\]' /usr/local/bin/sbwarp.json)\n"
green "The current Wireguard node QR code sharing link is as follows" && sleep 1
qrencode -t ansiutf8 < /usr/local/bin/wgwarp.conf
echo
#green "The current Sing-box outbound configuration file is as follows" && sleep 1
#yellow "$(cat /usr/local/bin/sbwarp.json | python3 -mjson.tool)"
}

start_menu(){
ShowWGCF;ShowSOCKS5
clear
echo
white "Yongge Github project: github.com/yonggekkk"
white "Yongge blogger blog: ygkkk.blogspot.com"
white "Brother Yong YouTube channel: www.youtube.com/@ygkkk"
yellow "Translate By : Mohammad javad Hassanpour"
yellow "Telegram ID : https://t.me/javadhpr1372"
green "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~"
yellow "Choose the warp reality scheme that suits you arbitrarily (options 1, 2, 3, single choice, multiple choices can coexist)"
yellow "Enter script shortcut: cf"
white " =================================================== =================="
green " 1. Solution 1: Install/Switch WARP-GO"
[[ $cpu != amd64* ]] && red " 2. Tip: The CPU of the current VPS is not AMD64 architecture, currently does not support the installation of Socks5-WARP" || green " 2. Solution 2: Install Socks5-WARP"
green " 3. Solution 3: Display Xray-WireGuard-WARP proxy configuration file and QR code"
green " 4. Uninstall WARP"
white " ----------------------------------------------- -----------------"
green " 5. Turn off, turn on/restart WARP"
green " 6. Other WARP options: check WARP online monitoring, refresh WARP+ traffic..."
green " 7. WARP three types of account upgrade/switch (WARP/WARP+/WARP Teams)"
green " 8. Update CFwarp installation script"
green " 9. Update WARP-GO kernel"
green " 10. Replace the current WARP-GO kernel with the WGCF-WARP kernel"
green " 0. exit script"
red "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
if [ "${wpygV}" = "${remoteV}" ]; then
echo -e "Current CFwarp script version number: ${bblue}${wpygV}${plain} reset version 4, already the latest version\n"
else
echo -e "Current CFwarp script version number: ${bblue}${wpygV}${plain}"
echo -e "The latest CFwarp script version number is detected: ${yellow}${remoteV}${plain}"
echo -e " ${yellow}$(wget -qO- https://gitlab.com/en_project/CFwrap_en/-/raw/main/Version/wrapV)${plain}"
echo -e "Option 8 for update\n"
the fi
if [[ $(type -P warp-go) ]] && [[ -f '/root/CFwarp.sh' ]]; then
loVERSION="$(/usr/local/bin/warp-go -v | sed -n 1p | awk '{print $1}' | awk -F"/" '{print $NF}')"
wgVERSION="$(wget -qO- https://gitlab.com/en_project/CFwrap_en/-/raw/main/Version/wrapgoV)"
if [ "${loVERSION}" = "${wgVERSION}" ]; then
echo -e "The current WARP-GO installed kernel version number: ${bblue}${loVERSION}${plain}, which is the latest version"
else
echo -e "Current WARP-GO installed kernel version number: ${bblue}${loVERSION}${plain}"
echo -e "The latest WARP-GO kernel version number is detected: ${yellow}${wgVERSION}${plain}, you can choose 9 to update"
the fi
the fi
red "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
white "VPS system information is as follows:"
white " Operating system: $(blue "$op") \c" && white " Kernel version: $(blue "$version") \c" && white " CPU architecture: $(blue "$cpu") \c" && white "Virtualization type: $(blue "$vi")"
IP_Status_menu
echo
readp "Please enter the number:" Input
case "$Input" in     
 1) warpinscha;;
 2) [[ $cpu = amd64* ]] && SOCKS5ins || bash CFwarp.sh;;
 3) WGproxy;;
 4) WARPun && uncf;;
 5)WARPonoff;;
 6) WARPtools;;
 7) WARPup;;
 8) UPwpyg;;
 9) upwarpgo;;
 10) changewarp;;
 * ) exit
esac
}
if [ $# == 0 ]; then
bit=`uname -m`
[[ $bit = aarch64 ]] && cpu=arm64
if [[ $bit = x86_64 ]]; then
amdv=$(cat /proc/cpuinfo | grep flags | head -n 1 | cut -d: -f2)
case "$amdv" in
*avx512*) cpu=amd64v4;;
*avx2*) cpu=amd64v3;;
*sse3*) cpu=amd64v2;;
*) cpu=amd64;;
esac
the fi
start_menu
the fi
}

ONEWGCFWARP(){
yellow "\n Please wait..." && sleep 2
ud4='sed -i "7 s/^/PostUp = ip -4 rule add from $(ip route get 162.159.192.1 | grep -oP '"'src \K\S+') lookup main\n/"'" /etc/wireguard/wgcf.conf && sed -i "7 s/^/PostDown = ip -4 rule delete from $(ip route get 162.159.192.1 | grep -oP '"'src \K\S+') lookup main \n/"'" /etc/wireguard/wgcf.conf'
ud6='sed -i "7 s/^/PostUp = ip -6 rule add from $(ip route get 2606:4700:d0::a29f:c001 | grep -oP '"'src \K\S+') lookup main\n/"'" /etc/wireguard/wgcf.conf && sed -i "7 s/^/PostDown = ip -6 rule delete from $(ip route get 2606:4700:d0::a29f:c001 | grep -oP '"'src \K\S+') lookup main\n/"'" /etc/wireguard/wgcf.conf'
ud4ud6='sed -i "7 s/^/PostUp = ip -4 rule add from $(ip route get 162.159.192.1 | grep -oP '"'src \K\S+') lookup main\n/"'" /etc/wireguard/wgcf.conf && sed -i "7 s/^/PostDown = ip -4 rule delete from $(ip route get 162.159.192.1 | grep -oP '"'src \K\S+') lookup main \n/"'" /etc/wireguard/wgcf.conf && sed -i "7 s/^/PostUp = ip -6 rule add from $(ip route get 2606:4700:d0::a29f:c001 | grep - oP '"'src \K\S+') lookup main\n/"'" /etc/wireguard/wgcf.conf && sed -i "7 s/^/PostDown = ip -6 rule delete from $(ip route get 2606:4700:d0::a29f:c001 | grep -oP '"'src \K\S+') lookup main\n/"'" /etc/wireguard/wgcf.conf'
c1="sed -i '/0\.0\.0\.0\/0/d' /etc/wireguard/wgcf.conf"
c2="sed -i '/\:\:\/0/d' /etc/wireguard/wgcf.conf"
c3="sed -i "s/engage.cloudflareclient.com:2408/$endpoint/g" /etc/wireguard/wgcf.conf"
c4="sed -i "s/engage.cloudflareclient.com:2408/$endpoint/g" /etc/wireguard/wgcf.conf"
c5="sed -i 's/1.1.1.1/8.8.8.8,2001:4860:4860::8888/g' /etc/wireguard/wgcf.conf"
c6="sed -i 's/1.1.1.1/2001:4860:4860::8888,8.8.8.8/g' /etc/wireguard/wgcf.conf"

ShowWGCF(){
UA_Browser="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.87 Safari/537.36"
v4v6
warppflow=$((`grep -oP '"quota":\K\d+' <<< $(curl -sm4 "https://api.cloudflareclient.com/v0a884/reg/$(grep 'device_id' /etc /wireguard/wgcf-account.toml 2>/dev/null | cut -d \' -f2)" -H "User-Agent: okhttp/3.12.1" -H "Authorization: Bearer $(grep 'access_token' / etc/wireguard/wgcf-account.toml 2>/dev/null | cut -d \' -f2)")`))
flow=`echo "scale=2; $warppflow/1000000000" | bc`
[[ -e /etc/wireguard/wgcf+p.log ]] && cfplus="WARP+ common account (limited WARP+ traffic: $flow GB), device name: $(grep -s 'Device name' /etc/wireguard/ wgcf+p.log | awk '{ print $NF }')" || cfplus="WARP+Teams account (unlimited WARP+traffic)"
if [[ -n $v4 ]]; then
nf4
curl -s4 "https://chat.openai.com/" | grep -qw "Sorry, you have been blocked" && chat='Unfortunately, the current IP cannot access the ChatGPT official website service' || chat='Congratulations, the current IP Support access to ChatGPT official website service'
#[[ $(curl -s4 https://chat.openai.com/ -I | grep "text/plain") != "" ]] && chat='Unfortunately, the current IP cannot access the ChatGPT official website service' || chat='Congratulations, the current IP supports access to ChatGPT official website service'
wgcfv4=$(curl -s4 https://www.cloudflare.com/cdn-cgi/trace -k | grep warp | cut -d= -f2)
isp4a=`curl -sm6 --user-agent "${UA_Browser}" http://ip-api.com/json/$v4?lang=zh-CN -k | cut -f13 -d ":" | cut -f2 -d '"'`
isp4b=`curl -sm6 --user-agent "${UA_Browser}" https://api.ip.sb/geoip/$v4 -k | awk -F "isp" '{print $2}' | awk -F "offset" '{print $1}' | sed "s/[,\":]//g"`
[[ -n $isp4a ]] && isp4=$isp4a || isp4=$isp4b
nonf=$(curl -sm6 --user-agent "${UA_Browser}" http://ip-api.com/json/$v4?lang=zh-CN -k | cut -f2 -d"," | cut -f4 -d '"')
#sunf=$(./nf | awk '{print $1}' | sed -n '4p')
#snnf=$(curl -s4m6 ip.p3terx.com -k | sed -n 2p | awk '{print $3}')
country=$nonf
case ${wgcfv4} in
plus)
WARPIPv4Status=$(white "WARP+status:\c" ; rred "Running, $cfplus" ; white "Service provider Cloudflare obtains IPV4 address:\c" ; rred "$v4 $country" ; white "Netflix NF unlocking status ：\c" ; rred "$NF" ; white "ChatGPT unlock situation:\c" ; rred "$chat");;  
on)
WARPIPv4Status=$(white "WARP status:\c" ; green "Running, WARP common account (unlimited WARP traffic)" ; white "Service provider Cloudflare obtains IPV4 address:\c" ; green "$v4 $country" ; white " Netflix NF unlocking situation:\c" ; green "$NF" ; white " ChatGPT unlocking situation:\c" ; green "$chat");;
off)
WARPIPv4Status=$(white "WARP status:\c" ; yellow "Closing" ; white "Service provider $isp4 obtains IPV4 address:\c" ; yellow "$v4 $country" ; white "Netflix NF unlocking status:\ c" ; yellow "$NF" ; white "ChatGPT unlock situation:\c" ; yellow "$chat");;
esac
else
WARPIPv4Status=$(white "IPV4 status:\c" ; red "IPV4 address does not exist")
the fi
if [[ -n $v6 ]]; then
nf6
curl -s6 "https://chat.openai.com/" | grep -qw "Sorry, you have been blocked" && chat='Unfortunately, the current IP cannot access the ChatGPT official website service' || chat='Congratulations, the current IP Support access to ChatGPT official website service'
#[[ $(curl -s6 https://chat.openai.com/ -I | grep "text/plain") != "" ]] && chat='Unfortunately, the current IP cannot access the ChatGPT official website service' || chat='Congratulations, the current IP supports access to ChatGPT official website service'
wgcfv6=$(curl -s6 https://www.cloudflare.com/cdn-cgi/trace -k | grep warp | cut -d= -f2)
isp6a=`curl -sm6 --user-agent "${UA_Browser}" http://ip-api.com/json/$v6?lang=zh-CN -k | cut -f13 -d ":" | cut -f2 -d '"'`
isp6b=`curl -sm6 --user-agent "${UA_Browser}" https://api.ip.sb/geoip/$v6 -k | awk -F "isp" '{print $2}' | awk -F "offset" '{print $1}' | sed "s/[,\":]//g"`
[[ -n $isp6a ]] && isp6=$isp6a || isp6=$isp6b
nonf=$(curl -sm6 --user-agent "${UA_Browser}" http://ip-api.com/json/$v6?lang=zh-CN -k | cut -f2 -d"," | cut -f4 -d '"')
#sunf=$(./nf | awk '{print $1}' | sed -n '8p')
#snnf=$(curl -s6m6 ip.p3terx.com -k | sed -n 2p | awk '{print $3}')
country=$nonf
case ${wgcfv6} in
plus)
WARPIPv6Status=$(white "WARP+status:\c" ; rred "Running, $cfplus" ; white "Service provider Cloudflare obtains IPV6 address:\c" ; rred "$v6 $country" ; white "Netflix NF unlocking status ：\c" ; rred "$NF" ; white "ChatGPT unlock situation:\c" ; rred "$chat");;  
on)
WARPIPv6Status=$(white "WARP status:\c" ; green "Running, WARP common account (unlimited WARP traffic)" ; white "Service provider Cloudflare obtains IPV6 address:\c" ; green "$v6 $country" ; white " Netflix NF unlocking situation:\c" ; green "$NF" ; white " ChatGPT unlocking situation:\c" ; green "$chat");;
off)
WARPIPv6Status=$(white "WARP status:\c" ; yellow "closed" ; white "service provider $isp6 obtains IPV6 address:\c" ; yellow "$v6 $country" ; white "Netflix NF unlocking status:\ c" ; yellow "$NF" ; white "ChatGPT unlock situation:\c" ; yellow "$chat");;
esac
else
WARPIPv6Status=$(white "IPV6 status:\c" ; red "IPV6 address does not exist")
the fi
}

STOPwgcf(){
if [[ $(type -P warp-cli) ]]; then
red "Socks5-WARP has been installed, and the currently selected wgcf-warp installation scheme is not supported"
systemctl restart wg-quick@wgcf ; bash CFwarp.sh
the fi
}

fawgcf(){
rm -f /etc/wireguard/wgcf+p.log
ID=$(cat /etc/wireguard/buckup-account.toml | grep license_key | awk '{print $3}')
sed -i "s/license_key.*/license_key = $ID/g" /etc/wireguard/wgcf-account.toml
cd /etc/wireguard && wgcf update >/dev/null 2>&1
wgcf generate >/dev/null 2>&1 && cd
sed -i "2s#.*#$(sed -ne 2p /etc/wireguard/wgcf-profile.conf)#;4s#.*#$(sed -ne 4p /etc/wireguard/wgcf-profile.conf) #" /etc/wireguard/wgcf.conf
CheckWARP
ShowWGCF && WGCFmenu
}

WGproxy(){
[[ ! $(type -P wg-quick) ]] && red "Wgcf-WARP is not installed, it can only be executed after installing wgcf-warp" && sleep 3 && bash CFwarp.sh
cp -f /etc/wireguard/wgcf.conf /etc/wireguard/wgproxy.conf >/dev/null 2>&1
sed -i '/PostUp/d;/PostDown/d;/AllowedIPs/d;/Endpoint/d' /etc/wireguard/wgproxy.conf
sed -i "8a AllowedIPs = 0.0.0.0\/0\nAllowedIPs = ::\/0\n" /etc/wireguard/wgproxy.conf
sed -i "10a Endpoint = $endpoint" /etc/wireguard/wgproxy.conf
green "The content of the current wireguard-warp configuration file wgproxy.conf is as follows, save it to /etc/wireguard/wgproxy.conf\n" && sleep 2
white "$(cat /etc/wireguard/wgproxy.conf)\n"
yellow "Note:"
yellow "1. This configuration has nothing to do with the current VPS. The IP region of the CF is determined according to the principle of proximity to the local network of each platform\n"
yellow "Second, this configuration can be fully copied for the Wireguard client\n"
yellow "3. The IP port of the Endpoint in this configuration: $endpoint, which is the preferred test result for the current VPS platform warp"
yellow "If it is applied to other platforms, it is recommended to replace $endpoint with the optimized IP port of the local network test warp of other platforms\n"
yellow "4. The V6 address of PrivateKey and Address in this configuration, these two parameters are bound to each other\n"
green "The current wireguard node QR code sharing link is as follows" && sleep 2
qrencode -t ansiutf8 < /etc/wireguard/wgproxy.conf
}

ABC(){
echo $ABC1 | sh
echo $ABC2 | sh
echo $ABC3 | sh
echo $ABC4 | sh
echo $ABC5 | sh
}

conf(){
rm -rf /etc/wireguard/wgcf.conf
cp -f /etc/wireguard/wgcf-profile.conf /etc/wireguard/wgcf.conf >/dev/null 2>&1
}

nat4(){
[[ -n $(ip route get 162.159.192.1 2>/dev/null | grep -oP 'src \K\S+') ]] && ABC4=$ud4 || ABC4=echo
}

WGCFv4(){
yellow "Wait for 3 seconds to detect the warp environment in the VPS"
docker && checkwgcf
if [[ ! $wgcfv4 =~ on|plus && ! $wgcfv6 =~ on|plus ]]; then
v4v6
if [[ -n $v4 && -n $v6 ]]; then
green "Current native v4+v6 dual-stack vps install wgcf-warp for the first time\nNow add IPV4 single-stack wgcf-warp mode" && sleep 2
ABC1=$c5 && ABC2=$c2 && ABC3=$ud4 && ABC4=$c3 && WGC Fins
the fi
if [[ -n $v6 && -z $v4 ]]; then
green "The current native v6 single-stack vps installs wgcf-warp for the first time\nNow add IPV4 single-stack wgcf-warp mode" && sleep 2
ABC1=$c5 && ABC2=$c4 && ABC3=$c2 && nat4 && WGC Fins
the fi
if [[ -z $v6 && -n $v4 ]]; then
green "The current native v4 single-stack vps installs wgcf-warp for the first time\nNow add IPV4 single-stack wgcf-warp mode" && sleep 2
ABC1=$c5 && ABC2=$c2 && ABC3=$c3 && ABC4=$ud4 && WGC Fins
the fi
echo 'w4' > /root/warpip/wp.log
first4
else
wg-quick down wgcf >/dev/null 2>&1
sleep 1 && v4v6
if [[ -n $v4 && -n $v6 ]]; then
green "Current native v4+v6 dual-stack vps has installed wgcf-warp\nNow quickly switch to IPV4 single-stack wgcf-warp mode" && sleep 2
conf && ABC1=$c5 && ABC2=$c2 && ABC3=$ud4 && ABC4=$c3 && ABC
the fi
if [[ -n $v6 && -z $v4 ]]; then
green "Current native v6 single-stack vps has installed wgcf-warp\nNow quickly switch to IPV4 single-stack wgcf-warp mode" && sleep 2
conf && ABC1=$c5 && ABC2=$c4 && ABC3=$c2 && nat4 && ABC
the fi
if [[ -z $v6 && -n $v4 ]]; then
green "Current native v4 single-stack vps has installed wgcf-warp\nNow quickly switch to IPV4 single-stack wgcf-warp mode" && sleep 2
conf && ABC1=$c5 && ABC2=$c2 && ABC3=$c3 && ABC4=$ud4 && ABC
the fi
echo 'w4' > /root/warpip/wp.log
CheckWARP && first4 && ShowWGCF && WGCFmenu
the fi
}

WGCFv6(){
yellow "Wait for 3 seconds to detect the warp environment in the VPS"
docker && checkwgcf
if [[ ! $wgcfv4 =~ on|plus && ! $wgcfv6 =~ on|plus ]]; then
v4v6
if [[ -n $v4 && -n $v6 ]]; then
green "Current native v4+v6 dual-stack vps install wgcf-warp for the first time\nNow add IPV6 single-stack wgcf-warp mode" && sleep 2
ABC1=$c5 && ABC2=$c1 && ABC3=$ud6 && ABC4=$c3 && WGC Fins
the fi
if [[ -n $v6 && -z $v4 ]]; then
green "Current native v6 single-stack vps install wgcf-warp for the first time\nNow add IPV6 single-stack wgcf-warp mode (no IPV4!!!)" && sleep 2
ABC1=$c6 && ABC2=$c1 && ABC3=$c4 && nat4 && ABC5=$ud6 && WGC Fins
the fi
if [[ -z $v6 && -n $v4 ]]; then
green "The current native v4 single-stack vps installs wgcf-warp for the first time\nNow add IPV6 single-stack wgcf-warp mode" && sleep 2
ABC1=$c5 && ABC2=$c3 && ABC3=$c1 && WGC Fins
the fi
echo 'w6' > /root/warpip/wp.log
else
wg-quick down wgcf >/dev/null 2>&1
sleep 1 && v4v6
if [[ -n $v4 && -n $v6 ]]; then
green "Current native v4+v6 dual-stack vps has installed wgcf-warp\nNow quickly switch to IPV6 single-stack wgcf-warp mode" && sleep 2
conf && ABC1=$c5 && ABC2=$c1 && ABC3=$ud6 && ABC4=$c3 && ABC
the fi
if [[ -n $v6 && -z $v4 ]]; then
green "Current native v6 single-stack vps has installed wgcf-warp\nNow quickly switch to IPV6 single-stack wgcf-warp mode (no IPV4!!!)" && sleep 2
conf && ABC1=$c6 && ABC2=$c1 && ABC3=$c4 && nat4 && ABC5=$ud6 && ABC
the fi
if [[ -z $v6 && -n $v4 ]]; then
green "Current native v4 single-stack vps has installed wgcf-warp\nNow quickly switch to IPV6 single-stack wgcf-warp mode" && sleep 2
conf && ABC1=$c5 && ABC2=$c3 && ABC3=$c1 && ABC
the fi
echo 'w6' > /root/warpip/wp.log
CheckWARP && first4 && ShowWGCF && WGCFmenu
the fi
}

WGCFv4v6(){
yellow "Wait for 3 seconds to detect the warp environment in the VPS"
docker && checkwgcf
if [[ ! $wgcfv4 =~ on|plus && ! $wgcfv6 =~ on|plus ]]; then
v4v6
if [[ -n $v4 && -n $v6 ]]; then
green "Current native v4+v6 dual-stack vps install wgcf-warp for the first time\nNow add IPV4+IPV6 dual-stack wgcf-warp mode" && sleep 2
ABC1=$c5 && ABC2=$ud4ud6 && ABC3=$c3 && WGC Fins
the fi
if [[ -n $v6 && -z $v4 ]]; then
green "Current native v6 single-stack vps install wgcf-warp for the first time\nNow add IPV4+IPV6 dual-stack wgcf-warp mode" && sleep 2
ABC1=$c5 && ABC2=$c4 && ABC3=$ud6 && nat4 && WGC Fins
the fi
if [[ -z $v6 && -n $v4 ]]; then
green "The current native v4 single-stack vps installs wgcf-warp for the first time\nNow add IPV4+IPV6 dual-stack wgcf-warp mode" && sleep 2
ABC1=$c5 && ABC2=$c3 && ABC3=$ud4 && WGC Fins
the fi
echo 'w64' > /root/warpip/wp.log
else
wg-quick down wgcf >/dev/null 2>&1
sleep 1 && v4v6
if [[ -n $v4 && -n $v6 ]]; then
green "The current native v4+v6 dual-stack vps has installed wgcf-warp\nnow quickly switch to IPV4+IPV6 dual-stack wgcf-warp mode" && sleep 2
conf && ABC1=$c5 && ABC2=$ud4ud6 && ABC3=$c3 && ABC
the fi
if [[ -n $v6 && -z $v4 ]]; then
green "Current native v6 single-stack vps has installed wgcf-warp\nNow quickly switch to IPV4+IPV6 dual-stack wgcf-warp mode" && sleep 2
conf && ABC1=$c5 && ABC2=$c4 && ABC3=$ud6 && nat4 && ABC
the fi
if [[ -z $v6 && -n $v4 ]]; then
green "Current native v4 single-stack vps has installed wgcf-warp\nNow quickly switch to IPV4+IPV6 dual-stack wgcf-warp mode" && sleep 2
conf && ABC1=$c5 && ABC2=$c3 && ABC3=$ud4 && ABC
the fi
echo 'w64' > /root/warpip/wp.log
CheckWARP && first4 && ShowWGCF && WGCFmenu
the fi
}

CheckWARP(){
i=0
wg-quick down wgcf >/dev/null 2>&1
while [ $i -le 9 ]; do let i++
yellow "A total of 10 executions, the $i time to obtain the warp's IP..."
systemctl restart wg-quick@wgcf >/dev/null 2>&1
checkwgcf
[[ $wgcfv4 =~ on|plus || $wgcfv6 =~ on|plus ]] && green "Congratulations! The IP of the warp has been obtained successfully!" && break || red "Unfortunately! The IP of the warp has failed"
done
checkwgcf
if [[ ! $wgcfv4 =~ on|plus && ! $wgcfv6 =~ on|plus ]]; then
red "Failed to install WARP, restore VPS, uninstall Wgcf-WARP component..."
cwg && rm -rf /root/warpip
echo
[[ $release = Centos && ${vsid} -lt 7 ]] && yellow "Current system version number: Centos $vsid \nIt is recommended to use a system above Centos 7"
[[ $release = Ubuntu && ${vsid} -lt 18 ]] && yellow "Current system version number: Ubuntu $vsid \nIt is recommended to use Ubuntu 18 or above"
[[ $release = Debian && ${vsid} -lt 10 ]] && yellow "Current system version number: Debian $vsid \nIt is recommended to use Debian 10 or above"
yellow "Hint:"
red "You may be able to use Option 2 or 3 for WARP"
red "You can also choose the WARP-GO core to install WARP solution one"
exit
else
green "ok"
the fi
}

WGCFins(){
rm -rf /usr/local/bin/wgcf /etc/wireguard/wgcf.conf /etc/wireguard/wgcf-profile.conf /etc/wireguard/wgcf-account.toml /etc/wireguard/wgcf+p.log / etc/wireguard/ID /usr/bin/wireguard-go /usr/bin/wgcf wgcf-account.toml wgcf-profile.conf
ShowWGCF
if [[ $release = Centos ]]; then
if [[ ${vsid} =~ 8 ]]; then
cd /etc/yum.repos.d/ && mkdir backup && mv *repo backup/
curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-8.repo
sed -i -e "s|mirrors.cloud.aliyuncs.com|mirrors.aliyun.com|g " /etc/yum.repos.d/CentOS-*
sed -i -e "s|releasever|releasever-stream|g" /etc/yum.repos.d/CentOS-*
yum clean all && yum makecache
the fi
yum install epel-release -y; yum install iproute iptables wireguard-tools -y
elif [[ $release = Debian ]]; then
apt install lsb-release -y
echo "deb http://deb.debian.org/debian $(lsb_release -sc)-backports main" | tee /etc/apt/sources.list.d/backports.list
apt update -y;apt install iproute2 openresolv dnsutils iptables -y;apt install wireguard-tools --no-install-recommends -y      		
elif [[ $release = Ubuntu ]]; then
apt update -y;apt install iproute2 openresolv dnsutils iptables -y;apt install wireguard-tools --no-install-recommends -y			
the fi
wget -N https://gitlab.com/rwkgyg/cfwarp/raw/main/wgcf_2.2.17_$cpu -O /usr/local/bin/wgcf && chmod +x /usr/local/bin/wgcf         
if [[ $main -lt 5 || $minor -lt 6 ]] || [[ $vi =~ lxc|openvz ]]; then
[[ -e /usr/bin/wireguard-go ]] || wget -N https://gitlab.com/en_project/CFwrap_en/-/blob/main/wireguard-go -O /usr/bin/wireguard-go && chmod +x /usr/bin/wireguard-go
the fi
echo | wgcf register
until [[ -e wgcf-account.toml ]]
do
yellow "During the process of applying for a warp ordinary account, there may be multiple prompts: 429 Too Many Requests, please wait for 30 seconds" && sleep 1
echo | wgcf register --accept-tos
done
wgcf generate
mtuwarp
sed -i "s/MTU.*/MTU=$MTU/g" wgcf-profile.conf
warpip
cp -f wgcf-profile.conf /etc/wireguard/wgcf.conf >/dev/null 2>&1
cp -f wgcf-account.toml /etc/wireguard/buckup-account.toml >/dev/null 2>&1
ABC
mv -f wgcf-profile.conf /etc/wireguard >/dev/null 2>&1
mv -f wgcf-account.toml /etc/wireguard >/dev/null 2>&1
systemctl enable wg-quick@wgcf >/dev/null 2>&1
CheckWARP && ShowWGCF && xyz && WGCFmenu && lncf && reswarp
}

WARPup(){
[[ ! $(type -P wg-quick) ]] && red "wgcf-warp is not installed, only after wgcf-warp is installed" && sleep 3 && bash CFwarp.sh
backconf(){
red "upgrade failed, automatically restore warp normal account"
sed -i "2s#.*#$(sed -ne 2p /etc/wireguard/wgcf-profile.conf)#;4s#.*#$(sed -ne 4p /etc/wireguard/wgcf-profile.conf) #" /etc/wireguard/wgcf.conf
CheckWARP && ShowWGCF && WGCFmenu
}
ab="1.Teams account\n2.warp+account\n3.Normal warp account\n0. Return to the previous level\n Please choose:"
readp "$ab" cd
case "$cd" in
1 )
red "It is recommended to use the warp-go solution to directly obtain the Teams team account with a high probability, without the need to extract parameter upgrades"
[[ ! -e /etc/wireguard/wgcf.conf ]] && red "Unable to find the wgcf-warp configuration file, it is recommended to reinstall wgcf-warp" && bash CFwarp.sh
readp "Please copy privateKey (44 characters):" Key
readp "Please copy the IPV6 Address:" Add
if [[ -n $Key && -n $Add ]]; then
sed -i "s#PrivateKey.*#PrivateKey = $Key#g;s#Address.*128#Address = $Add/128#g" /etc/wireguard/wgcf.conf
systemctl restart wg-quick@wgcf >/dev/null 2>&1
checkwgcf
if [[ $wgcfv4 = plus || $wgcfv6 = plus ]]; then
rm -rf /etc/wireguard/wgcf+p.log && green "wgcf-warp+Teams account is active" && ShowWGCF && WGCFmenu
else
backconf
the fi
else
backconf
fi;;
2 )
ShowWGCF
[[ $wgcfv4 = plus || $wgcfv6 = plus ]] && red "It is already a Wgcf-WARP+ account, no need to upgrade" && bash CFwarp.sh
readp "Please ensure that the warp client on the phone is in the warp+ state, copy the key license key (26 characters):" ID
[[ -n $ID ]] && sed -i "s/license_key.*/license_key = '$ID'/g" /etc/wireguard/wgcf-account.toml && readp "Rename the device name (directly enter random named):" sbmc || (red "keystroke license key not entered (26 characters)" && bash CFwarp.sh)
[[ -n $sbmc ]] && SBID="--name $(echo $sbmc | sed s/[[:space:]]/_/g)"
cd /etc/wireguard && wgcf update $SBID > /etc/wireguard/wgcf+p.log 2>&1
wgcf generate && cd
sed -i "2s#.*#$(sed -ne 2p /etc/wireguard/wgcf-profile.conf)#;4s#.*#$(sed -ne 4p /etc/wireguard/wgcf-profile.conf) #" /etc/wireguard/wgcf.conf
CheckWARP && checkwgcf
if [[ $wgcfv4 = plus || $wgcfv6 = plus ]]; then
warppflow=$((`grep -oP '"quota":\K\d+' <<< $(curl -s "https://api.cloudflareclient.com/v0a884/reg/$(grep 'device_id' /etc /wireguard/wgcf-account.toml 2>/dev/null | cut -d \' -f2)" -H "User-Agent: okhttp/3.12.1" -H "Authorization: Bearer $(grep 'access_token' / etc/wireguard/wgcf-account.toml 2>/dev/null | cut -d \' -f2)")`))
flow=`echo "scale=2; $warppflow/1000000000" | bc`
green "Upgraded to wgcf-warp+ account\nwgcf-warp+ account device name: $(grep -s 'Device name' /etc/wireguard/wgcf+p.log | awk '{ print $NF }')\nwgcf-warp+ Account remaining traffic: $flow GB"
ShowWGCF && WGCFmenu
else
red "After IP detection, warp+ upgrade failed. Please make sure that the key does not use more than 5 devices. It is recommended to change the key and try again. The script exits" && exit
fi;;
3)
checkwgcf
if [[ $wgcfv4 = plus || $wgcfv6 = plus ]]; then
fawgcf
else
yellow "Currently it is a normal account of wgcf-warp"
ShowWGCF && WGCFmenu
fi;;
0) bash CFwarp.sh
esac
}

WARPonoff(){
[[ ! $(type -P wg-quick) ]] && red "WARP is not installed, it is recommended to reinstall" && bash CFwarp.sh
readp "1. Turn off WARP function (turn off WARP online monitoring)\n2. Turn on/restart WARP function (start WARP online monitoring)\n0. Return to the previous layer\n Please select:" unwp
if [ $unwp == "1" ]; then
wg-quick down wgcf >/dev/null 2>&1
systemctl stop wg-quick@wgcf >/dev/null 2>&1
systemctl disable wg-quick@wgcf >/dev/null 2>&1
screen -ls | awk '/\.up/ {print $1}' | cut -d "." -f 1 | xargs kill 2>/dev/null
unreswarp
checkwgcf
[[ ! $wgcfv4 =~ on|plus && ! $wgcfv6 =~ on|plus ]] && green "closing warp successfully" || red "closing warp failed"
elif [ $unwp == "2" ]; then
wg-quick down wgcf >/dev/null 2>&1
systemctl restart wg-quick@wgcf >/dev/null 2>&1
xyz
name=`screen -ls | grep '(Detached)' | awk '{print $1}' | awk -F "." '{print $2}'`
[[ $name =~ "up" ]] && green "WARP online monitoring started successfully" || red "WARP online monitoring failed to start, check whether the screen is installed successfully"
reswarp
checkwgcf
[[ $wgcfv4 =~ on|plus || $wgcfv6 =~ on|plus ]] && green "open warp successfully" || red "open warp failed"
else
bash CFwarp.sh
the fi
}

cwg(){
screen -ls | awk '/\.up/ {print $1}' | cut -d "." -f 1 | xargs kill 2>/dev/null
wg-quick down wgcf >/dev/null 2>&1
systemctl disable wg-quick@wgcf >/dev/null 2>&1
$ yumapt remove wireguard-tools
$yumapt autoremove
dig9
sed -i '/^precedence ::ffff:0:0\/96 100/d;/^label 2002::\/16 2/d' /etc/gai.conf 2>/dev/null
rm -rf /usr/local/bin/wgcf /usr/bin/wg-quick /etc/wireguard/wgcf.conf /etc/wireguard/wgcf-profile.conf /etc/wireguard/buckup-account.toml /etc/ wireguard/wgcf-account.toml /etc/wireguard/wgcf+p.log /etc/wireguard/ID /usr/bin/wireguard-go /usr/bin/wgcf wgcf-account.toml wgcf-profile.conf /root/ WARP-UP.sh
}

WARPun(){
ab="1. Only uninstall warp\n2. Only uninstall socks5-warp\n3. Completely uninstall warp (1+2)\n Please choose:"
readp "$ab" cd
case "$cd" in
1) cwg && green "warp uninstall complete" && ShowWGCF && WGCFmenu;;
2) cso && green "socks5-warp uninstall complete" && ShowSOCKS5 && S5menu;;
3) cwg && rm -rf /root/warpip && cso && unreswarp && green "warp and socks5-warp have been uninstalled" && ShowWGCF;ShowSOCKS5;IP_Status_menu;;
esac
}

UPwpyg(){
if [[ ! $(type -P wg-quick) && ! $(type -P warp-cli) ]] && [[ ! -f '/root/CFwarp.sh' ]]; then
red "CFwarp script not installed normally!" && exit
the fi
upcfwarp
}

warpinscha(){
yellow "Prompt: The local outbound IP of the VPS will be taken over by the warp IP you selected. If the VPS does not have the outbound IP locally, it will be taken over by another warp generated IP"
echo
yellow "If you don't understand anything, press Enter!!!"
echo
green "1. Install/switch wgcf-warp single-stack IPV4 (enter default)"
green "2. Install/switch wgcf-warp single-stack IPV6"
green "3. Install/switch wgcf-warp dual-stack IPV4+IPV6"
readp "\nPlease select:" wgcfwarp
if [ -z "${wgcfwarp}" ] || [ $wgcfwarp == "1" ];then
WGCFv4
elif [ $wgcfwarp == "2" ];then
WGCFv6
elif [ $wgcfwarp == "3" ];then
WGCFv4v6
else
red "Input error, please choose again" && warpinscha
the fi
echo
}  

changewarp(){
cwg && ONEWARPGO
}

start_menu(){
ShowWGCF;ShowSOCKS5
clear
echo
white "Yongge Github project: github.com/yonggekkk"
white "Yongge blogger blog: ygkkk.blogspot.com"
white "Brother Yong YouTube channel: www.youtube.com/@ygkkk"
yellow "Translate By : Mohammad javad Hassanpour"
yellow "Telegram ID : https://t.me/javadhpr1372"
green "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~"
yellow "Choose the warp reality scheme that suits you arbitrarily (options 1, 2, 3, single choice, multiple choices can coexist)"
yellow "Enter script shortcut: cf"
white " =================================================== =================="
green " 1. Solution 1: Install/Switch WGCF-WARP"
[[ $cpu != amd64* ]] && red " 2. Tip: The CPU of the current VPS is not AMD64 architecture, currently does not support the installation of Socks5-WARP" || green " 2. Solution 2: Install Socks5-WARP"
green " 3. Solution 3: Display Xray-WireGuard-WARP proxy configuration file and QR code"
green " 4. Uninstall WARP"
white " ----------------------------------------------- -----------------"
green " 5. Turn off, turn on/restart WARP"
green " 6. Other WARP options: check WARP process daemon, brush WARP+ traffic..."
green " 7. WARP three types of account upgrade/switch (WARP/WARP+/WARP Teams)"
green " 8. Update CFwarp installation script"
green " 9. Replace the current WGCF-WARP kernel with the WARP-GO kernel"
green " 0. exit script"
red "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
if [[ $(type -P wg-quick) || $(type -P warp-cli) ]] && [[ -f '/root/CFwarp.sh' ]]; then
if [ "${wpygV}" = "${remoteV}" ]; then
echo -e "Current CFwarp script version number: ${bblue}${wpygV}${plain} reset version 4, already the latest version\n"
else
echo -e "Current CFwarp script version number: ${bblue}${wpygV}${plain}"
echo -e "The latest CFwarp script version number is detected: ${yellow}${remoteV}${plain}"
echo -e " ${yellow}$(wget -qO- https://gitlab.com/rwkgyg/CFwarp/raw/main/version/warpV)${plain}"
echo -e "Option 8 for update\n"
the fi
the fi
red "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
white "VPS system information is as follows:"
white " Operating system: $(blue "$op") \c" && white " Kernel version: $(blue "$version") \c" && white " CPU architecture: $(blue "$cpu") \c" && white "Virtualization type: $(blue "$vi")"
IP_Status_menu
echo
readp "Please enter the number:" Input
case "$Input" in     
 1) warpinscha;;
 2) [[ $cpu = amd64 ]] && SOCKS5ins || bash CFwarp.sh;;
 3) WGproxy;;
 4) WARPun && uncf;;
 5)WARPonoff;;
 6) WARPtools;;
 7) WARPup;;
 8) UPwpyg;;
 9) changewarp;;
 * ) exit
esac
}

if [ $# == 0 ]; then
cpujg
start_menu
the fi
}

startCFwarp(){
clear
echo
white "Yongge Github project: github.com/yonggekkk"
white "Yongge blogger blog: ygkkk.blogspot.com"
white "Brother Yong YouTube channel: www.youtube.com/@ygkkk"
yellow "Translate By : Mohammad javad Hassanpour"
yellow "Telegram ID : https://t.me/javadhpr1372"
green "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~"
yellow "Hint:"
yellow " 1. Options 1 and 2 can be selected arbitrarily, and mutual switching is supported"
yellow " 2. Enter the script shortcut: cf"
white " =================================================== =================="
green " 1. Choose warp-go kernel to install WARP"
green " 2. Select wgcf kernel to install WARP (currently recommended)"
green " 0. exit script"
white " =================================================== =================="
echo
readp "Please enter the number:" Input
case "$Input" in     
 1) ONEWARPGO;;
 2) ONEWGCFWARP;;
 * ) exit
esac
}
if [ $# == 0 ]; then
if [[ -n $(type -P warp-go) && -z $(type -P wg-quick) ]] && [[ -f '/root/CFwarp.sh' ]]; then
ONEWARPGO
elif [[ -n $(type -P warp-go) && -n $(type -P warp-cli) && -z $(type -P wg-quick) ]] && [[ -f '/root/CFwarp .sh' ]]; then
ONEWARPGO
elif [[ -z $(type -P warp-go) && -z $(type -P wg-quick) && -n $(type -P warp-cli) ]] && [[ -f '/root/CFwarp .sh' ]]; then
ONEWARPGO
elif [[ -n $(type -P wg-quick) && -z $(type -P warp-go) ]] && [[ -f '/root/CFwarp.sh' ]]; then
ONE WGCFWARP
elif [[ -n $(type -P wg-quick) && -n $(type -P warp-cli) && -z $(type -P warp-go) ]] && [[ -f '/root/CFwarp .sh' ]]; then
ONE WGCFWARP
else
start CFwarp
the fi
the fi

   