sudo apt update
sudo apt -y full-upgrade -y
[ -f /var/run/reboot-required ] && sudo reboot -f
sudo apt install -y nvidia-detect
sudo apt install -y nvidia-driver nvidia-cuda-toolkit
sudo reboot -f
nvidia-detect
sudo apt install neofetch -y
echo "root:root" | sudo chpasswd
sudo apt update && sudo apt install btrfs-progs snapper snapper-gui grub-btrfs -y
sudo cp /usr/share/snapper/config-templates/default /etc/snapper/configs/home
sudo sed -i 's/^SNAPPER_CONFIGS=\"\"/SNAPPER_CONFIGS=\"home\"/' /etc/default/snapper
sudo cp /usr/share/snapper/config-templates/default /etc/snapper/configs/varlog
sudo sed -i 's/^SNAPPER_CONFIGS=\"\"/SNAPPER_CONFIGS=\"varlog\"/' /etc/default/snapper
sudo cp /usr/share/snapper/config-templates/default /etc/snapper/configs/srv
sudo sed -i 's/^SNAPPER_CONFIGS=\"\"/SNAPPER_CONFIGS=\"srv\"/' /etc/default/snapper
sudo cp /usr/share/snapper/config-templates/default /etc/snapper/configs/tmp
sudo sed -i 's/^SNAPPER_CONFIGS=\"\"/SNAPPER_CONFIGS=\"tmp\"/' /etc/default/snapper
sudo cp /usr/share/snapper/config-templates/default /etc/snapper/configs/usrlocal
sudo sed -i 's/^SNAPPER_CONFIGS=\"\"/SNAPPER_CONFIGS=\"usrlocal\"/' /etc/default/snapper
sudo cp /usr/share/snapper/config-templates/default /etc/snapper/configs/root
sudo sed -i 's/^SNAPPER_CONFIGS=\"\"/SNAPPER_CONFIGS=\"root\"/' /etc/default/snapper
sudo sed -i '/# PRUNENAMES=/ a PRUNENAMES = ".snapshots"' /etc/updatedb.conf
sudo sed -i 's/^#user-authority-in-system-dir=false/user-authority-in-system-dir=true/' /etc/lightdm/lightdm.conf
sudo reboot
