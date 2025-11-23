#!/bin/bash

iface="wlan0"

read rx1 tx1 < <(awk -v i=$iface '$1==i":"{print $2, $10}' /proc/net/dev)
sleep 1
read rx2 tx2 < <(awk -v i=$iface '$1==i":"{print $2, $10}' /proc/net/dev)

down=$(( (rx2-rx1)/1024 ))
up=$(( (tx2-tx1)/1024 ))

echo "↓ ${down} KB/s | ↑ ${up} KB/s"
