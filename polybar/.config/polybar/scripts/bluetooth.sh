#!/bin/bash

# Check if Bluetooth is powered on
bluetooth_status=$(bluetoothctl show | grep "Powered" | awk '{print $2}')

if [ "$bluetooth_status" == "yes" ]; then
  # Check if any devices are connected
  connected_devices=$(bluetoothctl devices Connected | grep "Device" | wc -l)
  if [ "$connected_devices" -gt 0 ]; then
    # List connected devices
    device_list=$(bluetoothctl devices Connected | grep "Device" | awk '{print $3, $4}')
    echo "Bt $device_list"
  else
    echo "Bt On"
  fi
else
  echo "Bt Off"
fi

