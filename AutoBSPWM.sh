#!/bin/bash

# COMPROBACIÓN DE USUARIO
if [ "$(id -u)" != "0" ]; then
    echo -e "\e[31m[*]\e[0m Por favor, ejecuta este script con sudo."
    exit 1
fi

# ACTUALIZAMOS Y UPGRADEAMOS EL SISTEMA
while true; do
    read -p "¿Deseas realizar un 'apt update' en el sistema? (SI/NO): " respuesta_update
    respuesta_update=$(echo "$respuesta_update" | tr '[:upper:]' '[:lower:]')

    if [ "$respuesta_update" = "si" ] || [ "$respuesta_update" = "s" ]; then
        sudo apt update &>/dev/null
        echo -e "\e[32m[*]\e[0m Operación 'apt update' completada con éxito.\n"
        break
    elif [ "$respuesta_update" = "no" ] || [ "$respuesta_update" = "n" ]; then
        echo -e "\e[31m[*]\e[0m Operación 'apt update' cancelada.\n"
        break
    else
        echo -e "\e[31m[*]\e[0m Respuesta no válida. Por favor, responde 'SI' o 'NO'.\n"
    fi
done

while true; do
    echo -e "\e[33m[*]\e[0m ¿Deseas realizar un 'full-upgrade' en el sistema? (SI/NO):"
    read -p respuesta_upgrade
    respuesta_upgrade=$(echo "$respuesta_upgrade" | tr '[:upper:]' '[:lower:]')

    if [ "$respuesta_upgrade" = "si" ]; then
        sudo apt full-upgrade -y &>/dev/null
        echo -e "\e[32m[*]\e[0m Operación 'full-upgrade' completada con éxito.\n"
        break
    elif [ "$respuesta_upgrade" = "no" ]; then
        echo -e "\e[31m[*]\e[0m Operación 'full-upgrade' cancelada.\n"
        break
    else
        echo -e "\e[31m[*]\e[0m Respuesta no válida. Por favor, responde 'SI' o 'NO'.\n"
    fi
done

# INSTALAMOS LAS DEPENDENCIAS NECESARIAS
echo -e "\e[32m[*]\e[0m Instalando las dependencias necesarias ...\n"
sudo apt install imagemagick brightnessctl feh xclip bspwm sxhkd wmname polybar betterlockscreen bat lsd fzf flameshot picom rofi kitty zsh -y  &>/dev/null

# OBTENEMOS EL USUARIO
echo -e "\e[33m[*]\e[0m Este script configurará el sistema en base al usuario proporcionado y al usuario root."

while true; do
    echo -e "\e[33m[*]\e[0m Por favor, introduce el nombre del usuario sobre el cual se aplicarán los cambios:"
    read -p input_username

    if id "$input_username" &>/dev/null; then
        echo -e "\e[32m[*]\e[0m El usuario $input_username es válido."
        
        while true; do
            echo -e "\e[33m[*]\e[0m ¿Es $input_username el nombre de usuario correcto? (SI/NO):"
            read -p confirmation
            confirmation=$(echo "$confirmation" | tr '[:upper:]' '[:lower:]')

            if [ "$confirmation" = "si" ] || [ "$confirmation" = "s" ]; then
                break 2
            elif [ "$confirmation" = "no" ] || [ "$confirmation" = "n" ]; then
                break 
            else
                echo -e "\e[31m[*]\e[0m Respuesta no válida. Por favor, responde 'SI' o 'NO'.\n"
            fi
        done
    else
        echo -e "\e[31m[*]\e[0m El usuario $input_username no es válido o no existe.\n"

    fi
done

# OBTENEMOS EL DIRECTORIO ACTUAL
directorio_instalacion=$(pwd)

