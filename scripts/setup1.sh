sudo apt update
sudo apt install -y git usbip hwdata curl python build-essential libusb-1.0-0-dev libudev-dev
echo "usbip-core" | sudo tee -a /etc/modules
echo "usbip-vudc" | sudo tee -a /etc/modules
echo "vhci-hcd" | sudo tee -a /etc/modules

echo "dtoverlay=dwc2" | sudo tee -a /boot/config.txt
echo "dwc2" | sudo tee -a /etc/modules
echo "libcomposite" | sudo tee -a /etc/modules
echo "usb_f_rndis" | sudo tee -a /etc/modules

curl -fsSL https://tailscale.com/install.sh | sh
curl https://raw.githubusercontent.com/virtualhere/script/main/install_server | sh
printf '\necho "usbip-vudc.0" > UDC\nusbipd -D --device\nsleep 2;\nusbip attach -r $HOSTNAME -b usbip-vudc.0\nchmod a+rw /dev/hidg0' >> usb_setup_script.sh
cp usb_setup_script.sh /usr/local/bin/toypad_usb_setup.sh
chmod +x /usr/local/bin/toypad_usb_setup.sh
(crontab -l 2>/dev/null; echo "@reboot sudo /usr/local/bin/toypad_usb_setup.sh") | crontab -
shutdown -r now