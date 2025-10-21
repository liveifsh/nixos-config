#!/run/current-system/sw/bin/bash

pkexec ip route add 46.8.228.242 via $(ip route | awk 'NR==1{print $3}') dev wlp2s0;

systemctl restart shadowsocks-proxy.service
systemctl restart wg-quick-wg-finka.service

curl http://ipecho.net/plain; echo
