
#The max # of GPIOs this release of Linux is configured to support is 1024.  The ZYNQ PS GPIO block has 118 IOs (54 on MIO, 64 on EMIO).
#1024-118 = 906, hence gpiochip906.  In our design, we have BT_REG_ON tied to EMIO[0], which is the first GPIO after all of the MIO, or 906 + 54 = 960.

#Turn echo of commands on:
set -v
#To turn on BT_REG_ON, which is on EMIO GPIO #0
echo 960 > /sys/class/gpio/export
echo out > /sys/class/gpio/gpio960/direction
echo 1 > /sys/class/gpio/gpio960/value
#Set uart0 = serial1 = ttyPS1 baudrate:
#(this was for UART0 from PS) stty -F /dev/ttyPS1 115200
stty -F /dev/ttyS0 115200
sleep 1s
#For the flow control.
#It seems you have to send a character before RTS from the 1DX modulke will be set in the correct state.
#(this was for UART0 from PS) echo "W" > /dev/ttyPS1
echo "W" > /dev/ttyS0
sleep 1s
#Initialize the device:
#(this was for UART0 from PS) hciattach /dev/ttyPS1 bcm43xx 921600 flow -t 10
hciattach /dev/ttyS0 bcm43xx 3000000 flow -t 10
sleep 2s

#Configure the right BT device:
hciconfig hci0 up

#begin new
sleep 1s
hciconfig hci0 reset
hciconfig hci0 class 0x200404
#for no password:
hciconfig hci0 sspmode 1
hciconfig hci0 piscan
hciconfig hci0 leadv
hciconfig -a
#end new

sleep 1s
#Scan for BT devices:
hcitool scan
set +v
#Above turns echo off

#Scan for BLE devices:
#hcitool lescan

#hciconfig -a
#hcitool dev

