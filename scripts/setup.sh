# Dependencies 
sudo apt update
sudo apt install -y git usbip hwdata curl python build-essential libusb-1.0-0-dev libudev-dev
echo "usbip-core" | sudo tee -a /etc/modules
echo "usbip-vudc" | sudo tee -a /etc/modules
echo "vhci-hcd" | sudo tee -a /etc/modules
echo "dtoverlay=dwc2" | sudo tee -a /boot/config.txt
echo "dwc2" | sudo tee -a /etc/modules
echo "libcomposite" | sudo tee -a /etc/modules
echo "usb_f_rndis" | sudo tee -a /etc/modules
# Git Pull
git config pull.rebase false
git clone https://github.com/SupernovaXTS/LD-ToyPad-Emulator.git
cd LD-ToyPad-Emulator
# USB Setup
printf '\necho "usbip-vudc.0" > UDC\nusbipd -D --device\nsleep 2;\nusbip attach -r debian -b usbip-vudc.0\nchmod a+rw /dev/hidg0' >> usb_setup_script.sh
sudo curl https://raw.githubusercontent.com/virtualhere/script/main/install_server | sudo sh
sudo cp usb_setup_script.sh /usr/local/bin/toypad_usb_setup.sh
sudo chmod +x /usr/local/bin/toypad_usb_setup.sh
(sudo crontab -l 2>/dev/null; echo "@reboot sudo /usr/local/bin/toypad_usb_setup.sh") | sudo crontab -

#Node install
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

nvm install 11
sudo setcap cap_net_bind_service=+ep `readlink -f \`which node\``
npm install --global node-gyp@8.4.1
npm config set node_gyp $(npm prefix -g)/lib/node_modules/node-gyp/bin/node-gyp.js
npm install
# Tailscale Install
curl -fsSL https://tailscale.com/install.sh | sh