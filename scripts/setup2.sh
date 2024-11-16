curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

nvm install 11
sudo setcap cap_net_bind_service=+ep `readlink -f \`which node\``
npm install --global node-gyp@8.4.1
npm config set node_gyp $(npm prefix -g)/lib/node_modules/node-gyp/bin/node-gyp.js

cd ~/LD-ToyPad-Emulator
npm install
