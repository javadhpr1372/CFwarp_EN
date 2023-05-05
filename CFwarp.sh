#!/bin/bash
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export LANGUAGE=in_US.UTF-8
wpygV="22.9.27V 0.3"
remoteV=`wget -qO- https://github.com/javadhpr1372/CFwarp_EN/raw/main/CFwarp.sh | sed -n 4p | cut -d '"' -f 2`
red='\033[0;31m'
blue='\033[0;34m'
yellow='\033[0;33m'
green='\033[0;32m'
plain='\033[0m'
network(){ echo -e "\033[31m\033[01m$1\033[0m";}
green(){ echo -e "\033[32m\033[01m$1\033[0m";}
yellow(){ echo -e "\033[33m\033[01m$1\033[0m";}
blue(){ echo -e "\033[36m\033[01m$1\033[0m";}
white(){ echo -e "\033[37m\033[01m$1\033[0m";}
bblue(){ echo -e "\033[34m\033[01m$1\033[0m";}
rred(){ echo -e "\033[35m\033[01m$1\033[0m";}
readtp(){ read -t5 -n26 -p "$(yellow "$1")" $2;}
readp(){ read -p "$(yellow "$1")" $2;}
[[ $EUID -ne 0 ]] && yellow " Please run the script as root " && exit

