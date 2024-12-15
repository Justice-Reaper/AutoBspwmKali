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
    read -p "$(echo -e "\e[33m[*]\e[0m ¿Deseas realizar un 'apt update' en el sistema? (SI/NO): ")" response
    response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

    if [ "$response" = "si" ] || [ "$response" = "s" ]; then
        echo -e "\e[32m[*]\e[0m Ejecutando 'apt update' ...\n"
        apt update 
        break
    elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
        echo -e "\e[31m[*]\e[0m Operación 'apt update' cancelada.\n"
        break
    else
        echo -e "\e[31m[*]\e[0m Respuesta no válida. Por favor, responde 'SI' o 'NO'.\n"
    fi
done

# UPGRADEAMOS EL SISTEMA
while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m ¿Deseas realizar un 'full-upgrade' en el sistema? (SI/NO): ")" response
    response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

    if [ "$response" = "si" ] || [ "$response" = "s" ]; then
        echo -e "\e[32m[*]\e[0m Ejecutando 'apt full-upgrade' ...\n"
        apt full-upgrade -y 
        break
    elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
        echo -e "\e[31m[*]\e[0m Operación 'apt full-upgrade' cancelada.\n"
        break
    else
        echo -e "\e[31m[*]\e[0m Respuesta no válida. Por favor, responde 'SI' o 'NO'.\n"
    fi
done

# INSTALAMOS LAS DEPENDENCIAS NECESARIAS
echo -e "\e[32m[*]\e[0m Instalando las dependencias necesarias ...\n"
apt install imagemagick feh xclip bspwm sxhkd wmname fastfetch polybar betterlockscreen bat lsd fzf flameshot picom rofi kitty zsh jq pulseaudio-utils seclists bloodhound neo4j x11-utils moreutils -y

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

# CONFIGURANDO BETTERLOCKSCREEN
echo -e "\e[32m[*]\e[0m Configurando betterlockscreen ...\n"
su $input_username -c "betterlockscreen -u /home/$input_username/Wallpapers/wallpaper.jpg"

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
        read -p "$(echo -e "\e[33m[*]\e[0m ¿Deseas instalar los DRIVERS PROPIETARIOS de NVIDIA? (SI/NO): ")" response
        response=$(echo "$response" | tr '[:upper:]' '[:lower:]')
      
        if [ "$response" = "si" ] || [ "$response" = "s" ]; then
            echo -e "\e[32m[*]\e[0m Instalando los drivers propietarios de nvidia ...\n"
            apt install nvidia-detect nvidia-smi nvidia-driver nvidia-cuda-toolkit -y
            apt install $(apt-cache pkgnames | grep -E '^linux-headers-[0-9]+\.[0-9]+\.[0-9]+-amd64$' | sort -V | tail -n 1) -y
            break
        elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
            echo -e "\e[31m[*]\e[0m Los drivers propietarios de nvidia no han sido instalados.\n"
            break
        else
            echo -e "\e[31m[*]\e[0m Respuesta no válida. Por favor, responde 'SI' o 'NO'.\n"
        fi
    done
}

configuracion_tecla_fn(){
    while true; do
        read -p "$(echo -e "\e[33m[*]\e[0m Aparecerá un output así (keysym 0x1008ff13, XF86AudioRaiseVolume) cuando introduzcas una combinación de teclas. Debes introducir el tercer parámetro, en este caso es XF86AudioRaiseVolume. Pon el puntero del ratón encima de la ventana blanca e introduce el parámetro que te aprece en la consola para $1: ")" response
        echo "$response" >> /tmp/keys
        break
    done
}

sustituir_shortcut_sxhkdrc(){
    awk '!seen[$0]++' /tmp/keys | sponge /tmp/keys
    while IFS= read -r line; do
        sed -i "s/$1/$line/" /home/$input_username/.config/sxhkd/sxhkdrc
    done < /tmp/keys
    rm /tmp/keys
}

configuracion_shortcuts(){
    while true; do
        read -p "$(echo -e "\e[33m[*]\e[0m ¿Quieres usar la tecla FN o la tecla WINDOWS para los shorcuts de teclado (se utilizará para SUBIR/BAJAR el VOLUMEN/BRILLO y para el MUTEAR el SONIDO)? (FN/WINDOWS): ")" response
        response=$(echo "$response" | tr '[:upper:]' '[:lower:]')
      
        if [ "$response" = "windows" ]; then
            echo -e "\e[32m[*]\e[0m Configurando tecla windows ...\n"
            break
        elif [ "$response" = "fn" ]; then
            echo -e "\e[32m[*]\e[0m Configurando tecla fn ...\n"
            kitty --detach bash -c "xev | grep 'keysym'; exec bash"
            configuracion_tecla_fn "subir el volumen"
            sustituir_shortcut_sxhkdrc "super + F7"
            configuracion_tecla_fn "bajar el volumen"
            sustituir_shortcut_sxhkdrc "super + F6"
            configuracion_tecla_fn "mutear y desmutear el audio"
            sustituir_shortcut_sxhkdrc "super + F5"
            configuracion_tecla_fn "subir el brillo"
            sustituir_shortcut_sxhkdrc "super + F3"
            configuracion_tecla_fn "bajar el brillo"
            sustituir_shortcut_sxhkdrc "super + F2"
            break
        else
            echo -e "\e[31m[*]\e[0m Respuesta no válida. Por favor, responde 'SI' o 'NO'.\n"
        fi
    done
}

activar_clipboard_bidireccional(){
    while true; do
        read -p "$(echo -e "\e[33m[*]\e[0m ¿Estas usando vmware y deseas activar la clipboard bidireccional? (SI/NO): ")" response
        response=$(echo "$response" | tr '[:upper:]' '[:lower:]')
      
        if [ "$response" = "si" ] || [ "$response" = "s" ]; then
            echo -e "\e[32m[*]\e[0m La clipboard bidireccional ha sido configurada con éxito.\n"
            break
        elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
            echo -e "\e[31m[*]\e[0m La clipboard bidireccional no ha sido activada.\n"
            sed -i '/# bidirectional clipboard/,+2d' /home/$input_username/.config/bspwm/bspwmrc 
            break
        else
            echo -e "\e[31m[*]\e[0m Respuesta no válida. Por favor, responde 'SI' o 'NO'.\n"
        fi
    done
}

configuracion_touchpad() {
    while true; do
        read -p "$(echo -e "\e[33m[*]\e[0m ¿Deseas desactivar el touchpad por defecto? (SI/NO): ")" response
        response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

        if [ "$response" = "si" ] || [ "$response" = "s" ]; then
            echo -e "\e[32m[*]\e[0m Configurando el touchpad ...\n"
            apt install xinput -y
            touchpad=$(xinput list | grep -i touchpad)
            if [[ -n "$touchpad" ]]; then
                id_touchpad=$(echo "$touchpad" | awk -F'id=' '{print $2}' | awk '{print $1}')
                sed -i '/# fix java error/i # touchpad' /home/$input_username/.config/bspwm/bspwmrc
                sed -i "/# fix java error/i xinput disable $id_touchpad" /home/$input_username/.config/bspwm/bspwmrc
                sed -i '/# fix java error/i\\' /home/$input_username/.config/bspwm/bspwmrc
            else
                echo -e "\e[31m[*]\e[0m No se ha encontrado ningún touchpad.\n"
            fi
            break
        elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
            echo -e "\e[31m[*]\e[0m El touchpad no ha sido desactivado.\n"
            sed -i '/# fix java error/ {x;d}; x' /home/$input_username/.config/bspwm/bspwmrc
            sed -i '/# touchpad/{N;d}' /home/$input_username/.config/bspwm/bspwmrc
            break
        else
            echo -e "\e[31m[*]\e[0m Respuesta no válida. Por favor, responde 'SI' o 'NO'.\n"
        fi
    done
}

configuacion_portatil_sobremesa(){
    while true; do
        read -p "$(echo -e "\e[33m[*]\e[0m ¿Estás usando un equipo de sobremesa? (SI/NO): ")" response
        response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

        if [ "$response" = "si" ] || [ "$response" = "s" ]; then
            echo -e "\e[32m[*]\e[0m Configurando el sistema para un equipo de sobremesa ...\n"
            
            echo -e "\e[32m[*]\e[0m Configurando polybar ...\n"
            sed -i '/\[module\/brightness\]/{x;d;};x' /home/$input_username/.config/polybar/config.ini 
            sed -i '/\[module\/brightness\]/,$d' /home/$input_username/.config/polybar/config.ini 
            sed -i 's/battery //' /home/$input_username/.config/polybar/config.ini 
            sed -i 's/brightness //' /home/$input_username/.config/polybar/config.ini 
            sed -i 's/battery_notification //' /home/$input_username/.config/polybar/config.ini 
            rm -f /home/$input_username/.config/polybar/scripts/increase_brightness.sh 
            rm -r /home/$input_username/.config/polybar/scripts/decrease_brightness.sh 
            rm -r /home/$input_username/.config/polybar/scripts/brightness_control.sh

            echo -e "\e[32m[*]\e[0m Configurando zsh ...\n"
            sed -i '/function enableTouchpad()/ {x;d}; x' /home/$input_username/.zshrc
            sed -i '/function enableTouchpad(){/,+10d' /home/$input_username/.zshrc 

            echo -e "\e[32m[*]\e[0m Configurando bspwm ...\n"
            sed -i '/# dunst/,+2d' /home/$input_username/.config/bspwm/bspwmrc  
            sed -i '/# brightness/,+6d' /home/$input_username/.config/bspwm/bspwmrc

            break
        elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
            echo -e "\e[32m[*]\e[0m Configurando el sistema para un portátil ...\n"
            configuracion_touchpad
            instalacion_dunst
            break
        else
            echo -e "\e[31m[*]\e[0m Respuesta no válida. Por favor, responde 'SI' o 'NO'.\n"
        fi
      done
    sed -i '/# bidirectional clipboard/,+2d' /home/$input_username/.config/bspwm/bspwmrc
    apt install brightnessctl -y
}

instalacion_dunst(){
    echo -e "\e[32m[*]\e[0m Configurando dunst ...\n"
    apt install acpi dunst -y
    rm -rf /home/$input_username/.config/dunst
    touch /home/$input_username/.config/bin/battery_discharging  
    touch /home/$input_username/.config/bin/battery_charging
    touch /home/$input_username/.config/bin/battery_warning
    touch /home/$input_username/.config/bin/target/battery_fully_charged  
    cp -r dunst /home/$input_username/.config
    sed -i "s/user_replace/$input_username/g" /home/$input_username/.config/dunst/dunstrc
    sed -i "s/user_replace/$input_username/g" /home/$input_username/.config/dunst/scripts/*
    cd /home/$input_username/.config/dunst/scripts 
    chmod +x * 
    cd "$directorio_instalacion"
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
    wget https://raw.githubusercontent.com/Justice-Reaper/rpcEnum/refs/heads/main/rpcEnum.sh
    chmod +x rpcEnum.sh
    mv rpcEnum.sh rpcEnum
    mv rpcEnum /usr/bin
}

instalacion_jetbrains_toolbox(){
    echo -e "\e[32m[*]\e[0m Instalando jetbrains toolbox ..."
    URL="https://data.services.jetbrains.com/products/releases?code=TBA&latest=true&type=release"
    latest_info=$(curl -s $URL)
    download_link=$(echo $latest_info | jq -r '.TBA[0].downloads.linux.link')
    wget -O jetbrains-toolbox.tar.gz $download_link
    tar -xzf jetbrains-toolbox.tar.gz
    mv $(tar -tf jetbrains-toolbox.tar.gz | head -1 | cut -f1 -d"/") jetbrains-toolbox
    cp -r jetbrains-toolbox /opt
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
    apt install -y libu2f-udev
    wget -O google-chrome-stable_current_amd64.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    dpkg -i google-chrome-stable_current_amd64.deb

    while true; do
        read -p "$(echo -e "\e[33m[*]\e[0m ¿Quieres sea tu NAVEGADOR principal? (SI/NO): ")" response
        response=$(echo "$response" | tr '[:upper:]' '[:lower:]')
      
        if [ "$response" = "si" ] || [ "$response" = "s" ]; then
            echo -e "\e[32m[*]\e[0m Configurando chrome como su navegador principal ..."
            sed -i 's/firefox/google-chrome/g' /home/$input_username/.config/sxhkd/sxhkdrc
            break
        elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
            echo -e "\e[31m[*]\e[0m Chrome no será su navegador principal.\n"
            break
        else
            echo -e "\e[31m[*]\e[0m Respuesta no válida. Por favor, responde 'SI' o 'NO'.\n"
        fi
    done
}

customizacion_grub_timeout(){
    while true; do
        read -p "$(echo -e "\e[33m[*]\e[0m Introduce el número de segundos que se mostrará grub (si introduces -1 no dejará de mostrarse hasta que lo selecciones manualmente): ")" response
        response=$(echo "$response" | tr '[:upper:]' '[:lower:]')
      
        if [[ "$response" =~ ^-?[0-9]+$ ]]; then
            echo -e "\e[32m[*]\e[0m Configurando la variable GRUB_TIMEOUT ..."
            sed -i "s/^GRUB_TIMEOUT=.*/GRUB_TIMEOUT=$response/" /etc/default/grub 
            break
        else
            echo -e "\e[31m[*]\e[0m Respuesta no válida. Por favor, introduce un número válido. Ejemplo: -1, 5, 15.\n"
        fi
    done
}

customizacion_grub_theme(){
    while true; do
        read -p "$(echo -e "\e[33m[*]\e[0m ¿Quieres usar el grub clásico, en blanco y negro? (SI/NO): ")" response
        response=$(echo "$response" | tr '[:upper:]' '[:lower:]')
      
        if [ "$response" = "si" ] || [ "$response" = "s" ]; then
            echo -e "\e[32m[*]\e[0m Configurando el grub clásico ..."
            sed -i '/^GRUB_DISTRIBUTOR=[^ ]*/s/^/#/' /etc/default/grub 
            sed -i '/^#GRUB_TERMINAL=console/s/^#//' /etc/default/grub
            line=$(grep -n "set menu_color_normal" /boot/grub/grub.cfg | cut -d: -f1)
            line=$((line - 1))
            file=$(sed -n "${line}s/.*BEGIN\(.*\)###.*/\1/p" /boot/grub/grub.cfg)
            sed -i 's/menu_color_normal=cyan\/blue/menu_color_normal=white\/black/' $file
            sed -i 's/menu_color_highlight=white\/blue/menu_color_highlight=black\/light-gray/' $file
            break
        elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
            echo -e "\e[31m[*]\e[0m El tema de grub no será modificado.\n"
            break
        else
            echo -e "\e[31m[*]\e[0m Respuesta no válida. Por favor, responde 'SI' o 'NO'.\n"
        fi
    done
}

advertencia(){
    while true; do
        read -p "$(echo -e "\e[33m[*]\e[0m Si estás en un sistema operativo nativo, debes reiniciar y ejecutar el script nuevamente desde bspwm para que funcione todo correctamente. ¿Deseas reiniciar? (SI/NO): ")" response
        response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

       if [ "$response" = "si" ] || [ "$response" = "s" ]; then
           reboot
           break
       elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
           echo -e "\e[31m[*]\e[0m No se efectuará el reinicio, si has hecho una instalación limpia, acabas de actualizar los paquetes y estás en un equipo portátil, puede que no se detecte el touchpad (reiniciar si desea desactivarlo por defecto). Si no estás en un entorno BSPWM, no podrás configurar la tecla FN en vez de la tecla WINDOWS en los atajos de teclado.\n"
           break
       else
           echo -e "\e[31m[*]\e[0m Respuesta no válida. Por favor, responde 'SI' o 'NO'.\n"
       fi
    done
}

# ELECCIÓN MÁQUINA VIRTUAL O SISTEMA NATIVO
while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m ¿Estás usando una máquina virtual? (SI/NO): ")" response
    response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

    if [ "$response" = "si" ] || [ "$response" = "s" ]; then
        echo -e "\e[32m[*]\e[0m Configurando el sistema para una máquina virtual ...\n"
        echo -e "\e[32m[*]\e[0m Configurando bspwmrc ...\n"
        sed -i '/# brightness/,+6d' /home/$input_username/.config/bspwm/bspwmrc
        echo -e "\e[32m[*]\e[0m Configurando picom ...\n"
        sed -i 's/^\(round-borders = 15;\)/# \1/' /home/$input_username/.config/picom/picom.conf
        sed -i 's/^\(corner-radius = 15;\)/# \1/' /home/$input_username/.config/picom/picom.conf
        sed -i '/backend = "glx";/d' /home/$input_username/.config/picom/picom.conf
        sed -i '/^use-damage = false/d' /home/$input_username/.config/picom/picom.conf
        sed -i '/^vsync = true$/d' /home/$input_username/.config/picom/picom.conf     
        echo -e "\e[32m[*]\e[0m Configurando polybar ...\n"
        sed -i '/\[module\/brightness\]/{x;d;};x' /home/$input_username/.config/polybar/config.ini 
        sed -i '/\[module\/brightness\]/,$d' /home/$input_username/.config/polybar/config.ini 
        sed -i 's/battery //' /home/$input_username/.config/polybar/config.ini 
        sed -i 's/brightness //' /home/$input_username/.config/polybar/config.ini 
        rm -f /home/$input_username/.config/polybar/scripts/increase_brightness.sh 
        rm -r /home/$input_username/.config/polybar/scripts/decrease_brightness.sh 
        rm -r /home/$input_username/.config/polybar/scripts/brightness_control.sh
        echo -e "\e[32m[*]\e[0m Configurando sxhkdrc ...\n"
        sed -i '/# increase brightness/,+7d' /home/$input_username/.config/sxhkd/sxhkdrc 
        activar_clipboard_bidireccional
        break
    elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
        echo -e "\e[32m[*]\e[0m Se está configurando el sistema para un sistema nativo ...\n"
        advertencia
        configuacion_portatil_sobremesa
        instalacion_drivers_nvidia
        configuracion_shortcuts
        break
    else
        echo -e "\e[31m[*]\e[0m Respuesta no válida. Por favor, responde 'SI' o 'NO'.\n"
    fi
done

# CUSTOMIZACIÓN GRUB
while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m ¿Deseas customizar grub? (SI/NO): ")" response
    response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

   if [ "$response" = "si" ] || [ "$response" = "s" ]; then
        customizacion_grub_timeout
        customizacion_grub_theme
        update-grub
        break
   elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
        echo -e "\e[31m[*]\e[0m Grub no será modificado.\n"
        break
    else
        echo -e "\e[31m[*]\e[0m Respuesta no válida. Por favor, responde 'SI' o 'NO'.\n"
    fi
done

# ELECCIÓN KDE O XFCE
while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m ¿Estás usando una KDE o XFCE? (KDE/XFCE): ")" response
    response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

    if [ "$response" = "kde" ]; then
        echo -e "\e[32m[*]\e[0m Configurando kde ..."
        sed -i 's/thunar/dolphin/g' /home/$input_username/.config/sxhkd/sxhkdrc
        break
    elif [ "$response" = "xfce" ]; then
        echo -e "\e[32m[*]\e[0m Configurando xfce ..."
        break
    else
        echo -e "\e[31m[*]\e[0m Respuesta no válida. Por favor, responde 'KDE' o 'XFCE'.\n"
    fi
done

# OBSIDIAN
while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m ¿Quieres instalar OBSIDIAN? (SI/NO): ")" response
    response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

    if [ "$response" = "si" ] || [ "$response" = "s" ]; then
        apt install obsidian -y
        break
    elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
        echo -e "\e[31m[*]\e[0m obsidian no ha sido instalado.\n"
        sed -i '/# obsidian/,+3d' /home/$input_username/.config/sxhkd/sxhkdrc
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

# JETBRAINS TOOLBOX
while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m ¿Quieres instalar JETBRAINS TOOLBOX? (SI/NO): ")" response
    response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

    if [ "$response" = "si" ] || [ "$response" = "s" ]; then
        instalacion_jetbrains_toolbox
        break
    elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
        sed -i '/# jetbrains toolbox/,+2d' /home/$input_username/.zshrc
        sed -i '/# jetbrains toolbox/,+2d' /root/.zshrc
        sed -i '/# pycharm/,+3d' /home/$input_username/.config/sxhkd/sxhkdrc
        sed -i '/# pycharm/,+2d' /home/$input_username/.zshrc
        sed -i '/# pycharm/,+2d' /root/.zshrc
        echo -e "\e[31m[*]\e[0m Jetbrains toolbox no ha sido instalada.\n"
        break
    else
        echo -e "\e[31m[*]\e[0m Respuesta no válida. Por favor, responde 'SI' o 'NO'.\n"
    fi
done

# SUSTITUIMOS USER_REPLACE POR EL USUARIO ELEGIDO
echo -e "\e[32m[*]\e[0m Configurando ficheros ...\n"
sed -i "s/user_replace/$input_username/g" /home/$input_username/.config/polybar/config.ini
sed -i "s/user_replace/$input_username/g" /home/$input_username/.config/polybar/scripts/*  
sed -i "s/user_replace/$input_username/g" /home/$input_username/.config/bspwm/bspwmrc  
sed -i "s/user_replace/$input_username/g" /home/$input_username/.config/sxhkd/sxhkdrc
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
