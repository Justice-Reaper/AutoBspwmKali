sudo apt update
sudo apt -y full-upgrade -y
[ -f /var/run/reboot-required ] && sudo reboot -f
sudo apt install -y nvidia-detect
sudo apt install -y nvidia-driver nvidia-cuda-toolkit
sudo reboot -f