start(){
yellow " Please wait for 3 seconds ... Scanning the vps type and parameters ..."
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
red " Your current system is not supported , please choose to use Ubuntu, Debian, Centos system . " && rm -f CFwarp.sh && exit
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
bit=`uname -m`
[[ $bit = x86_64 ]] && cpu=amd64
[[ $bit = aarch64 ]] && cpu=arm64
vi=`systemd-detect-virt`
if [[ $vi = openvz ]]; then
TUN=$(cat /dev/net/tun 2>&1)
if [[ ! $TUN =~ 'in bad state' ]] && [[ ! $TUN =~ 'in bad state ' ]] && [[ ! $TUN =~ 'Die Dateizugriffsnummer ist in schlechter Verfassung' ]]; then
red " Detected that TUN is not enabled , now try to add TUN support " && sleep 4
cd /dev
mkdir net
mknod net/tun c 10 200
chmod 0666 net /tun
TUN=$(cat /dev/net/tun 2>&1)
if [[ ! $TUN =~ 'in bad state' ]] && [[ ! $TUN =~ 'in bad state ' ]] && [[ ! $TUN =~ 'Die Dateizugriffsnummer ist in schlechter Verfassung' ]]; then
green " Failed to add TUN support , it is recommended to communicate with the VPS manufacturer or enable the background setting " && exit
else
cat <<EOF> /root/tun.sh
#!/bin/bash
cd /dev
mkdir net
mknod net/tun c 10 200
chmod 0666 net /tun
EOF
chmod +x /root/tun.sh
grep -qE "^ *@reboot root bash /root/tun.sh >/dev/null 2>&1" /etc/crontab || echo "@reboot root bash /root/tun.sh >/dev/null 2> &1" >> /etc/crontab
green "TUN daemon function started "
the fi
the fi
the fi
if [[ ! -f /root/nf || ! -s /root/nf ]]; then
wget -O nf https://raw.githubusercontent.com/rkygogo/netflix-verify/main/nf_linux_$cpu
chmod +x nf
the fi
[[ $(type -P yum) ]] && yumapt='yum -y' || yumapt='apt -y'
[[ $(type -P curl) ]] || (yellow " Curl is not installed, upgrading and installing " && $yumapt update;$yumapt install curl)
[[ $(type -P bc) ]] || ($yumapt update;$yumapt install bc)
[[ ! $(type -P qrencode) ]] && ($yumapt update;$yumapt install qrencode)
[[ ! $(type -P python3) ]] && (yellow " It is detected that python3 is not installed, upgrading and installing " && $yumapt update;$yumapt install python3)
[[ ! $(type -P screen) ]] && (yellow " It is detected that the screen is not installed, and the upgrade is being installed " && $yumapt update;$yumapt install screen)
{
ud4='sed -i "7 s/^/PostUp = ip -4 rule add from $(ip route get 162.159.192.1 | grep -oP '"'src \K\S+') lookup main\n/"'" /etc/wireguard/wgcf.conf && sed -i "7 s/^/PostDown = ip -4 rule delete from $(ip route get 162.159.192.1 | grep -oP '"'src \K\S+') lookup main\n/"'" /etc/wireguard/wgcf.conf'
ud6='sed -i "7 s/^/PostUp = ip -6 rule add from $(ip route get 2606:4700:d0::a29f:c001 | grep -oP '"'src \K\S+') lookup main\n/"'" /etc/wireguard/wgcf.conf && sed -i "7 s/^/PostDown = ip -6 rule delete from $(ip route get 2606:4700:d0::a29f:c001 | grep -oP '"'src \K\S+') lookup main\n/"'" /etc/wireguard/wgcf.conf'
ud4ud6='sed -i "7 s/^/PostUp = ip -4 rule add from $(ip route get 162.159.192.1 | grep -oP '"'src \K\S+') lookup main\n/"'" /etc/wireguard/wgcf.conf && sed -i "7 s/^/PostDown = ip -4 rule delete from $(ip route get 162.159.192.1 | grep -oP '"'src \K\S+') lookup main\n/"'" /etc/wireguard/wgcf.conf && sed -i "7 s/^/PostUp = ip -6 rule add from $(ip route get 2606:4700:d0::a29f:c001 | grep -oP '"'src \K\S+') lookup main\n/"'" /etc/wireguard/wgcf.conf && sed -i "7 s/^/PostDown = ip -6 rule delete from $(ip route get 2606:4700:d0::a29f:c001 | grep -oP '"'src \K\S+') lookup main\n/"'" /etc/wireguard/wgcf.conf'
c1="sed -i '/0\.0\.0\.0\/0/d' /etc/wireguard/wgcf.conf"
c2="sed -i '/\:\:\/0/d' /etc/wireguard/wgcf.conf"
c3="sed -i 's/engage.cloudflareclient.com/162.159.193.10/g' /etc/wireguard/wgcf.conf"
c4="sed -i 's/engage.cloudflareclient.com/2606:4700:d0::a29f:c001/g' /etc/wireguard/wgcf.conf"
c5="sed -i 's/1.1.1.1/8.8.8.8,2001:4860:4860::8888/g' /etc/wireguard/wgcf.conf"
c6="sed -i 's/1.1.1.1/2001:4860:4860::8888,8.8.8.8/g' /etc/wireguard/wgcf.conf"

v4v6(){
v6=$(curl -s6m6 ip.p3terx.com -k | sed -n 1p)
v4=$(curl -s4m6 ip.p3terx.com -k | sed -n 1p)
}

checkwgcf(){
wgcfv6=$(curl -s6m6 https://www.cloudflare.com/cdn-cgi/trace -k | grep warp | cut -d= -f2) 
wgcfv4=$(curl -s4m6 https://www.cloudflare.com/cdn-cgi/trace -k | grep warp | cut -d= -f2) 
}

ShowWGCF(){
UA_Browser="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.87 Safari/537.36"
v4v6
warppflow=$((`grep -oP '"quota":\K\d+' <<< $(curl -s "https://api.cloudflareclient.com/v0a884/reg/$(grep 'device_id' /etc/wireguard/wgcf-account.toml 2>/dev/null | cut -d \' -f2)" -H "User-Agent: okhttp/3.12.1" -H "Authorization: Bearer $(grep 'access_token' /etc/wireguard/wgcf-account.toml 2>/dev/null | cut -d \' -f2)")`))
flow=`echo "scale=2; $warppflow/1000000000" | bc`
[[ -e /etc/wireguard/wgcf+p.log ]] && cfplus="WARP+ common account ( limited WARP+ traffic: $flow GB) , device name: $(grep -s 'Device name' /etc/wireguard/ wgcf+p.log | awk '{ print $NF }')" || cfplus="WARP+Teams account ( unlimited WARP+ traffic )"
if [[ -n $v4 ]]; then
wgcfv4=$(curl -s4 https://www.cloudflare.com/cdn-cgi/trace -k | grep warp | cut -d= -f2)
isp4a=`curl -sm6 --user-agent "${UA_Browser}" http://ip-api.com/json/$v4?lang=zh-CN -k | cut -f13 -d ":" | cut -f2 -d '"'`
isp4b=`curl -sm6 --user-agent "${UA_Browser}" https://api.ip.sb/geoip/$v4 -k | awk -F "isp" '{print $2}' | awk -F "offset" '{print $1}' | sed "s/[,\":]//g"`
[[ -n $sp4a ]] && sp4=$sp4a || isp4=$isp4b
nonf=$(curl -sm6 --user-agent "${UA_Browser}" http://ip-api.com/json/$v4?lang=zh-CN -k | cut -f2 -d"," | cut -f4 -d '"')
sunf=$(./nf | awk '{print $1}' | sed -n '4p')
snnf=$(curl - s4m6 ip.p3terx.com -k | sed -n 2p | awk '{print $3}')
if [[ -n $sunf ]]; then
country=$sunf
elif [[ -z $sunf && -n $nonf ]]; then
country=$nonf
else
country=$snnf
and
case ${wgcfv4} in
plus)
WARPIPv4Status=$(white "WARP+ status : \c" ; rred " Running, $cfplus" ; white " Service provider Cloudflare obtains IPV4 address: \c" ; rred "$v4 $country" ; white " Netflix NF Unlocking : \c" ; rred "$(./nf | awk '{print $1}' | sed -n '3p')");;
on)
WARPIPv4Status=$(white "WARP status : \c" ; green " running, WARP common account ( unlimited WARP traffic )" ; white " service provider Cloudflare obtains IPV4 address: \c" ; green "$v4 $country" ; white " Netflix NF unlocking situation: \c" ; green "$(./nf | awk '{ print $1}' | sed -n '3p')");;
off)
WARPIPv4Status=$(white "WARP status : \c" ; yellow " Closing " ; white " Service provider $isp4 obtains IPV4 address: \ c" ; yellow "$v4 $country" ; white " Netflix NF solution Lock condition: \c" ; yellow "$(./nf | awk '{print $1}' | sed -n '3p')");;
esac
WARPIPv4Status=$(white "IPV4Configuration : \ c" ; red " Register IPV4Status ")
fee
if [[ -n $v6 ]]; then
wgcfv6=$(curl -s6 https://www.cloudflare.com/cdn-cgi/trace -k | grep warp | cut -d= -f2)
isp6a=`curl -sm6 --user-agent "${UA_Browser}" http://ip-api.com/json/$v6?lang=zh-CN -k | cut -f13 -d":" | cut -f2 -d '"''
isp6b=`curl -sm6 --user-agent "${UA_Browser}" https://api.ip.sb/geoip/$v6 -k | awk -F "isp" '{print $2}' | awk -F "offset" '{print $1}' | sed "s/[,\":]//g"`
[[ -n $white ]] && white=$white || isp6=$isp6b
nonf=$(curl -sm6 --user-agent "${UA_Browser}" http://ip-api.com/json/$v6?lang=zh-CN -k | cut -f2 -d"," | cut -f4 -d '"')
sunf=$(./nf | awk '{print $1}' | sed -n '8p')
snnf=$(curl - s6m6 ip.p3terx.com -k | sed -n 2p | awk '{print $3}')
if [[ -n $sunf ]]; then
country=$sunf
elif [[ -z $sunf && -n $nonf ]]; then
country=$nonf
else
country=$snnf
and
case ${wgcfv6} in
plus)
WARPIPv6Status=$(white "WARP+ status : \c" ; rred " Running, $cfplus" ; white " Service provider Cloudflare obtains IPV6 address: \c" ; rred "$v6 $country" ; white " Netflix NF Unlocking : \c" ; rred "$(./nf | awk '{print $1}' | sed -n '7p')");;
on)
WARPIPv6Status=$(white "WARP status : \c" ; green " running, WARP common account ( unlimited WARP traffic )" ; white " service provider Cloudflare obtains IPV6 address: \c" ; green "$v6 $country" ; white " Netflix NF unlocking situation: \c" ; green "$(./nf | awk '{ print $1}' | sed -n '7p')");;
off)
WARPIPv6Status=$(white "WARP status : \c" ; yellow " Closing " ; white " Service provider $isp6 obtains IPV6 address: \c " ; yellow "$v6 $country" ; white " Netflix NF solution Lock condition: \c" ; yellow "$(./nf | awk '{print $1}' | sed -n '7p')");;
esac
else
WARPIPv6Status=$(white "IPV6状态：\c" ; red "不存在IPV6地址 ")
fi 
}

get_char(){
SAVEDSTTY=`stty -g`
stty -echo
stty cbreak
dd if=/dev/tty bs=1 count=1 2> /dev/null
stty -raw
stty echo
stty $SAVEDSTTY
}

dig9(){
if [[ -n $(grep 'DiG 9' /etc/hosts) ]]; then
echo -e "search blue.kundencontroller.de\noptions rotate\nnameserver 2a02:180:6:5::1c\nnameserver 2a02:180:6:5::4\nnameserver 2a02:180:6:5::1e\nnameserver 2a02:180:6:5::1d" > /etc/resolv.conf
the fi
}

docker(){
if [[ -n $(ip a | grep docker) ]]; then
red " It is detected that docker has been installed on the VPS . If you continue to install wgcf-warp , docker may fail "
sleep 3s
yellow " Continue to install after 6 seconds , please press Ctrl+c to exit the installation"
sleep 6s
the fi
}

STOPwgcf(){
if [[ $(type -P warp-cli) ]]; then
red " Socks5-WARP(+) has been installed , and the currently selected wgcf-warp installation scheme is not supported "
systemctl restart wg-quick@wgcf ; bash CFwarp.sh
the fi
}

lncf(){
if [[ $(type -P wg-quick) || $(type -P warp-cli) ]]; then
chmod +x /root/CFwarp.sh
ln -sf /root/CFwarp.sh /usr/bin/cf
the fi
}

first4(){
checkwgcf
if [[ $wgcfv4 =~ on|plus && -z $wgcfv6 ]]; then
[[ -n /etc/gai.conf ]] && grep -qE '^ *precedence ::ffff:0:0/96 100' /etc/gai.conf || echo 'precedence ::ffff:0:0/ 96 100' >> /etc/gai.conf
sed -i '/^label 2002::\/16   2/d' /etc/gai.conf
else
sed -i '/^precedence ::ffff:0:0\/96  100/d;/^label 2002::\/16   2/d' /etc/gai.conf
fi
}

fawgcf(){
rm -f /etc/wireguard/wgcf+p.log
ID=$(cat /etc/wireguard/buckup-account.toml | grep license_key | awk '{print $3}')
sed -i "s/license_key.*/license_key = $ID/g" /etc/wireguard/wgcf-account.toml
cd /etc/wireguard && wgcf update >/dev/null 2>&1
wgcf generate >/dev/null 2>&1 && cd
sed -i "2s#.*#$(sed -ne 2p /etc/wireguard/wgcf-profile.conf)#;4s#.*#$(sed -ne 4p /etc/wireguard/wgcf-profile.conf)#" /etc/wireguard/wgcf.conf
CheckWARP
ShowWGCF && WGCFmenu
}

WGproxy(){
[[ ! $(type -P wg-quick) ]] && red " Wgcf-WARP not installed " && bash CFwarp.sh
blue "\nWireguard client related setting instructions, please pay attention to Yongge blog "
green "\nAccording to the network environment, select the Endpoint peer IP address of the Wireguard proxy node "
readp "1. Use IPV4 address ( support v4 or v6+v4 network environment, press enter to default )\n2. Use IPV6 address ( only support v6+v4 network environment )\nPlease choose: " IPet
if [ -z "${IPet}" ] || [ $IPet == "1" ];then
endip=162.159.193.10
elif [ $IPet == "2" ];then
endip=[2606:4700:d0::]
else
red " Input error, please choose again " && WGproxy
the fi
cp -f /etc/wireguard/wgcf.conf /etc/wireguard/wgproxy.conf >/dev/null 2>&1
sed -i '/PostUp/d;/PostDown/d;/AllowedIPs/d;/Endpoint/d' /etc/wireguard/wgproxy.conf
sed -i "8a AllowedIPs = 0.0.0.0\/0\nAllowedIPs = ::\/0\n" /etc/wireguard/wgproxy.conf
sed -i "10a Endpoint = $endip:2408" /etc/wireguard/wgproxy.conf
green " The content of the current wireguard client configuration file wgproxy.conf is as follows, save it to /etc/wireguard/wgproxy.conf\n" && sleep 2
yellow "$(cat /etc/wireguard/wgproxy.conf)\n"
green " The current wireguard node QR code sharing link is as follows " && sleep 2
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
yellow " Wait for 3 seconds to detect the warp environment in the VPS "
docker && checkwgcf
if [[ ! $wgcfv4 =~ on|plus && ! $wgcfv6 =~ on|plus ]]; then
v4v6
if [[ -n $v4 && -n $v6 ]]; then
green " Current native v4+v6 dual-stack vps install wgcf-warp for the first time\nNow add IPV4 single-stack wgcf-warp mode " && sleep 2
ABC1=$c5 && ABC2=$c2 && ABC3=$ud4 && ABC4=$c3 && WGC Fins
the fi
if [[ -n $v6 && -z $v4 ]]; then
green " The current native v6 single-stack vps installs wgcf-warp for the first time\nNow add IPV4 single-stack wgcf-warp mode " && sleep 2
ABC1=$c5 && ABC2=$c4 && ABC3=$c2 && nat4 && WGC Fins
the fi
if [[ -z $v6 && -n $v4 ]]; then
green " The current native v4 single-stack vps installs wgcf-warp for the first time\nNow add IPV4 single-stack wgcf-warp mode " && sleep 2
STOPwgcf ; ABC1=$c5 && ABC2=$c2 && ABC3=$c3 && ABC4=$ud4 && WGC Fins
the fi
first4
else
wg-quick down wgcf >/dev/null 2>&1
sleep 1 && v4v6
if [[ -n $v4 && -n $v6 ]]; then
green " Current native v4+v6 dual-stack vps has installed wgcf-warp\nNow quickly switch to IPV4 single-stack wgcf-warp mode " && sleep 2
conf && ABC1=$c5 && ABC2=$c2 && ABC3=$ud4 && ABC4=$c3 && ABC
the fi
if [[ -n $v6 && -z $v4 ]]; then
green " Current native v6 single-stack vps has installed wgcf-warp\nNow quickly switch to IPV4 single-stack wgcf-warp mode " && sleep 2
conf && ABC1=$c5 && ABC2=$c4 && ABC3=$c2 && nat4 && ABC
the fi
if [[ -z $v6 && -n $v4 ]]; then
green " Current native v4 single-stack vps has installed wgcf-warp\nNow quickly switch to IPV4 single-stack wgcf-warp mode " && sleep 2
STOPwgcf ; conf && ABC1=$c5 && ABC2=$c2 && ABC3=$c3 && ABC4=$ud4 && ABC
the fi
CheckWARP && first4 && ShowWGCF && WGCFmenu
the fi
}

WGCFv6(){
yellow " Wait for 3 seconds to detect the warp environment in the VPS "
docker && checkwgcf
if [[ ! $wgcfv4 =~ on|plus && ! $wgcfv6 =~ on|plus ]]; then
v4v6
if [[ -n $v4 && -n $v6 ]]; then
green " Current native v4+v6 dual-stack vps install wgcf-warp for the first time\nNow add IPV6 single-stack wgcf-warp mode " && sleep 2
ABC1=$c5 && ABC2=$c1 && ABC3=$ud6 && ABC4=$c3 && WGC Fins
the fi
if [[ -n $v6 && -z $v4 ]]; then
green " Current native v6 single-stack vps install wgcf-warp for the first time\nNow add IPV6 single-stack wgcf-warp mode ( no IPV4 !!! )" && sleep 2
ABC1=$c6 && ABC2=$c1 && ABC3=$c4 && nat4 && ABC5=$ud6 && WGC Fins
the fi
if [[ -z $v6 && -n $v4 ]]; then
green " The current native v4 single-stack vps installs wgcf-warp for the first time\nNow add IPV6 single-stack wgcf-warp mode " && sleep 2
ABC1=$c5 && ABC2=$c3 && ABC3=$c1 && WGC Fins
the fi
else
wg-quick down wgcf >/dev/null 2>&1
sleep 1 && v4v6
if [[ -n $v4 && -n $v6 ]]; then
green " Current native v4+v6 dual-stack vps has installed wgcf-warp\nNow quickly switch to IPV6 single-stack wgcf-warp mode " && sleep 2
conf && ABC1=$c5 && ABC2=$c1 && ABC3=$ud6 && ABC4=$c3 && ABC
the fi
if [[ -n $v6 && -z $v4 ]]; then
green " Current native v6 single-stack vps has installed wgcf-warp\nNow quickly switch to IPV6 single-stack wgcf-warp mode ( no IPV4 !!! )" && sleep 2
conf && ABC1=$c6 && ABC2=$c1 && ABC3=$c4 && nat4 && ABC5=$ud6 && ABC
the fi
if [[ -z $v6 && -n $v4 ]]; then
green " Current native v4 single-stack vps has installed wgcf-warp\nNow quickly switch to IPV6 single-stack wgcf-warp mode " && sleep 2
conf && ABC1=$c5 && ABC2=$c3 && ABC3=$c1 && ABC
the fi
CheckWARP && ShowWGCF && WGCFmenu
the fi
}

WGCFv4v6(){
yellow " Wait for 3 seconds to detect the warp environment in the VPS "
docker && checkwgcf
if [[ ! $wgcfv4 =~ on|plus && ! $wgcfv6 =~ on|plus ]]; then
v4v6
if [[ -n $v4 && -n $v6 ]]; then
green " Current native v4+v6 dual-stack vps install wgcf-warp for the first time\nNow add IPV4+IPV6 dual-stack wgcf-warp mode " && sleep 2
STOPwgcf ; ABC1=$c5 && ABC2=$ud4ud6 && ABC3=$c3 && WGCFins
the fi
if [[ -n $v6 && -z $v4 ]]; then
green " Current native v6 single-stack vps install wgcf-warp for the first time\nNow add IPV4+IPV6 dual-stack wgcf-warp mode " && sleep 2
STOPwgcf ; ABC1=$c5 && ABC2=$c4 && ABC3=$ud6 && nat4 && WGC Fins
the fi
if [[ -z $v6 && -n $v4 ]]; then
green " The current native v4 single-stack vps installs wgcf-warp for the first time\nNow add IPV4+IPV6 dual-stack wgcf-warp mode " && sleep 2
STOPwgcf ; ABC1=$c5 && ABC2=$c3 && ABC3=$ud4 && WGCFins
the fi
else
wg-quick down wgcf >/dev/null 2>&1
sleep 1 && v4v6
if [[ -n $v4 && -n $v6 ]]; then
green " The current native v4+v6 dual-stack vps has installed wgcf-warp\nnow quickly switch to IPV4+IPV6 dual-stack wgcf-warp mode " && sleep 2
STOPwgcf ; conf && ABC1=$c5 && ABC2=$ud4ud6 && ABC3=$c3 && ABC
the fi
if [[ -n $v6 && -z $v4 ]]; then
green " Current native v6 single-stack vps has installed wgcf-warp\nNow quickly switch to IPV4+IPV6 dual-stack wgcf-warp mode " && sleep 2
STOPwgcf ; conf && ABC1=$c5 && ABC2=$c4 && ABC3=$ud6 && nat4 && ABC
the fi
if [[ -z $v6 && -n $v4 ]]; then
green " Current native v4 single-stack vps has installed wgcf-warp\nNow quickly switch to IPV4+IPV6 dual-stack wgcf-warp mode " && sleep 2
STOPwgcf ; conf && ABC1=$c5 && ABC2=$c3 && ABC3=$ud4 && ABC
the fi
CheckWARP && ShowWGCF && WGCFmenu
the fi
}

WGCFmenu(){
white "------------------------------------------------ ------------------------------------"
white " The current situation of IPV4 taking over outbound traffic is as follows "
white " ${WARPIPv4Status}"
white "------------------------------------------------ ------------------------------------"
white " The current situation of IPV6 taking over outbound traffic is as follows "
white " ${WARPIPv6Status}"
white "------------------------------------------------ ------------------------------------"
}
back(){
white "------------------------------------------------ ------------------------------------"
white " Back to the main menu , please press any key "
white " To exit the script, please press Ctrl+C"
get_char && bash CFwarp.sh
}

IP_Status_menu(){
WGCFmenu
}

CheckWARP(){
i=0
wg-quick down wgcf >/dev/null 2>&1
while [ $i -le 4 ]; do let i++
yellow " A total of 5 executions , the $i time to obtain the warp 's IP ..."
systemctl restart wg-quick@wgcf >/dev/null 2>&1
checkwgcf
[[ $wgcfv4 =~ on|plus || $wgcfv6 =~ on|plus ]] && green " Congratulations! The IP of the warp has been obtained successfully! " && break || red " Unfortunately! The IP of the warp has been obtained failed "
done
checkwgcf
if [[ ! $wgcfv4 =~ on|plus && ! $wgcfv6 =~ on|plus ]]; then
yellow " Failed to install WARP , restore the VPS , uninstall the Wgcf-WARP component ..."
cwg
green " Uninstall Wgcf-WARP component complete "
green " Failed to install WARP , suggested the following: "
[[ $release = Centos && ${vsid} -lt 7 ]] && yellow " Current system version number: Centos $vsid \nIt is recommended to use a system above Centos 7 "
[[ $release = Ubuntu && ${vsid} -lt 18 ]] && yellow " Current system version number: Ubuntu $vsid \nIt is recommended to use Ubuntu 18 or above "
[[ $release = Debian && ${vsid} -lt 10 ]] && yellow " Current system version number: Debian $vsid \nDebian 10 or above is recommended "
yellow "1. It is strongly recommended to use the official source to upgrade the system and kernel acceleration! If you have used a third-party source and kernel acceleration, please be sure to update to the latest version, or reset to the official source "
yellow "2. Some VPS systems are extremely streamlined. Relevant dependencies need to be installed before you try again "
yellow "3. Check https://www.cloudflarestatus.com/ , the area near your current VPS may be in the yellow [ Re-routed ] state "
exit
else
green "ok"
the fi
xyz(){
att
[[ -e /root/check.sh ]] && screen -S aw -X quit ; screen -UdmS aw bash -c '/bin/bash /root/check.sh'
[[ -e /root/WARP-CR.sh ]] && screen -S cr -X quit ; screen -UdmS cr bash -c '/bin/bash /root/WARP-CR.sh'
[[ -e /root/WARP-CP.sh ]] && screen -S cp -X quit ; screen -UdmS cp bash -c '/bin/bash /root/WARP-CP.sh'
if [[ -e /root/WARP-UP.sh ]]; then
screen -S up -X quit ; screen -UdmS up bash -c '/bin/bash /root/WARP-UP.sh'
else
green " Install warp online monitoring daemon "
cat>/root/WARP-UP.sh<<-\EOF
#!/bin/bash
red(){ echo -e "\033[31m\033[01m$1\033[0m";}
green(){ echo -e "\033[32m\033[01m$1\033[0m";}
checkwgcf(){
wgcfv6=$(curl -s6m6 https://www.cloudflare.com/cdn-cgi/trace -k | grep warp | cut -d= -f2)
wgcfv4=$(curl -s4m6 https://www.cloudflare.com/cdn-cgi/trace -k | grep warp | cut -d= -f2)
}
warpclose(){
wg-quick down wgcf >/dev/null 2>&1 ; systemctl stop wg-quick@wgcf >/dev/null 2>&1 ; systemctl disable wg-quick@wgcf >/dev/null 2>&1
}
warpopen(){
wg-quick down wgcf >/dev/null 2>&1 ; systemctl enable wg-quick@wgcf >/dev/null 2>&1 ; systemctl start wg-quick@wgcf >/dev/null 2>&1 ; systemctl restart wg-quick@wgcf >/dev/null 2>&1
}
warpre(){
i=0
while [ $i -le 4 ]; do let i++
warpopen
checkwgcf
[[ $wgcfv4 =~ on|plus || $wgcfv6 =~ on|plus ]] && green "The interrupted warp tried to obtain an IP successfully! " && break || red " The interrupted warp failed to obtain an IP ! "
done
checkwgcf
if [[ ! $wgcfv4 =~ on|plus && ! $wgcfv6 =~ on|plus ]]; then
warpclose
red " Due to 5 failed attempts to obtain the IP of the warp , the execution is now stopped and the warp is closed , and the VPS returns to the original IP state "
the fi
}
while true; do
green " Detecting whether the warp is starting ..."
checkwgcf
[[ $wgcfv4 =~ on|plus || $wgcfv6 =~ on|plus ]] && green " Congratulations! The warp status is running! The next round of detection will be automatically executed after 60 seconds you set " && sleep 60s || (warpre ; green " The next round of detection will be automatically executed after 50 seconds you set " ; sleep 50s)
done
EOF
When the warp state is running, re-detect the warp state interval time (enter the default 60 seconds) , please enter the interval time (for example: 50 seconds, enter 50 ) :" stop
[[ -n $stop ]] && sed -i "s/60s/${stop}s/g;s/60s / ${stop} s /g" /root/WARP-UP.sh || green " The default interval is 60 seconds "
readp "When the warp state is interrupted ( 5 consecutive failures to automatically close the warp) , continue to detect the WARP state interval time (enter the default 50 seconds) , please enter the interval time (for example: 50 seconds, enter 50 ) :" goon
[[ -n $goon ]] && sed -i "s/50s/${goon}s/g;s/50s / ${goon} s /g" /root/WARP-UP.sh || green " The default interval is 50 seconds "
[[ -e /root/WARP-UP.sh ]] && screen -S up -X quit ; screen -UdmS up bash -c '/bin/bash /root/WARP-UP.sh'
green " set screen window name 'up'" && sleep 2
grep -qE "^ *@reboot root screen -UdmS up bash -c '/bin/bash /root/WARP-UP.sh' >/dev/null 2>&1" /etc/crontab || echo "@reboot root screen -UdmS up bash -c '/bin/bash /root/WARP-UP.sh' >/dev/null 2>&1" >> /etc/crontab
green " Add warp online daemon function "
the fi
}
}

WGCFins(){
rm -rf /usr/local/bin/wgcf /etc/wireguard/wgcf.conf /etc/wireguard/wgcf-profile.conf /etc/wireguard/wgcf-account.toml /etc/wireguard/wgcf+p.log / etc/wireguard/ID /usr/bin/wireguard-go wgcf-account.toml wgcf-profile.conf
ShowWGCF
if [[ $release = Centos ]]; then
if [[ ${vsid} =~ 8 ]]; then
cd /etc/yum.repos.d/ && mkdir backup && mv *repo backup/
curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-8.repo
sed -i -e "s|mirrors.cloud.aliyuncs.com|mirrors.aliyun.com|g " /etc/yum.repos.d/CentOS-*
sed -i -e "s|releasever|releasever-stream|g" /etc/yum.repos.d/CentOS-*
yum clean all && yum makecache
fi
yum install epel-release -y;yum install iproute iptables wireguard-tools -y
elif [[ $release = Debian ]]; then
apt install lsb-release -y
echo "deb http://deb.debian.org/debian $(lsb_release -sc)-backports main" | tee /etc/apt/sources.list.d/backports.list
apt update -y;apt install iproute2 openresolv dnsutils iptables -y;apt install wireguard-tools --no-install-recommends -y      		
elif [[ $release = Ubuntu ]]; then
apt update -y;apt install iproute2 openresolve dnsutils iptables -y;apt install wireguard-tools --no-install-recommends -y			
fee
wget - N https://github.com/cfwarp/CFwarp/raw/main/wgcf_2.2.15_$cpu -O /usr/local/bin/wgcf && chmod +x /usr/local/bin/wgcf
if [[ $main -lt 5 || $minor -lt 6 ]] || [[ $vi =~lxc|openvz ]]; then
[[ -e /usr/bin/wireguard-go ]] || wget - N https://github.com/cfwarp/CFwarp/raw/main/wireguard-go -O /usr/bin/wireguard-go && chmod +x /usr/bin/wireguard-go
fee
echo | wgcf register
until [[ -e wgcf-account.toml
do
yellow " During the process of applying for a warp ordinary account, there may be multiple prompts: 429 Too Many Requests , please wait for 30 seconds " && sleep 1
echo | wgcf register --accept-tos
done
wgcf generate
yellow " Start automatically setting the warp 's MTU optimal network throughput value to optimize the WARP network ! "
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
fi
while true; do
if ${ping} -c1 -W1 -s$((${MTUy} - 28)) -Mdo ${IP1} >/dev/null 2>&1 || ${ping} -c1 -W1 -s$((${MTUy} - 28)) -Mdo ${IP2} >/dev/null 2>&1; then
MTUc=1
MTUy=$((${MTUy} + ${MTUc}))
else
MTUy=$((${MTUy} - ${MTUc}))
[[ ${MTUc} = 1 ]] && break
fi
[[ ${MTUy} -le 1360 ]] && MTUy='1360' && break
done
MTU=$((${MTUy} - 80))
green "MTU optimal network throughput value = $MTU has been set "
sed -i "s/MTU.*/MTU=$MTU/g" wgcf-profile.conf
cp -f wgcf-profile.conf /etc/wireguard/wgcf.conf >/dev/null 2>&1
cp -f wgcf-account.toml /etc/wireguard/buckup-account.toml >/dev/null 2>&1
ABC
mv -f wgcf-profile.conf /etc/wireguard >/dev/null 2>&1
mv -f wgcf-account.toml /etc/wireguard >/dev/null 2>&1
systemctl enable wg-quick@wgcf >/dev/null 2>&1
CheckWARP && ShowWGCF && WGCFmenu && lncf
}

warprefresh(){
wget -N https://github.com/cfwarp/CFwarp/raw/main/wp-plus.py
sed -i "27 s/[(][^)]*[)]//g" wp-plus.py
readp " Client configuration ID (36 characters ) : " ID
sed -i "27 s/input/'$ID'/" wp-plus.py
python3 wp-plus.py
}

WARPup(){
backconf(){
yellow " upgrade failed, automatically restore warp normal account "
sed -i "2s#.*#$(sed -ne 2p /etc/wireguard/wgcf-profile.conf)#;4s#.*#$(sed -ne 4p /etc/wireguard/wgcf-profile.conf) #" /etc/wireguard/wgcf.conf
systemctl restart wg-quick@wgcf
ShowWGCF && WGCFmenu && back
}
ab="1.Teams account \n2.warp+ account \ n3.Ordinary warp account \n0. Return to the previous level \nPlease select : "
readp "$ab" cd
case "$cd" in
1 )
[[ ! -e /etc/wireguard/wgcf.conf ]] && red " Unable to find the wgcf-warp configuration file, it is recommended to reinstall wgcf-warp" && bash CFwarp.sh
readp " Please copy privateKey (44 characters): " Key
readp " Please copy the Address for IPV6 : " Add
if [[ -n $Key && -n $Add ]]; then
sed -i "s#PrivateKey.*#PrivateKey = $Key#g;s#Address.*128#Address = $Add/128#g" /etc/wireguard/wgcf.conf
systemctl restart wg-quick@wgcf >/dev/null 2>&1
checkwgcf
if [[ $wgcfv4 = plus || $wgcfv6 = plus ]]; then
rm -rf /etc/wireguard/wgcf+p.log && green "wgcf-warp+Teams account is active " && ShowWGCF && WGCFmenu && back
else
backconf
the fi
else
backconf
fi;;
2 )
[[ ! $(type -P wg-quick) ]] && red " wgcf-warp is not installed , cannot upgrade to wgcf-warp+ account " && bash CFwarp.sh
ShowWGCF
[[ $wgcfv4 = plus || $wgcfv6 = plus ]] && red "It is already a Wgcf-WARP+ account, no need to upgrade " && bash CFwarp.sh
readp " Please ensure that the warp client on the phone is in the warp+ state , copy the key license key (26 characters ):" ID
[[ -n $ID ]] && sed -i "s/license_key.*/license_key = '$ID'/g" /etc/wireguard/wgcf-account.toml && readp "Rename the device name ( directly enter random named ) : " sbmc || (red " No key license key entered (26 characters )" && bash CFwarp.sh)
[[ -n $sbmc ]] && SBID="--name $(echo $sbmc | sed s/[[:space:]]/_/g)"
cd /etc/wireguard && wgcf update $SBID > /etc/wireguard/wgcf+p.log 2>&1
wgcf generate && cd
sed -i "2s#.*#$(sed -ne 2p /etc/wireguard/wgcf-profile.conf)#;4s#.*#$(sed -ne 4p /etc/wireguard/wgcf-profile.conf)#" /etc/wireguard/wgcf.conf
CheckWARP && checkwgcf
if [[ $wgcfv4 = plus || $wgcfv6 = plus ]]; then
warppflow=$((`grep -oP '"quota":\K\d+' <<< $(curl -s "https://api.cloudflareclient.com/v0a884/reg/$(grep 'device_id' /etc/wireguard/wgcf-account.toml 2>/dev/null | cut -d \' -f2)" -H "User-Agent: okhttp/3.12.1" -H "Authorization: Bearer $(grep 'access_token' /etc/wireguard/wgcf-account.toml 2>/dev/null | cut -d \' -f2)")`))
flow=`echo "scale=2; $warppflow/1000000000" | bc`
green " Upgraded to wgcf-warp+ account \nwgcf-warp+ account device name : $(grep -s 'Device name' /etc/wireguard/wgcf+p.log | awk '{ print $NF }')\nwgcf- warp+ account remaining traffic: $flow GB"
ShowWGCF && WGCFmenu
else
red " upgrade failed, exit script " && CFwarp.sh
fi;;
3)
[[ ! $(type -P wg-quick) ]] && red " wgcf-warp not installed " && bash CFwarp.sh
checkwgcf
if [[ $wgcfv4 = plus || $wgcfv6 = plus ]]; then
fawgcf
else
yellow " Currently it is a normal account of wgcf-warp "
ShowWGCF && WGCFmenu
fi;;
0) bash CFwarp.sh
esac
}

WARPonoff(){
ab="1. Turn on or completely close wgcf-warp\n0. Return to the previous layer \nPlease select: "
readp "$ab" cd
case "$cd" in
1 )
[[ ! $(type -P wg-quick) ]] && red "wgcf-warp is not installed, cannot be started or closed, it is recommended to reinstall wgcf-warp" && bash CFwarp.sh
checkwgcf
if [[ $wgcfv4 =~ on|plus || $wgcfv6 =~ on|plus ]]; then
yellow " Current wgcf-warp status : already running, now executing : completely closed ..."
wg-quick down wgcf >/dev/null 2>&1
systemctl stop wg-quick@wgcf >/dev/null 2>&1
systemctl disable wg-quick@wgcf >/dev/null 2>&1
checkwgcf
[[ ! $wgcfv4 =~ on|plus && ! $wgcfv6 =~ on|plus ]] && green " close wgcf-warp successfully " || red " close wgcf-warp failed "
elif [[ ! $wgcfv4 =~ on|plus && ! $wgcfv6 =~ on|plus ]]; then
yellow " Currently wgcf-warp is completely closed, now execute : resume operation ..."
wg-quick down wgcf >/dev/null 2>&1
systemctl restart wg-quick@wgcf >/dev/null 2>&1
CheckWARP
the fi
ShowWGCF && WGCFmenu && back;;
0 ) WARPOC
esac
}

