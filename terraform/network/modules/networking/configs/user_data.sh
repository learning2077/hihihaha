#!/bin/bash

sysctl -w net.ipv4.ip_forward=1
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf

DEFAULT_IF=$(ip -4 route show default | awk '/default/ {print $5}')

dnf install -y iptables-services

iptables -t nat -A POSTROUTING -o '$DEFAULT_IF' -j MASQUERADE
iptables -A FORWARD -i $DEFAULT_IF -j ACCEPT
iptables -A FORWARD -o $DEFAULT_IF -j ACCEPT

systemctl enable iptables
systemctl start iptables
service iptables save