# SUSTITUIMOS USER_REPLACE POR NUESTRO USUARIO
echo -e "\e[32m[*]\e[0m Configurando ficheros ...\n"
sed -i "s/user_replace/$input_username/g" $directorio_instalacion/polybar/* &>/dev/null
sed -i "s/user_replace/$input_username/g" $directorio_instalacion/polybar/scripts/* &>/dev/null
sed -i "s/user_replace/$input_username/g" $directorio_instalacion/bspwm/* &>/dev/null
sed -i "s/user_replace/$input_username/g" $directorio_instalacion/bspwm/scripts* &>/dev/null
sed -i "s/user_replace/$input_username/g" $directorio_instalacion/sxhkd/* &>/dev/null
sed -i "s/user_replace/$input_username/g" $directorio_instalacion/p10k.zsh_root &>/dev/null
sed -i "s/user_replace/$input_username/g" $directorio_instalacion/p10k.zsh &>/dev/null
sed -i "s/user_replace/$input_username/g" $directorio_instalacion/zshrc &>/dev/null

# CONFIGURANDO FONTS
echo -e "\e[32m[*]\e[0m Configurando fonts ...\n"
sudo cp -r fonts /usr/local/share 

# CONFIGURANDO WALLPAPERS
echo -e "\e[32m[*]\e[0m Configurando wallpapers ...\n"
cp -r Wallpapers /home/$input_username

# CONFIGURANDO BETTERLOCKSCREEN
echo -e "\e[32m[*]\e[0m Configurando betterlockscreen ...\n"
betterlockscreen -u /home/$input_username/Wallpapers &>/dev/null

# CONFIGURANDO SXHKD
echo -e "\e[32m[*]\e[0m Configurando sxhkd ...\n"
cp -r sxhkd /home/$input_username/.config

# CONFIGURANDO KITTY
echo -e "\e[32m[*]\e[0m Configurando kitty ...\n"
cp -r kitty /home/$input_username/.config

# CONFIGURANDO PICOM
echo -e "\e[32m[*]\e[0m Configurando picom ...\n"
cp -r picom /home/$input_username/.config

# CONFIGURANDO PLUGIN SUDO ZSH
echo -e "\e[32m[*]\e[0m Configurando plugin zsh-sudo ...\n"
sudo cp -r zsh-sudo /usr/share

# CONFIGURANDO BSPWM
echo -e "\e[32m[*]\e[0m Configurando bspwm ...\n"
cp -r bspwm /home/$input_username/.config
cd /home/$input_username/.config/bspwm 
chmod +x bspwmrc  
cd /home/$input_username/.config/bspwm/scripts 
chmod +x * 
cd "$directorio_instalacion"

# CONFIGURANDO ROFI
echo -e "\e[32m[*]\e[0m Configurando rofi ...\n"
cp -r rofi /home/$input_username/.config 
cd /home/$input_username/.config/rofi  
cd launcher  
chmod +x launcher.sh 
cd ../powermenu 
chmod +x powermenu.sh
cd "$directorio_instalacion"

# CONFIGURANDO POLYBAR
echo -e "\e[32m[*]\e[0m Configurando polybar ...\n"
cp -r polybar /home/$input_username/.config
cd /home/$input_username/.config/polybar/scripts 
chmod +x *
mkdir /home/$input_username/.config/bin &>/dev/null
touch /home/$input_username/.config/bin/target &>/dev/null
cd "$directorio_instalacion"

# CONFIGURANDO POWERLEVEL10K
echo -e "\e[32m[*]\e[0m Configurando powerlevel10k del usuario $input_username ...\n"
rm -r ~/powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k &>/dev/null
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc &>/dev/null
mv zshrc .zshrc 
mv p10k.zsh .p10k.zsh   
cp .p10k.zsh /home/$input_username
cp .zshrc /home/$input_username

# CONFIGURANDO POWERLEVEL10K DE ROOT
echo -e "\e[32m[*]\e[0m Configurando powerlevel10k del usuario root ...\n"
sudo su
rm -r ~/powerlevel10k &>/dev/null
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k &>/dev/null
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc &>/dev/null
cp p10k.zsh_root /root 
cp .zshrc /root
cd /root
mv p10k.zsh_root .p10k.zsh

# CREAMOS UN LINK SIMBÓLICO ENTRE LA ZSHRC DE NUESTRO USUARIO Y LA ZSHRC DE ROOT
echo -e "\e[32m[*]\e[0m Creando link simbólico en la zshrc ...\n"
sudo ln -s -f /home/$input_username/.zshrc /root/.zshrc

# ELIMINAMOS LOS PAQUETES QUE NO SON NECESARIOS
echo -e "\e[32m[*]\e[0m Eliminando paquetes apt innecesarios ...\n"
sudo apt autoremove

# ELIMINAMOS LOS ARCHIVOS DE CACHÉ
echo -e "\e[32m[*]\e[0m Limpiando caché de paquetes apt ...\n"
sudo apt clean
