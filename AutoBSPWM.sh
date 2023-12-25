cd ..
mv AutoBSPWM ~/Downloads 
cd ~/Downloads/AutoBSPWM
sudo apt update
sudo apt -y full-upgrade -y
mkdir ~/.config/bin     
touch ~/.config/bin/target
sudo apt install brightnessctl -y   
sudo apt install feh -y
sudo apt install wmname -y
sudo apt install xclip -y
sudo apt install bspwm -y
sudo apt install sxhkd -y
cp -r sxhkd ~/.config
cp -r bspwm ~/.config 
cd ~/.config/bspwm 
chmod +x bspwmrc  
cd ~/.config/bspwm/scripts 
chmod +x * 
sudo apt install polybar -y
cd ~/Downloads/AutoBSPWM
cp -r polybar ~/.config
cd ~/.config/polybar/scripts 
chmod +x *
sudo apt install kitty  -y 
cd ~/Downloads/AutoBSPWM
cp -r kitty ~/.config  
sudo apt install rofi -y  
cp -r rofi ~/.config  
cd ~/.config/rofi  
cd launcher  
chmod +x launcher.sh 
cd ../powermenu 
chmod +x powermenu.sh 
sudo apt install betterlockscreen -y  
sudo apt install bat lsd fzf -y
sudo apt install flameshot -y
sudo apt install picom -y  
cd ~/Downloads/AutoBSPWM
sudo cp -r zsh-sudo /usr/share
cp -r picom ~/.config
cp -r Wallpapers ~/
sudo cp -r fonts /usr/local/share/
sudo apt install zsh -y
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
sudo su
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
exit
mv p10k.zsh .p10k.zsh   
mv zshrc .zshrc 
cp .p10k.zsh ~/
cp .zshrc ~/ 
sudo su 
cp p10k.zsh_root /root
cp .zshrc /root
cd /root
mv p10k.zsh_root .p10k.zsh
exit
sudo ln -s -f ~/.zshrc /root/.zshrc   
