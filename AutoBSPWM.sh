sudo apt update
sudo apt -y full-upgrade -y
[ -f /var/run/reboot-required ] && sudo reboot -f
