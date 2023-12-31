#!/bin/bash

# AUTOR
echo '
====================================================================================================================


      ██╗██╗   ██╗███████╗████████╗██╗ ██████╗███████╗              ██████╗ ███████╗ █████╗ ██████╗ ███████╗██████╗ 
      ██║██║   ██║██╔════╝╚══██╔══╝██║██╔════╝██╔════╝              ██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔════╝██╔══██╗
      ██║██║   ██║███████╗   ██║   ██║██║     █████╗      █████╗    ██████╔╝█████╗  ███████║██████╔╝█████╗  ██████╔╝
 ██   ██║██║   ██║╚════██║   ██║   ██║██║     ██╔══╝      ╚════╝    ██╔══██╗██╔══╝  ██╔══██║██╔═══╝ ██╔══╝  ██╔══██╗
 ╚█████╔╝╚██████╔╝███████║   ██║   ██║╚██████╗███████╗              ██║  ██║███████╗██║  ██║██║     ███████╗██║  ██║
  ╚════╝  ╚═════╝ ╚══════╝   ╚═╝   ╚═╝ ╚═════╝╚══════╝              ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝
                                                                                                            
                                                                                                            
====================================================================================================================
'

# COMPROBACIÓN DE USUARIO
if [ "$(id -u)" != "0" ]; then
    echo -e "\e[31m[*]\e[0m Por favor, ejecuta este script con sudo."
    exit 1
fi

# MODO DEVELOPER
while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m ¿Quieres ver el output de los comandos (dev mode)? (SI/NO): ")" dev_mode
    dev_mode=$(echo "$dev_mode" | tr '[:upper:]' '[:lower:]')

    if [ "$dev_mode" = "si" ] || [ "$dev_mode" = "s" ]; then
        echo -e "\e[32m[*]\e[0m El modo developer ha sido activado, se verá el output de los comandos ejecutados.\n"
        break
    elif [ "$dev_mode" = "no" ] || [ "$dev_mode" = "n" ]; then
        echo -e "\e[31m[*]\e[0m El modo developer no ha sido activado, no se verá el output de los comandos ejecutados.\n"
        break
    else
        echo -e "\e[31m[*]\e[0m Respuesta no válida. Por favor, responde 'SI' o 'NO'.\n"
    fi
done

# CONTROLAMOS EL OUTPUT DE LOS COMANDOS
execute_command() {
    comando="$1"
    output=$(eval "$comando")

     if [ "$dev_mode" = "si" ] || [ "$dev_mode" = "s" ]; then
        echo "$output" 
    fi
}

# OBTENEMOS EL DIRECTORIO ACTUAL
directorio_instalacion=$(pwd)

# OBTENEMOS EL USUARIO
echo -e "\e[33m[*]\e[0m Este script configurará el sistema en base al usuario proporcionado y al usuario root.\n"

