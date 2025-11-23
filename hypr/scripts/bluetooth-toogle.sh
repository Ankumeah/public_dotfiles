#!/bin/bash

DEVICE="BB:FD:E6:88:A7:4E"

echo "disconnect $DEVICE" | bluetoothctl
echo "connect $DEVICE" | bluetoothctl && notify-send Bluetooth "Attempting to reconnect"
