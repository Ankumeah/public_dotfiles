#!/bin/bash

DEVICE="BB:FD:E6:88:A7:4E"

if bluetoothctl info "$DEVICE" | grep -q "Connected: yes"; then
    echo "disconnect $DEVICE" | bluetoothctl && notify-send Bluetooth "Disconnected"
else
    echo "connect $DEVICE" | bluetoothctl && notify-send Bluetooth "Attempting to connect"
fi
