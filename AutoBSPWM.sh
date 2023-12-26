#!/bin/bash

# MOVEMOS EL AUTOBSPWM A DOWLOADS

cd ..
mv AutoBSPWM ~/Downloads 
cd ~/Downloads/AutoBSPWM

# ACTUALIZAMOS Y UPGRADEAMOS EL SISTEMA

# Función para realizar el full-upgrade
realizar_full_upgrade() {
    sudo apt update && sudo apt full-upgrade -y
    echo "Full-upgrade completado."
}

# Función para realizar solo la actualización
realizar_actualizacion() {
    sudo apt update
    echo "Actualización completada."
}

# Bucle para pedir la entrada del usuario
while true; do
    # Solicitar confirmación al usuario
    read -p "¿Deseas realizar un full-upgrade en el sistema? (Sí/no): " respuesta

    # Convertir la respuesta a minúsculas para facilitar la comparación
    respuesta=$(echo "$respuesta" | tr '[:upper:]' '[:lower:]')

    # Verificar la respuesta
    if [ "$respuesta" = "sí" ] || [ "$respuesta" = "yes" ]; then
        realizar_full_upgrade
        break
    elif [ "$respuesta" = "no" ]; then
        realizar_actualizacion
        break
    else
        echo "Respuesta no válida. Por favor, responde 'Sí' o 'No'."
    fi
done

# INSTALAMOS LAS DEPENDENCIAS NECESARIAS

sudo apt install imagemagick brightnessctl feh xclip bspwm sxhkd wmname polybar betterlockscreen bat lsd fzf flameshot picom rofi kitty zsh -y

mkdir ~/.config/bin     
touch ~/.config/bin/target

cp -r sxhkd ~/.config
cp -r bspwm ~/.config 
cd ~/.config/bspwm 
chmod +x bspwmrc  
cd ~/.config/bspwm/scripts 
chmod +x * 
cd ~/Downloads/AutoBSPWM
cp -r polybar ~/.config
cd ~/.config/polybar/scripts 
chmod +x *

cd ~/Downloads/AutoBSPWM
cp -r kitty ~/.config  
cp -r rofi ~/.config  
cd ~/.config/rofi  
cd launcher  
chmod +x launcher.sh 
cd ../powermenu 
chmod +x powermenu.sh 

cd ~/Downloads/AutoBSPWM
sudo cp -r zsh-sudo /usr/share
cp -r picom ~/.config
cp -r Wallpapers ~/
betterlockscreen -u ~/Wallpapers
sudo cp -r fonts /usr/local/share/

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
