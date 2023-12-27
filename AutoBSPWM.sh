#!/bin/bash

# COMPROBACIÓN DE USUARIO
if [ "$(id -u)" != "0" ]; then
    echo "Por favor, ejecuta este script con sudo."
    exit 1
fi

# ACTUALIZAMOS Y UPGRADEAMOS EL SISTEMA
while true; do
    read -p "¿Deseas realizar un 'apt update' en el sistema? (SI/NO): " respuesta_update
    respuesta_update=$(echo "$respuesta_update" | tr '[:upper:]' '[:lower:]')

    if [ "$respuesta_update" = "si" ]; then
        sudo apt update &>/dev/null
        echo "'apt update' completado."
        break
    elif [ "$respuesta_update" = "no" ]; then
        echo "Operación 'apt update' cancelada."
        break
    else
        echo "Respuesta no válida. Por favor, responde 'SI' o 'NO'."
    fi
done

while true; do
    read -p "¿Deseas realizar un 'full-upgrade' en el sistema? (SI/NO): " respuesta_upgrade
    respuesta_upgrade=$(echo "$respuesta_upgrade" | tr '[:upper:]' '[:lower:]')

    if [ "$respuesta_upgrade" = "si" ]; then
        sudo apt full-upgrade -y &>/dev/null
        echo "Full-upgrade completado."
        break
    elif [ "$respuesta_upgrade" = "no" ]; then
        echo "Operación 'full-upgrade' cancelada."
        break
    else
        echo "Respuesta no válida. Por favor, responde 'SI' o 'NO'."
    fi
done

# INSTALAMOS LAS DEPENDENCIAS NECESARIAS
sudo apt install imagemagick brightnessctl feh xclip bspwm sxhkd wmname polybar betterlockscreen bat lsd fzf flameshot picom rofi kitty zsh -y  &>/dev/null

# OBTENEMOS EL USUARIO
echo "Este script configurará el sistema en base al usuario proporcionado y al usuario root."

while true; do
    read -p "Por favor, introduce el nombre del usuario sobre el cual se aplicarán los cambios: " input_username

    if id "$input_username" &>/dev/null; then
        echo "El usuario $input_username es válido."

        while true; do
            read -p "¿Es $input_username el nombre de usuario correcto? (SI/NO): " confirmation
            confirmation=$(echo "$confirmation" | tr '[:upper:]' '[:lower:]')

            if [ "$confirmation" = "si" ]; then
                break 2
            elif [ "$confirmation" = "no" ]; then
                break 
            else
                echo "Respuesta no válida. Por favor, responde 'SI' o 'NO'."
            fi
        done

    else
        echo "El usuario $input_username no es válido o no existe."
    fi
done

# OBTENEMOS EL DIRECTORIO ACTUAL
directorio_instalacion=$(pwd)

# SUSTITUIMOS USER_REPLACE POR NUESTRO USUARIO
sed -i "s/user_replace/$input_username/g" $directorio_instalacion/polybar/* &>/dev/null
sed -i "s/user_replace/$input_username/g" $directorio_instalacion/polybar/scripts/* &>/dev/null
sed -i "s/user_replace/$input_username/g" $directorio_instalacion/bspwm/* &>/dev/null
sed -i "s/user_replace/$input_username/g" $directorio_instalacion/bspwm/scripts* &>/dev/null
sed -i "s/user_replace/$input_username/g" $directorio_instalacion/sxhkd/* &>/dev/null
sed -i "s/user_replace/$input_username/g" $directorio_instalacion/p10k.zsh_root &>/dev/null
sed -i "s/user_replace/$input_username/g" $directorio_instalacion/p10k.zsh &>/dev/null
sed -i "s/user_replace/$input_username/g" $directorio_instalacion/zshrc &>/dev/null

# CONFIGURANDO FONTS
sudo cp -r fonts /usr/local/share 

# CONFIGURANDO WALLPAPERS
cp -r Wallpapers /home/$input_username

# CONFIGURANDO BETTERLOCKSCREEN
betterlockscreen -u /home/$input_username/Wallpapers &>/dev/null

# CONFIGURANDO SXHKD
cp -r sxhkd /home/$input_username/.config

# CONFIGURANDO KITTY
cp -r kitty /home/$input_username/.config

# CONFIGURANDO PICOM
cp -r picom /home/$input_username/.config

# CONFIGURANDO PLUGIN SUDO ZSH
sudo cp -r zsh-sudo /usr/share

# CONFIGURANDO BSPWM
cp -r bspwm /home/$input_username/.config
cd /home/$input_username/.config/bspwm 
chmod +x bspwmrc  
cd /home/$input_username/.config/bspwm/scripts 
chmod +x * 
cd "$directorio_instalacion"

# CONFIGURANDO ROFI
cp -r rofi /home/$input_username/.config 
cd /home/$input_username/.config/rofi  
cd launcher  
chmod +x launcher.sh 
cd ../powermenu 
chmod +x powermenu.sh
cd "$directorio_instalacion"

# CONFIGURANDO POLYBAR
cp -r polybar /home/$input_username/.config
cd /home/$input_username/.config/polybar/scripts 
chmod +x *
mkdir /home/$input_username/.config/bin &>/dev/null
touch /home/$input_username/.config/bin/target &>/dev/null
cd "$directorio_instalacion"

# CONFIGURANDO POWERLEVEL10K
rm -r ~/powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k &>/dev/null
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc &>/dev/null
mv zshrc .zshrc 
mv p10k.zsh .p10k.zsh   
cp .p10k.zsh /home/$input_username
cp .zshrc /home/$input_username

# CONFIGURANDO POWERLEVEL10K DE ROOT
sudo su
rm -r ~/powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k &>/dev/null
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc &>/dev/null
cp p10k.zsh_root /root
cp .zshrc /root
cd /root
mv p10k.zsh_root .p10k.zsh

# CREAMOS UN LINK SIMBÓLICO ENTRE LA ZSHRC DE NUESTRO USUARIO Y LA ZSHRC DE ROOT
sudo ln -s -f /home/$input_username/.zshrc /root/.zshrc

# ELIMINAMOS LOS PAQUETES QUE NO SON NECESARIOS
sudo apt autoremove

# ELIMINAMOS LOS ARCHIVOS DE CACHÉ
sudo apt clean

# ELIMINAMOS EL DIRECTORIO DE INSTALACIÓN
sudo rm -rf "$directorio_instalacion"