cwg(){
screen -S up -X quit ; rm -rf WARP-UP.sh ; sed -i '/WARP-UP.sh/d' /etc/crontab
wg-quick down wgcf >/dev/null 2>&1
systemctl disable wg-quick@wgcf >/dev/null 2>&1
$yumapt autoremove wireguard-tools
dig9
sed -i '/^precedence ::ffff:0:0\/96  100/d;/^label 2002::\/16   2/d' /etc/gai.conf
}

WARPun(){
wj="rm -rf /usr/local/bin/wgcf /etc/wireguard/wgcf.conf /etc/wireguard/wgcf-profile.conf /etc/wireguard/wgcf-account.toml /etc/wireguard/wgcf+p.log /etc/wireguard/ID /usr/bin/wireguard-go wgcf-account.toml wgcf-profile.conf"
cron1="rm -rf CFwarp.sh screen.sh check.sh WARP-CR.sh WARP-CP.sh WARP-UP.sh /usr/bin/cf"
cron2(){
sed -i '/check.sh/d' /etc/crontab ; sed -i '/WARP-CR.sh/d' /etc/crontab ; sed -i '/WARP-CP.sh/d' /etc/ crontab ; sed -i '/WARP-UP.sh/d' /etc/crontab
}
cron3(){
screen -S up -X quit;screen -S aw -X quit;screen -S cr -X quit;screen -S cp -X quit
}
ab="1. Completely uninstall and clear the warp script and related process files \n0. Return to the previous layer \nPlease select: "
readp "$ab" cd
case "$cd" in
# 1 ) [[ $(type -P wg-quick) ]] && (cwg ; $wj ; green "Wgcf-WARP(+) uninstall complete" && ShowWGCF && WGCFmenu && back) || (yellow " not installed Wgcf-WARP(+) , cannot uninstall " && bash CFwarp.sh);;
# 2 ) [[ $(type -P warp-cli) ]] && (cso ; green "Socks5-WARP(+) uninstall complete " && ShowSOCKS5 && S5menu && back) || (yellow " Socks5-WARP is not installed (+) , cannot uninstall " && bash CFwarp.sh);;
1 ) [[ ! $(type -P wg-quick) && ! $(type -P warp-cli) ]] && (red "does not install any warp function, cannot uninstall " && CFwarp.sh) || (cron3 ; cron2 ; $cron1 ; cwg ; $wj ; green "warp has been uninstalled " && ShowWGCF && WGCFmenu && exit);;
0 ) WARPOC
esac
}

