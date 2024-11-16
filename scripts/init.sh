Repo_Author=SupernovaXTS
Repo_Name=LD-Toypad-Emulator
GIT_URL=https://github.com/$Repo_Author/$Repo_Name.git
sudo apt update
sudo apt install -y git # git
git config pull.rebase false
git clone $GIT_URL
cd LD-ToyPad-Emulator
bash setup1.sh
