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

# OBTENEMOS EL DIRECTORIO ACTUAL
directorio_instalacion=$(pwd)

# OBTENEMOS EL USUARIO
echo -e "\e[33m[*]\e[0m Este script configurará el sistema en base al usuario proporcionado y al usuario root.\n"

while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m Por favor, introduce el nombre del usuario sobre el cual se aplicarán los cambios: ")" input_username
    if id "$input_username" &>/dev/null; then
        echo "$(id $input_username)"
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
        apt update 
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
        apt full-upgrade -y 
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
apt install imagemagick feh xclip bspwm sxhkd wmname fastfetch polybar betterlockscreen bat lsd fzf flameshot picom rofi kitty zsh jq -y

# ELIMINAMOS LAS CONFIGURACIONES ANTIGUAS
echo -e "\e[32m[*]\e[0m Eliminando antiguas configuraciones ...\n"
rm -f /home/$input_username/.zshrc 
rm -f /home/$input_username/.p10k.zsh 
rm -f /root/.zshrc 
rm -f /root/.p10k.zsh 
rm -rf /root/.config/kitty 
rm -rf /home/$input_username/.config/kitty 
rm -rf /home/$input_username/.config/polybar 
rm -rf /home/$input_username/.config/picom 
rm -rf /home/$input_username/.config/bspwm 
rm -rf /home/$input_username/.config/sxhkd 

# CREAMOS NUEVAS CONFIGURACIONES
echo -e "\e[32m[*]\e[0m Creando nuevas configuraciones ...\n"
mkdir /root/.config 
mkdir /home/$input_username/.config 

# CONFIGURANDO FONTS
echo -e "\e[32m[*]\e[0m Configurando fonts ...\n"
LATEST_RELEASE=$(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | grep "tag_name" | cut -d '"' -f 4)
wget -O Hack.zip https://github.com/ryanoasis/nerd-fonts/releases/download/$LATEST_RELEASE/Hack.zip
unzip -o Hack.zip
mv *.ttf fonts/
cp -r fonts /usr/local/share 

# CONFIGURANDO WALLPAPERS
echo -e "\e[32m[*]\e[0m Configurando wallpapers ...\n"
cp -r Wallpapers /home/$input_username

# CONFIGURANDO SXHKD
echo -e "\e[32m[*]\e[0m Configurando sxhkd ...\n"
cp -r sxhkd /home/$input_username/.config

# CONFIGURANDO KITTY
echo -e "\e[32m[*]\e[0m Configurando kitty ...\n"
cp -r kitty /home/$input_username/.config
cp -r kitty /root/.config

# CONFIGURANDO PICOM
echo -e "\e[32m[*]\e[0m Configurando picom ...\n"
cp -r picom /home/$input_username/.config

# CONFIGURANDO PLUGIN SUDO ZSH
echo -e "\e[32m[*]\e[0m Configurando plugin zsh-sudo ...\n"
cp -r zsh-sudo /usr/share

# CONFIGURANDO BETTERLOCKSCREEN
echo -e "\e[32m[*]\e[0m Configurando betterlockscreen ...\n"
betterlockscreen -u /home/$input_username/Wallpapers/wallpaper.jpg 

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
mkdir /home/$input_username/.config/bin  
touch /home/$input_username/.config/bin/target  
cd "$directorio_instalacion"

# CONFIGURANDO POWERLEVEL10K
echo -e "\e[32m[*]\e[0m Configurando powerlevel10k del usuario $input_username ...\n"
rm -rf /home/$input_username/powerlevel10k  
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /home/$input_username/powerlevel10k  
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>/home/$input_username/.zshrc  
mv zshrc .zshrc  
mv p10k.zsh .p10k.zsh  
cp .p10k.zsh /home/$input_username
cp .zshrc /home/$input_username

# CONFIGURANDO POWERLEVEL10K DE ROOT
echo -e "\e[32m[*]\e[0m Configurando powerlevel10k del usuario root ...\n"
rm -rf /root/powerlevel10k  
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/powerlevel10k  
sh -c "echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> /root/.zshrc"  
cp .p10k.zsh /root 
cp .zshrc /root