WARPOC(){
ab="1. Completely close or open the warp function \n2. Uninstall the warp function \n0. Return to the previous layer \nPlease select: "
readp "$ab" cd
case "$cd" in
1) WARPonoff;;
2) WARPun;;
0) bash CFwarp.sh
esac
}

UPwpyg(){
if [[ ! $(type -P wg-quick) && ! $(type -P warp-cli) ]] && [[ ! -f '/root/CFwarp.sh' ]]; then
red " CFwarp script not installed normally !" && exit
the fi
rm -rf /root/CFwarp.sh /usr/bin/cf
wget -N https://github.com/cfwarp/CFwarp/raw/main/CFwarp.sh
chmod +x /root/CFwarp.sh
ln -sf /root/CFwarp.sh /usr/bin/cf
green "CFwarp installation script upgraded successfully "
}

warpinscha(){
yellow " Prompt: The local outbound IP of the VPS will be taken over by the IP of the warp you selected . If the local VPS does not have the outbound IP , it will be taken over by another IP that generates the warp "
echo
yellow " If you don't understand anything, press Enter !!! "
echo
green "1. Install / switch wgcf-warp single-stack IPV4 ( Enter default) "
green "2. Install / switch wgcf-warp single stack IPV6"
green "3. Install / switch wgcf-warp dual-stack IPV4+IPV6"
readp "\nPlease select: " wgcfwarp
if [ -z "${wgcfwarp}" ] || [ $wgcfwarp == "1" ];then
WGCFv4
elif [ $wgcfwarp == "2" ];then
WGCFv6
elif [ $wgcfwarp == "3" ];then
WGCFv4v6
else
red " Input error, please choose again " && warpinscha
the fi
echo
}

