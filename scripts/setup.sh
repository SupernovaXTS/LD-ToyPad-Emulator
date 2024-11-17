sudo apt update
sudo apt install -y git usbip hwdata curl python build-essential libusb-1.0-0-dev libudev-dev
modules=("usbip-core" "usbip-vudc" "vhci-hcd" "dwc2" "libcomposite" "usb_f_rndis")
for module in "${modules[@]}"; do
    echo "$module" | sudo tee -a /etc/modules
    sudo modprobe "$module"
done
echo "dtoverlay=dwc2" | sudo tee -a /boot/config.txt
curl -fsSL https://tailscale.com/install.sh | sh
curl https://raw.githubusercontent.com/virtualhere/script/main/install_server | sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
# Node install
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

nvm install 11
sudo setcap cap_net_bind_service=+ep `readlink -f \`which node\``
npm install --global node-gyp@8.4.1
npm config set node_gyp $(npm prefix -g)/lib/node_modules/node-gyp/bin/node-gyp.js
# Grab depends for program
npm install
mode="usbip"          # Set mode to usbip
s1="scripts/toypad_init1.sh"
s2="scripts/toypad_init2.sh"
# Combine scripts and insert mode declaration in the middle
{
    cat "$s1"
    echo "mode=\"$mode\""
    cat "$s2"
} > toypad_init.sh
cp toypad_init.sh /usr/local/bin/toypad_usb_setup.sh
chmod +x /usr/local/bin/toypad_usb_setup.sh
(crontab -l 2>/dev/null; echo "@reboot sudo /usr/local/bin/toypad_usb_setup.sh") | crontab -
shutdown -r now