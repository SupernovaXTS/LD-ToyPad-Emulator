sleep 3;
echo "usbip-vudc.0" > UDC
usbipd -D --device
sleep 2
usbip attach -r $HOSTNAME -b usbip-vudc.0
chmod a+rw /dev/hidg0'