while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m Por favor, introduce el nombre del usuario sobre el cual se aplicarán los cambios: ")" input_username
    if id "$input_username" &>/dev/null; then
        execute_command id "$input_username"
        echo -e "\e[32m[*]\e[0m El usuario $input_username es válido.\n"
        
        while true; do
            read -p "$(echo -e "\e[33m[*]\e[0m ¿Es $input_username el nombre de usuario correcto? (SI/NO): ")" confirmation
            confirmation=$(echo "$confirmation" | tr '[:upper:]' '[:lower:]')
            
            if [ "$confirmation" = "si" ] || [ "$confirmation" = "s" ]; then
                echo ""
                break 2
            elif [ "$confirmation" = "no" ] || [ "$confirmation" = "n" ]; then
                echo ""
                break 
            else
                echo -e "\e[31m[*]\e[0m Respuesta no válida. Por favor, responde 'SI' o 'NO'.\n"
            fi
        done
    else
        echo -e "\e[31m[*]\e[0m El usuario $input_username no es válido o no existe.\n"
    fi
done

# ACTUALIZAMOS EL SISTEMA
while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m ¿Deseas realizar un 'apt update' en el sistema? (SI/NO): ")" respuesta_update
    respuesta_update=$(echo "$respuesta_update" | tr '[:upper:]' '[:lower:]')

    if [ "$respuesta_update" = "si" ] || [ "$respuesta_update" = "s" ]; then
        echo -e "\e[32m[*]\e[0m Ejecutando 'apt update' ...\n"
        execute_command apt update
        break
    elif [ "$respuesta_update" = "no" ] || [ "$respuesta_update" = "n" ]; then
        echo -e "\e[31m[*]\e[0m Operación 'apt update' cancelada.\n"
        break
    else
        echo -e "\e[31m[*]\e[0m Respuesta no válida. Por favor, responde 'SI' o 'NO'.\n"
    fi
done

# UPGRADEAMOS EL SISTEMA
while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m ¿Deseas realizar un 'full-upgrade' en el sistema? (SI/NO): ")" respuesta_upgrade
    respuesta_upgrade=$(echo "$respuesta_upgrade" | tr '[:upper:]' '[:lower:]')

    if [ "$respuesta_upgrade" = "si" ] || [ "$respuesta_upgrade" = "s" ]; then
        echo -e "\e[32m[*]\e[0m Ejecutando 'apt full-upgrade' ...\n"
        execute_command apt full-upgrade -y
        break
    elif [ "$respuesta_upgrade" = "no" ] || [ "$respuesta_upgrade" = "n" ]; then
        echo -e "\e[31m[*]\e[0m Operación 'apt full-upgrade' cancelada.\n"
        break
    else
        echo -e "\e[31m[*]\e[0m Respuesta no válida. Por favor, responde 'SI' o 'NO'.\n"
    fi
done

# INSTALAMOS LAS DEPENDENCIAS NECESARIAS
echo -e "\e[32m[*]\e[0m Instalando las dependencias necesarias ...\n"
execute_command apt install imagemagick brightnessctl feh xclip bspwm sxhkd wmname polybar betterlockscreen bat lsd fzf flameshot picom rofi kitty zsh -y

# DRIVERS PROPIETARIOS NVIDIA
install_nvidia_drivers(){
    while true; do
          read -p "$(echo -e "\e[33m[*]\e[0m ¿Deseas instalar los drivers propietarios de nvidia? (SI/NO): ")" drivers_nvidia
          drivers_nvidia=$(echo "$drivers_nvidia" | tr '[:upper:]' '[:lower:]')
      
          if [ "$drivers_nvidia" = "si" ] || [ "$drivers_nvidia" = "s" ]; then
              echo -e "\e[32m[*]\e[0m Instalando los drivers propietarios de nvidia ...\n"
              execute_command apt install nvidia-detect nvidia-smi nvidia-driver nvidia-cuda-toolkit -y
              break
          elif [ "$drivers_nvidia" = "no" ] || [ "$drivers_nvidia" = "n" ]; then
              echo -e "\e[31m[*]\e[0m Los drivers propietarios de nvidia no han sido instalados.\n"
              break
          else
              echo -e "\e[31m[*]\e[0m Respuesta no válida. Por favor, responde 'SI' o 'NO'.\n"
          fi
      done
}

# ACTIVACIÓN CLIPBOARD BIDIRECCIONL
activar_clipboard_bidireccional(){
      while true; do
          read -p "$(echo -e "\e[33m[*]\e[0m ¿Estas usando VmWare y deseas activar la clipboard bidireccional? (SI/NO): ")" respuesta_clipboard
          respuesta_clipboard=$(echo "$respuesta_clipboard" | tr '[:upper:]' '[:lower:]')
      
          if [ "$respuesta_clipboard" = "si" ] || [ "$respuesta_clipboard" = "s" ]; then
              echo -e "\e[32m[*]\e[0m La clipboard bidireccional ha sido configurada con éxito.\n"
              execute_command echo -e '\n# clipboard bidireccional\nvmware-user-suid-wrapper &' >> $directorio_instalacion/bspwm/bspwmrc
              break
          elif [ "$respuesta_clipboard" = "no" ] || [ "$respuesta_clipboard" = "n" ]; then
              echo -e "\e[31m[*]\e[0m La clipboard bidireccional no ha sido activada.\n"
              break
          else
              echo -e "\e[31m[*]\e[0m Respuesta no válida. Por favor, responde 'SI' o 'NO'.\n"
          fi
      done
}

# ELECCIÓN MÁQUINA VIRTUAL O SISTEMA NATIVO
while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m ¿Estás usando una máquina virtual? (SI/NO): ")" respuesta_virtual_machine
    respuesta_virtual_machine=$(echo "$respuesta_virtual_machine" | tr '[:upper:]' '[:lower:]')

    if [ "$respuesta_virtual_machine" = "si" ] || [ "$respuesta_virtual_machine" = "s" ]; then
        echo -e "\e[32m[*]\e[0m El sistema será configurado para una máquina virtual.\n"
        execute_command sed -i '/backend = "glx";/d' $directorio_instalacion/picom/picom.conf
        activar_clipboard_bidireccional
        break
    elif [ "$respuesta_virtual_machine" = "no" ] || [ "$respuesta_virtual_machine" = "n" ]; then
        echo -e "\e[32m[*]\e[0m El sistema será configurado para uso nativo.\n"
        install_nvidia_drivers
        break
    else
        echo -e "\e[31m[*]\e[0m Respuesta no válida. Por favor, responde 'SI' o 'NO'.\n"
    fi
done

# ELIMINAMOS LAS ANTIGUAS CONFIGURACIONES
execute_command rm -rf /home/$input_username/.zshrc
execute_command rm -rf /home/$input_username/.p10k.zsh
execute_command rm -rf /root/.zshrc
execute_command rm -rf /root/.p10k.zsh
execute_command rm -rf /root/.config/kitty
execute_command rm -rf /root/.config/nvim
execute_command rm -rf /opt/*nvim*
execute_command rm -rf /home/$input_username/.config/kitty
execute_command rm -rf /home/$input_username/.config/polybar
execute_command rm -rf /home/$input_username/.config/picom
execute_command rm -rf /home/$input_username/.config/bspwm
execute_command rm -rf /home/$input_username/.config/nvim
execute_command rm -rf /home/$input_username/.config/sxhkd

# CREAMOS NUEVAS CONFIGURACIONES
execute_command mkdir /root/.config
execute_command mkdir /home/$input_username/.config

# EDITOR DE CÓDIGO
while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m ¿Qué editor de código deseas utilizar? (NVIM/VSCODE): ")" code_editor
    code_editor=$(echo "$code_editor" | tr '[:upper:]' '[:lower:]')

    if [ "$code_editor" = "nvim" ]; then
        # INSTALANDO NVIM
        echo -e "\e[32m[*]\e[0m Instalando neovim ..."
        # CREAMOS NUEVAS CONFIGURACIONES
        execute_command apt install npm -y
        api_url="https://api.github.com/repos/neovim/neovim/releases/latest"
        download_url=$(curl -s $api_url | grep "browser_download_url.*nvim-linux64" | cut -d : -f 2,3 | tr -d '," ')
        execute_command wget $download_url 
        execute_command  tar -xf nvim-linux64.tar.gz
        execute_command mv nvim-linux64 /opt
        execute_command chown -R root:root /opt/nvim-linux64

        # INSTALANDO NVCHAD
        echo -e "\e[32m[*]\e[0m Instalando nvchad ..."
        execute_command mkdir /home/$input_username/.config/nvim
        execute_command mkdir /root/.config/nvim
        execute_command git clone https://github.com/NvChad/NvChad /home/$input_username/.config/nvim --depth 1
        execute_command git clone https://github.com/NvChad/NvChad /root/.config/nvim --depth 1

        # CREANDO LINK SIMBÓLICO ENTRE LOS ARCHIVOS DE CONFIGURACIÓN DE NVIM DEL USUARIO ELEGIDO Y DE ROOT
        echo -e "\e[32m[*]\e[0m Creando link simbólico en los archivos de configuración de nvim ..."
        execute_command  ln -s -f /home/$input_username/.config/nvim /root/.config/nvim

        # INSERTAMOS EL ALIAS DE NVIM EN LA ZSHRC
        echo -e "\e[32m[*]\e[0m Insertando alias de nvim en la zshrc ...\n"
        execute_command sed -i "/alias icat='kitty +kitten icat'/a alias nvim='\/opt\/nvim-linux64\/bin\/nvim'" $directorio_instalacion/zshrc
        execute_command sed -i "/alias icat='kitty +kitten icat'/a # nvim" $directorio_instalacion/zshrc
        execute_command sed -i '/alias icat='\''kitty +kitten icat'\''/{G;}' $directorio_instalacion/zshrc
        execute_command sed -i "/alias icat='kitty +kitten icat'/a alias nvim='\/opt\/nvim-linux64\/bin\/nvim'" $directorio_instalacion/.zshrc 
        execute_command sed -i "/alias icat='kitty +kitten icat'/a # nvim" $directorio_instalacion/.zshrc
        execute_command sed -i '/alias icat='\''kitty +kitten icat'\''/{G;}' $directorio_instalacion/.zshrc

        # INSERTAMOS EN EL SXHKDRC LOS SHORTCUS DE NVIM
        echo -e "\e[32m[*]\e[0m Insertando shortcuts de nvim en el sxhkdrc ...\n"
        execute_command echo -e '\n# nvim\nsuper + shift + e\n\tnvim' >> $directorio_instalacion/sxhkd/sxhkdrc   
        break
    elif [ "$code_editor" = "vscode" ]; then
        echo -e "\e[32m[*]\e[0m Instalando vscode ...\n"
        execute_command wget  https://vscode.download.prss.microsoft.com/dbazure/download/stable/0ee08df0cf4527e40edc9aa28f4b5bd38bbff2b2/code_1.85.1-1702462158_amd64.deb
        execute_command apt install ./code_1.85.1-1702462158_amd64.deb
        echo -e '\n# vscode\nsuper + shift + e\n\tcode' >> $directorio_instalacion/sxhkd/sxhkdrc   
        break
    else
        echo -e "\e[31m[*]\e[0m Respuesta no válida. Por favor, responde 'SI' o 'NO'.\n"
    fi
done

# SUSTITUIMOS USER_REPLACE POR EL USUARIO ELEGIDO
echo -e "\e[32m[*]\e[0m Configurando ficheros ...\n"
execute_command sed -i "s/user_replace/$input_username/g" $directorio_instalacion/polybar/*
execute_command sed -i "s/user_replace/$input_username/g" $directorio_instalacion/polybar/scripts/*
execute_command sed -i "s/user_replace/$input_username/g" $directorio_instalacion/bspwm/*
execute_command sed -i "s/user_replace/$input_username/g" $directorio_instalacion/bspwm/scripts*
execute_command sed -i "s/user_replace/$input_username/g" $directorio_instalacion/sxhkd/*
execute_command sed -i "s/user_replace/$input_username/g" $directorio_instalacion/p10k.zsh
execute_command sed -i "s/user_replace/$input_username/g" $directorio_instalacion/zshrc

# OBTENEMOS LAS INTERFACES DE RED
interfaces=$(ip -o link show | awk -F': ' '{print $2}')

wifi_interface=""
for interface in $interfaces; do
    if [[ $interface == *"wl"* ]]; then
        wifi_interface=$interface
        break
    fi
done

ethernet_interface=""
for interface in $interfaces; do
    if [[ $interface == *"en"* || $interface == *"eth"* ]]; then
        ethernet_interface=$interface
        break
    fi
done

# SUSTITUIMOS LAS INTERFACES DE RED EN LOS SCRIPTS DE LA POLYBAR
execute_command sed -i "s/ethernet_replace/$ethernet_interface/g" $directorio_instalacion/polybar/scripts/*
execute_command sed -i "s/wifi_replace/$wifi_interface/g" $directorio_instalacion/polybar/scripts/*

# SUSTITUIMOS LA BATERÍA Y EL ADAPTADOR
battery="$(ls -1 /sys/class/power_supply/ | cut -d'/' -f8- | tail -n 1)"
adapter="$(ls -1 /sys/class/power_supply/ | cut -d'/' -f8- | head -n 1)"
execute_command sed -i "s/battery_replace/$battery/g" "$directorio_instalacion/polybar/config.ini"
execute_command sed -i "s/adapter_replace/$adapter/g" "$directorio_instalacion/polybar/config.ini"

# CONFIGURANDO FONTS
echo -e "\e[32m[*]\e[0m Configurando fonts ...\n"
cp -r fonts /usr/local/share 

# CONFIGURANDO WALLPAPERS
echo -e "\e[32m[*]\e[0m Configurando wallpapers ...\n"
cp -r Wallpapers /home/$input_username

# CONFIGURANDO BETTERLOCKSCREEN
echo -e "\e[32m[*]\e[0m Configurando betterlockscreen ...\n"
execute_command betterlockscreen -u /home/$input_username/Wallpapers

# CONFIGURANDO SXHKD
echo -e "\e[32m[*]\e[0m Configurando sxhkd ...\n"
cp -r sxhkd /home/$input_username/.config

# CONFIGURANDO KITTY
echo -e "\e[32m[*]\e[0m Configurando kitty ...\n"
cp -r kitty /home/$input_username/.config
cp -r kitty /root/.config

# CREAMOS UN LINK SIMBÓLICO ENTRE LOS ARCHIVOS DE CONFIGURACIÓN DE LA KITTY DEL USUARIO ELEGIDO Y LOS DE ROOT
echo -e "\e[32m[*]\e[0m Creando link simbólico en kitty.conf y kitty.color ...\n"
execute_command ln -s -f /home/$input_username/.config/kitty /root/.config/kitty

# CONFIGURANDO PICOM
echo -e "\e[32m[*]\e[0m Configurando picom ...\n"
cp -r picom /home/$input_username/.config

# CONFIGURANDO PLUGIN SUDO ZSH
echo -e "\e[32m[*]\e[0m Configurando plugin zsh-sudo ...\n"
cp -r zsh-sudo /usr/share

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
execute_command mkdir /home/$input_username/.config/bin
execute_command touch /home/$input_username/.config/bin/target
cd "$directorio_instalacion"

# CONFIGURANDO POWERLEVEL10K
echo -e "\e[32m[*]\e[0m Configurando powerlevel10k del usuario $input_username ...\n"
execute_command rm -rf /home/$input_username/powerlevel10k
execute_command git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /home/$input_username/powerlevel10k
execute_command echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>/home/$input_username/.zshrc
execute_command mv zshrc .zshrc
execute_command mv p10k.zsh .p10k.zsh
cp .p10k.zsh /home/$input_username
cp .zshrc /home/$input_username

# CONFIGURANDO POWERLEVEL10K DE ROOT
echo -e "\e[32m[*]\e[0m Configurando powerlevel10k del usuario root ...\n"
execute_command rm -rf /root/powerlevel10k 
execute_command git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/powerlevel10k 
execute_command sh -c "echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> /root/.zshrc" 
cp .p10k.zsh /root 
cp .zshrc /root

# CREAMOS UN LINK SIMBÓLICO ENTRE LA ZSHRC DEL USUARIO ELEGIDO Y LA ZSHRC DE ROOT
echo -e "\e[32m[*]\e[0m Creando link simbólico en la zshrc ...\n"
execute_command ln -s -f /home/$input_username/.zshrc /root/.zshrc

# CREAMOS UN LINK SIMBÓLICO ENTRE LA P10K DEL USUARIO ELEGIDO Y EL P10K DE ROOT
echo -e "\e[32m[*]\e[0m Creando link simbólico en el archivo p10k.zsh ...\n"
execute_command ln -s -f /home/$input_username/.p10k.zsh /root/.p10k.zsh

# LE ASIGNAMOS EL PROPIETARIO CORRECTO A LOS ARCHIVOS
echo -e "\e[32m[*]\e[0m Asignando el propietario correcto a los archivos de configuración ...\n"
chown -R $input_username:$input_username /home/$input_username

# ELIMINAMOS LOS PAQUETES QUE NO SON NECESARIOS
echo -e "\e[32m[*]\e[0m Eliminando paquetes apt innecesarios ...\n"
execute_command apt autoremove -y

# ELIMINAMOS LOS ARCHIVOS DE CACHÉ
echo -e "\e[32m[*]\e[0m Limpiando caché de paquetes apt ...\n"
apt clean 

# ENTORNO BSPWM CONFIGURADO CON ÉXITO
echo -e "\e[32m[*]\e[0m ¡El entorno bspwm ha sido instalado con éxito!\n"

# ADVERTENCIA
echo -e "\e[33m[*]\e[0m Si no ha realizado una instalación limpia es posible que tenga que iniciar sesión nuevamente para que se apliquen los cambios correctamente.\n"
