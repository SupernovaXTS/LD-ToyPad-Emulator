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
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

nvm install 11
sudo setcap cap_net_bind_service=+ep `readlink -f \`which node\``
npm install --global node-gyp@8.4.1
npm config set node_gyp $(npm prefix -g)/lib/node_modules/node-gyp/bin/node-gyp.js
npm install

cp usb_setup_script.sh /usr/local/bin/toypad_usb_setup.sh
chmod +x /usr/local/bin/toypad_usb_setup.sh
(crontab -l 2>/dev/null; echo "@reboot sudo /usr/local/bin/toypad_usb_setup.sh") | crontab -
shutdown -r now