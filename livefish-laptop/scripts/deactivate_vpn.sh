#!/run/current-system/sw/bin/bash

ip route del 46.8.228.242;

systemctl stop wg-quick-wg-finka.service
systemctl stop shadowsocks-proxy.service

curl http://ipecho.net/plain; echo