start_menu(){
ShowWGCF
clear
green "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo -e "${bblue} ░██ ░██ ░██ ██ ██ ░█${plain}█ ░██ ░██ ░██ ░█${red}█ ░██${plain } "
echo -e "${bblue}  ░██   ░██      ░██    ░░██${plain}        ░██  ░██      ░██  ░██${red}      ░██  ░██${plain}   "
echo -e "${bblue}   ░██ ░██      ░██ ${plain}                ░██ ██        ░██ █${red}█        ░██ ██  ${plain}   "
echo -e "${bblue}     ░██        ░${plain}██    ░██ ██       ░██ ██        ░█${red}█ ██        ░██ ██  ${plain}  "
echo -e "${bblue}     ░██ ${plain}        ░██    ░░██        ░██ ░██       ░${red}██ ░██       ░██ ░██ ${plain}  "
echo -e "${bblue} ░█${plain}█ ░██ ██ ██ ░██ ░░${red}██ ░██ ░░██ ░██ ░░██ ${plain } "
echo
white " Yongge Gitlab project  : github.com/rwkgyg"
white " Yong Ge blogger blog : ygkkk.blogspot.com"
white " Yongge Youtube Channel : www.youtube.com/c/Yongge Kankankkkyg "
green " Translate By Javad Hassanpour"
yellow " Telegram ID : javadhpr1372"
green "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~"
yellow " After successfully installing warp , enter the script shortcut: cf"
white " =================================================== =================="
green " 1. Install / switch wgcf-warp"
green " 2. Warp closed , opened, uninstalled "
green " 3. Display the configuration file and QR code of the wgcf-warp proxy node ( WireGuard protocol) "
white " ----------------------------------------------- -----------------"
green " 4. warp brush option: warp+ flow ..."
green " 5. Warp three types of account upgrade / switch (warp/warp+/warp Teams)"
green "6. Update CFwarp script "
green "0. exit script "
white " =================================================== =================="
if [[ $(type -P wg-quick) || $(type -P warp-cli) ]] && [[ -f '/root/CFwarp.sh' ]]; then
if [ "${wpygV}" = "${remoteV}" ]; then
green " Current CFwarp script version number: ${wpygV} reset version 2 , is the latest version \n"
else
green " Current CFwarp script version number: ${wpygV}"
yellow " The latest CFwarp script version number is detected : ${remoteV} , you can choose 6 to update \n"
the fi
the fi
white " VPS system information is as follows: "
white " VPS operating system : $(blue "$op") \c" && white " Kernel version : $(blue "$version") \c" && white " CPU architecture : $(blue "$cpu") \ c" && white " Virtualization type : $(blue "$vi")"
IP_Status_menu
echo
readp " Please enter a number :" Input
case "$Input" in
1) warpinscha;;
2) WARPOC;;
3) WGproxy;;
 4 ) warprefresh;;
 5 ) WARPup;;
 6 ) UPwpyg;;
 * ) exit 
esac
}

if [ $# == 0 ]; then
start
start_menu
fi