# FUNCIONES DE INSTALACIÓN Y CONFIGURACIÓN
instalacion_drivers_nvidia(){
    while true; do
        read -p "$(echo -e "\e[33m[*]\e[0m ¿Deseas instalar los drivers propietarios de nvidia? (SI/NO): ")" drivers_nvidia
        drivers_nvidia=$(echo "$drivers_nvidia" | tr '[:upper:]' '[:lower:]')
      
        if [ "$drivers_nvidia" = "si" ] || [ "$drivers_nvidia" = "s" ]; then
            echo -e "\e[32m[*]\e[0m Instalando los drivers propietarios de nvidia ...\n"
            apt install nvidia-detect nvidia-smi nvidia-driver nvidia-cuda-toolkit -y
            apt install $(apt-cache pkgnames | grep -E '^linux-headers-[0-9]+\.[0-9]+\.[0-9]+-amd64$' | sort -V | tail -n 1) -y
            break
        elif [ "$drivers_nvidia" = "no" ] || [ "$drivers_nvidia" = "n" ]; then
            echo -e "\e[31m[*]\e[0m Los drivers propietarios de nvidia no han sido instalados.\n"
            break
        else
            echo -e "\e[31m[*]\e[0m Respuesta no válida. Por favor, responde 'SI' o 'NO'.\n"
        fi
    done
}

activar_clipboard_bidireccional(){
    while true; do
        read -p "$(echo -e "\e[33m[*]\e[0m ¿Estas usando VmWare y deseas activar la clipboard bidireccional? (SI/NO): ")" respuesta_clipboard
        respuesta_clipboard=$(echo "$respuesta_clipboard" | tr '[:upper:]' '[:lower:]')
      
        if [ "$respuesta_clipboard" = "si" ] || [ "$respuesta_clipboard" = "s" ]; then
            echo -e "\e[32m[*]\e[0m La clipboard bidireccional ha sido configurada con éxito.\n"
            break
        elif [ "$respuesta_clipboard" = "no" ] || [ "$respuesta_clipboard" = "n" ]; then
            echo -e "\e[31m[*]\e[0m La clipboard bidireccional no ha sido activada.\n"
            sed -i '/# bidirectional clipboard/,+2d' /home/$input_username/.config/bspwm/bspwmrc 
            break
        else
            echo -e "\e[31m[*]\e[0m Respuesta no válida. Por favor, responde 'SI' o 'NO'.\n"
        fi
    done
}

configuacion_portatil_sobremesa(){
    while true; do
        read -p "$(echo -e "\e[33m[*]\e[0m ¿Estás usando un equipo de sobremesa? (SI/NO): ")" respuesta_sobremesa
        respuesta_sobremesa=$(echo "$respuesta_sobremesa" | tr '[:upper:]' '[:lower:]')

        if [ "$respuesta_sobremesa" = "si" ] || [ "$respuesta_sobremesa" = "s" ]; then
            echo -e "\e[32m[*]\e[0m Configurando el sistema para un equipo de sobremesa ...\n"
            echo -e "\e[32m[*]\e[0m Configurando polybar ...\n"
            sed -i '/\[module\/battery\]/{x;d;};x' /home/$input_username/.config/polybar/config.ini 
            sed -i '/\[module\/battery\]/,$d' /home/$input_username/.config/polybar/config.ini 
            sed -i 's/battery //' /home/$input_username/.config/polybar/config.ini 
            break
        elif [ "$respuesta_sobremesa" = "no" ] || [ "$respuesta_sobremesa" = "n" ]; then
            echo -e "\e[32m[*]\e[0m Configurando el sistema para un portátil ...\n"
            break
        else
            echo -e "\e[31m[*]\e[0m Respuesta no válida. Por favor, responde 'SI' o 'NO'.\n"
        fi
      done
    sed -i '/# bidirectional clipboard/,+2d' /home/$input_username/.config/bspwm/bspwmrc
    apt install brightnessctl -y
}

instalacion_nvim(){
    echo -e "\e[32m[*]\e[0m Instalando neovim ..."
    rm -rf /root/.config/nvim 
    rm -rf /opt/*nvim*  
    rm -rf /home/$input_username/.config/nvim 
    apt install npm -y  
    api_url="https://api.github.com/repos/neovim/neovim/releases/latest"
    download_url=$(curl -s $api_url | grep "browser_download_url.*nvim-linux64" | cut -d : -f 2,3 | tr -d '," ')
    wget -O nvim-linux64.tar.gz $download_url  
    tar -xf nvim-linux64.tar.gz  
    mv nvim-linux64 /opt  
    chown -R root:root /opt/nvim-linux64

    echo -e "\e[32m[*]\e[0m Instalando nvchad ..."
    mkdir /home/$input_username/.config/nvim  
    mkdir /root/.config/nvim  
    git clone https://github.com/NvChad/starter /home/$input_username/.config/nvim  
    git clone https://github.com/NvChad/starter /root/.config/nvim

    echo -e "\e[32m[*]\e[0m Creando link simbólico en los archivos de configuración de nvim ..."
    ln -s -f /home/$input_username/.config/nvim /root/.config/nvim  
}

instalacion_vscode(){
    echo -e "\e[32m[*]\e[0m Instalando vscode ...\n"
    LATEST_RELEASE=$(curl -s https://api.github.com/repos/microsoft/vscode/releases/latest | grep "tag_name" | cut -d '"' -f 4)
    DOWNLOAD_URL="https://update.code.visualstudio.com/$LATEST_RELEASE/linux-deb-x64/stable"
    wget -O vscode-latest.deb $DOWNLOAD_URL
    apt install ./vscode-latest.deb  
}

instalacion_rpcEnum(){
    echo -e "\e[32m[*]\e[0m Instalando rpcEnum ...\n"
    wget https://github.com/Justice-Reaper/rpcEnum/blob/main/rpceEnum.sh
    chmod +x rpceEnum.sh
    mv rpceEnum.sh rpceEnum
    mv rpceEnum /usr/bin
}

instalacion_toolbox_jetbrains(){
    echo -e "\e[32m[*]\e[0m Instalando toolbox jetbrains ..."
    URL="https://data.services.jetbrains.com/products/releases?code=TBA&latest=true&type=release"
    latest_info=$(curl -s $URL)
    download_link=$(echo $latest_info | jq -r '.TBA[0].downloads.linux.link')
    wget -O jetbrains-toolbox.tar.gz $download_link
    tar -xzf jetbrains-toolbox.tar.gz
    mv $(tar -tf jetbrains-toolbox.tar.gz | head -1 | cut -f1 -d"/") toolbox-jetbrains
    cp -r toolbox-jetbrains /opt
    sed -i '/# End of file/i * hard nofile 1048576\n' /etc/security/limits.conf
    sed -i '1i fs.file-max=10485760\n' /etc/sysctl.conf
}

instalacion_postman(){
    echo -e "\e[32m[*]\e[0m Instalando postman ..."
    wget https://dl.pstmn.io/download/latest/linux64 -O postman.tar.gz
    mkdir /opt/Postman
    tar -xzf postman.tar.gz -C /opt/Postman --strip-components=1
    mv Postman.desktop /usr/share/applications
}

instalacion_kerbrute(){
    echo -e "\e[32m[*]\e[0m Instalando kerbrute ..."
    latest_url=$(curl -s https://api.github.com/repos/ropnop/kerbrute/releases/latest | jq -r '.assets[] | select(.name | contains("linux_amd64")) | .browser_download_url')
    wget $latest_url -O kerbrute_linux_amd64
    chmod +x kerbrute_linux_amd64
    mv kerbrute_linux_amd64 kerbrute
    mv kerbrute /usr/bin
}

instalacion_windapsearch(){
    echo -e "\e[32m[*]\e[0m Instalando windapsearch ..."
    latest_url=$(curl -s https://api.github.com/repos/ropnop/go-windapsearch/releases/latest | jq -r '.assets[] | select(.name == "windapsearch-linux-amd64") | .browser_download_url')
    wget $latest_url -O windapsearch_linux_amd64
    chmod +x windapsearch_linux_amd64
    mv windapsearch_linux_amd64 windapsearch
    mv windapsearch /usr/bin
    echo -e "\e[32m[*]\e[0m Windapsearch instalado correctamente."
}

instalacion_chrome(){
    echo -e "\e[32m[*]\e[0m Instalando google chrome ..."
    apt-get install -y libu2f-udev
    wget -O google-chrome-stable_current_amd64.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    dpkg -i google-chrome-stable_current_amd64.deb

    while true; do
        read -p "$(echo -e "\e[33m[*]\e[0m ¿Quieres sea tu NAVEGADOR principal? (SI/NO): ")" response
        response=$(echo "$response" | tr '[:upper:]' '[:lower:]')
      
        if [ "$response" = "si" ] || [ "$response" = "s" ]; then
            echo -e "\e[32m[*]\e[0m Configurando chrome como su navegador principal ..."
            sed -i 's/firefox/google-chrome/g' /home/$input_username/.config/sxhkd/*
            break
        elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
            echo -e "\e[31m[*]\e[0m Chrome no será su navegador principal.\n"
            break
        else
            echo -e "\e[31m[*]\e[0m Respuesta no válida. Por favor, responde 'SI' o 'NO'.\n"
        fi
    done
}

# ELECCIÓN MÁQUINA VIRTUAL O SISTEMA NATIVO (MODIFICAR)
while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m ¿Estás usando una máquina virtual? (SI/NO): ")" respuesta_virtual_machine
    respuesta_virtual_machine=$(echo "$respuesta_virtual_machine" | tr '[:upper:]' '[:lower:]')

    if [ "$respuesta_virtual_machine" = "si" ] || [ "$respuesta_virtual_machine" = "s" ]; then
        echo -e "\e[32m[*]\e[0m Configurando el sistema para una máquina virtual ...\n"
        echo -e "\e[32m[*]\e[0m Configurando bspwmrc ...\n"
        sed -i '/# bright/,+6d' /home/$input_username/.config/bspwm/bspwmrc
        echo -e "\e[32m[*]\e[0m Configurando picom ...\n"
        sed -i 's/^\(round-borders = 15;\)/# \1/' /home/$input_username/.config/picom/picom.conf
        sed -i 's/^\(corner-radius = 15;\)/# \1/' /home/$input_username/.config/picom/picom.conf
        sed -i '/backend = "glx";/d' /home/$input_username/.config/picom/picom.conf
        sed -i '/^use-damage = false/d' /home/$input_username/.config/picom/picom.conf
        echo -e "\e[32m[*]\e[0m Configurando polybar ...\n"
        sed -i '/\[module\/backlight\]/{x;d;};x' /home/$input_username/.config/polybar/config.ini 
        sed -i '/\[module\/backlight\]/,$d' /home/$input_username/.config/polybar/config.ini 
        sed -i 's/battery //' /home/$input_username/.config/polybar/config.ini 
        sed -i 's/backlight //' /home/$input_username/.config/polybar/config.ini 
        rm -f /home/$input_username/.config/polybar/scripts/increase_bright.sh 
        rm -r /home/$input_username/.config/polybar/scripts/decrease_bright.sh 
        echo -e "\e[32m[*]\e[0m Configurando sxhkdrc ...\n"
        sed -i '/# increase bright/,+7d' /home/$input_username/.config/sxhkd/sxhkdrc 
        activar_clipboard_bidireccional
        break
    elif [ "$respuesta_virtual_machine" = "no" ] || [ "$respuesta_virtual_machine" = "n" ]; then
        echo -e "\e[32m[*]\e[0m Se está configurando el sistema para un sistema nativo ...\n"
        configuacion_portatil_sobremesa
        instalacion_drivers_nvidia
        break
    else
        echo -e "\e[31m[*]\e[0m Respuesta no válida. Por favor, responde 'SI' o 'NO'.\n"
    fi
done

# KERBRUTE
while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m ¿Quieres instalar KERBRUTE? (SI/NO): ")" response
    response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

    if [ "$response" = "si" ] || [ "$response" = "s" ]; then
        instalacion_kerbrute
        break
    elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
        echo -e "\e[31m[*]\e[0m kerbrute no ha sido instalado.\n"
        break
    else
        echo -e "\e[31m[*]\e[0m Respuesta no válida. Por favor, responde 'SI' o 'NO'.\n"
    fi
done

# WINDAPSEARCH
while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m ¿Quieres instalar WINDAPSEARCH? (SI/NO): ")" response
    response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

    if [ "$response" = "si" ] || [ "$response" = "s" ]; then
        instalacion_windapsearch
        break
    elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
        echo -e "\e[31m[*]\e[0m Windapsearch no ha sido instalado.\n"
        break
    else
        echo -e "\e[31m[*]\e[0m Respuesta no válida. Por favor, responde 'SI' o 'NO'.\n"
    fi
done

# RPCENUM
while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m ¿Quieres instalar RPCENUM? (SI/NO): ")" response
    response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

    if [ "$response" = "si" ] || [ "$response" = "s" ]; then
        instalacion_rpcEnum
        break
    elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
        echo -e "\e[31m[*]\e[0m rpcEnum no ha sido instalado.\n"
        break
    else
        echo -e "\e[31m[*]\e[0m Respuesta no válida. Por favor, responde 'SI' o 'NO'.\n"
    fi
done

# CHROME
while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m ¿Quieres instalar GOOGLE CHROME? (SI/NO): ")" response
    response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

    if [ "$response" = "si" ] || [ "$response" = "s" ]; then
        instalacion_chrome
        break
    elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
        echo -e "\e[31m[*]\e[0m Chrome no ha sido instalado.\n"
        break
    else
        echo -e "\e[31m[*]\e[0m Respuesta no válida. Por favor, responde 'SI' o 'NO'.\n"
    fi
done

# POSTMAN
while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m ¿Quieres instalar POSTMAN? (SI/NO): ")" response
    response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

    if [ "$response" = "si" ] || [ "$response" = "s" ]; then
        instalacion_postman
        break
    elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
        echo -e "\e[31m[*]\e[0m Postman no ha sido instalado.\n"
        sed -i '/# postman/,+3d' /home/$input_username/.config/sxhkd/sxhkdrc
        sed -i '/# postman/,+2d' /home/$input_username/.zshrc
        sed -i '/# postman/,+2d' /root/.zshrc
        break
    else
        echo -e "\e[31m[*]\e[0m Respuesta no válida. Por favor, responde 'SI' o 'NO'.\n"
    fi
done

# NVIM
while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m ¿Quieres instalar NVIM? (SI/NO): ")" response
    response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

    if [ "$response" = "si" ] || [ "$response" = "s" ]; then
        instalacion_nvim
        break
    elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
        echo -e "\e[31m[*]\e[0m Nvim no ha sido instalado.\n"
        sed -i '/# nvim/,+2d' /home/$input_username/.zshrc
        sed -i '/# nvim/,+2d' /root/.zshrc
        break
    else
        echo -e "\e[31m[*]\e[0m Respuesta no válida. Por favor, responde 'SI' o 'NO'.\n"
    fi
done

# VSCODE
while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m ¿Quieres instalar VSCODE? (SI/NO): ")" response
    response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

    if [ "$response" = "si" ] || [ "$response" = "s" ]; then
        instalacion_vscode
        break
    elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
        echo -e "\e[31m[*]\e[0m Vscode no ha sido instalado.\n"
        sed -i '/# vscode/,+3d' /home/$input_username/.config/sxhkd/sxhkdrc
        break
    else
        echo -e "\e[31m[*]\e[0m Respuesta no válida. Por favor, responde 'SI' o 'NO'.\n"
    fi
done

# TOOLBOX JETBRAINS
while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m ¿Quieres instalar TOOLBOX JETBRAINS? (SI/NO): ")" response
    response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

    if [ "$response" = "si" ] || [ "$response" = "s" ]; then
        instalacion_toolbox_jetbrains
        break
    elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
        sed -i '/# toolbox jetbrains/,+2d' /home/$input_username/.zshrc
        sed -i '/# toolbox jetbrains/,+2d' /root/.zshrc
        sed -i '/# pycharm/,+3d' /home/$input_username/.config/sxhkd/sxhkdrc
        sed -i '/# pycharm/,+2d' /home/$input_username/.zshrc
        sed -i '/# pycharm/,+2d' /root/.zshrc
        echo -e "\e[31m[*]\e[0m Toolbox jetbrains no ha sido instalada.\n"
        break
    else
        echo -e "\e[31m[*]\e[0m Respuesta no válida. Por favor, responde 'SI' o 'NO'.\n"
    fi
done

# SUSTITUIMOS USER_REPLACE POR EL USUARIO ELEGIDO
echo -e "\e[32m[*]\e[0m Configurando ficheros ...\n"
sed -i "s/user_replace/$input_username/g" /home/$input_username/.config/polybar/*  
sed -i "s/user_replace/$input_username/g" /home/$input_username/.config/polybar/scripts/*  
sed -i "s/user_replace/$input_username/g" /home/$input_username/.config/bspwm/*  
sed -i "s/user_replace/$input_username/g" /home/$input_username/.config/bspwm/scripts*  
sed -i "s/user_replace/$input_username/g" /home/$input_username/.config/sxhkd/*  
sed -i "s/user_replace/$input_username/g" /home/$input_username/.p10k.zsh  
sed -i "s/user_replace/$input_username/g" /home/$input_username/.zshrc  

# SUSTITUIMOS LA BATERÍA Y EL ADAPTADOR
battery="$(ls -1 /sys/class/power_supply | grep "BA" | cut -d'/' -f8-)"
adapter="$(ls -1 /sys/class/power_supply | grep "AC" | cut -d'/' -f8-)"
sed -i "s/battery_replace/$battery/g" "/home/$input_username/.config/polybar/config.ini"  
sed -i "s/adapter_replace/$adapter/g" "/home/$input_username/.config/polybar/config.ini"  

# CREAMOS UN LINK SIMBÓLICO ENTRE LOS ARCHIVOS DE CONFIGURACIÓN DE LA KITTY DEL USUARIO ELEGIDO Y LOS DE ROOT
echo -e "\e[32m[*]\e[0m Creando link simbólico en kitty.conf y kitty.color ...\n"
ln -s -f /home/$input_username/.config/kitty /root/.config/kitty

# CREAMOS UN LINK SIMBÓLICO ENTRE LA ZSHRC DEL USUARIO ELEGIDO Y LA ZSHRC DE ROOT
echo -e "\e[32m[*]\e[0m Creando link simbólico en la zshrc ...\n"
ln -s -f /home/$input_username/.zshrc /root/.zshrc

# CREAMOS UN LINK SIMBÓLICO ENTRE LA P10K DEL USUARIO ELEGIDO Y EL P10K DE ROOT
echo -e "\e[32m[*]\e[0m Creando link simbólico en el archivo p10k.zsh ...\n"
ln -s -f /home/$input_username/.p10k.zsh /root/.p10k.zsh

# LE ASIGNAMOS EL PROPIETARIO CORRECTO A LOS ARCHIVOS
echo -e "\e[32m[*]\e[0m Asignando el propietario correcto a los archivos de configuración ...\n"
chown -R $input_username:$input_username /home/$input_username

# ELIMINAMOS LOS PAQUETES QUE NO SON NECESARIOS
echo -e "\e[32m[*]\e[0m Eliminando paquetes apt innecesarios ...\n"
apt autoremove -y  

# ELIMINAMOS LOS ARCHIVOS DE CACHÉ
echo -e "\e[32m[*]\e[0m Limpiando caché de paquetes apt ...\n"
apt clean -y

# ENTORNO BSPWM CONFIGURADO CON ÉXITO
echo -e "\e[32m[*]\e[0m ¡El entorno bspwm ha sido instalado con éxito!\n"
echo -e "\e[32m[*]\e[0m Se recomienda volver a reiniciar/iniciar sesión para que la configuración cargue correctamente\n"
