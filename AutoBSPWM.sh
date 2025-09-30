#!/bin/bash

# AUTHOR
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

# USER VERIFICATION
if [ "$(id -u)" != "0" ]; then
    echo -e "\e[31m[*]\e[0m Please, run this script with sudo."
    exit 1
fi

# DISABLE KEYBOARD
stty -echo -icanon time 0 min 0

# OVERRIDE READ SO IT TEMPORARILY ENABLES INPUT ONLY WHEN CALLED
read() {
    stty sane
    builtin read "$@"
    stty -echo -icanon time 0 min 0
}

# OBTAIN THE INSTALLATION FOLDER
installation_folder=$(pwd)

# OBTAIN THE USER
echo -e "\e[33m[*]\e[0m This script will configure the system based on the provided user and the root user.\n"

while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m Please enter the name of the user to which the changes will be applied: ")" input_username
    if id "$input_username" &>/dev/null; then
        echo "$(id $input_username)"
        echo -e "\e[32m[*]\e[0m The user $input_username is valid.\n"
        
        while true; do
            read -p "$(echo -e "\e[33m[*]\e[0m Is $input_username the correct username? (YES/NO): ")" confirmation
            confirmation=$(echo "$confirmation" | tr '[:upper:]' '[:lower:]')
            
            if [ "$confirmation" = "yes" ] || [ "$confirmation" = "y" ]; then
                echo ""
                break 2
            elif [ "$confirmation" = "no" ] || [ "$confirmation" = "n" ]; then
                echo ""
                break 
            else
                echo -e "\e[31m[*]\e[0m Invalid response. Please reply 'YES' or 'NO'.\n"
            fi
        done
    else
        echo -e "\e[31m[*]\e[0m The user $input_username doesn't exist or is not valid.\n"
    fi
done

# SYSTEM UPDATE
while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m Do you want to run 'apt update' on the system? (YES/NO): ")" response
    response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

    if [ "$response" = "yes" ] || [ "$response" = "y" ]; then
        echo -e "\e[32m[*]\e[0m Running 'apt update' ...\n"
        apt update 
        break
    elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
        echo -e "\e[31m[*]\e[0m 'apt update' canceled.\n"
        break
    else
        echo -e "\e[31m[*]\e[0m Invalid response. Please reply 'YES' or 'NO'.\n"
    fi
done

# SYSTEM UPGRADE
while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m Do you want to perform a 'full-upgrade' on the system? (YES/NO): ")" response
    response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

    if [ "$response" = "yes" ] || [ "$response" = "y" ]; then
        echo -e "\e[32m[*]\e[0m Running 'apt full-upgrade' ...\n"
        apt full-upgrade -y 
        break
    elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
        echo -e "\e[31m[*]\e[0m 'apt full-upgrade' canceled.\n"
        break
    else
        echo -e "\e[31m[*]\e[0m Invalid response. Please reply 'YES' or 'NO'.\n"
    fi
done

# INSTALL THE NECESSARY DEPENDENCIES
echo -e "\e[32m[*]\e[0m Installing the necessary dependencies ...\n"
apt install imagemagick feh xclip bspwm sxhkd wmname fastfetch polybar betterlockscreen bat lsd fzf flameshot picom rofi kitty zsh jq pulseaudio-utils seclists bloodhound neo4j x11-utils moreutils -y

# REMOVE OLD CONFIGURATIONS
echo -e "\e[32m[*]\e[0m Removing old configurations ...\n"
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

# CREATE NEW CONFIGURATIONS
echo -e "\e[32m[*]\e[0m Creating new configurations ...\n"
mkdir /root/.config 
mkdir /home/$input_username/.config 

# CONFIGURING FONTS
echo -e "\e[32m[*]\e[0m Configuring fonts ...\n"
latest_version=$(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | grep "tag_name" | cut -d '"' -f 4)
wget https://github.com/ryanoasis/nerd-fonts/releases/download/$latest_version/Hack.zip -O Hack.zip 
unzip -o Hack.zip
mv -f *.ttf fonts/
cp -r fonts /usr/local/share 

# CONFIGURING WALLPAPERS
echo -e "\e[32m[*]\e[0m Configuring wallpapers ...\n"
cp -r Wallpapers /home/$input_username

# CONFIGURING BETTERLOCKSCREEN
echo -e "\e[32m[*]\e[0m Configuring betterlockscreen ...\n"
su $input_username -c "betterlockscreen -u /home/$input_username/Wallpapers/wallpaper.jpg"

# CONFIGURING SXHKD
echo -e "\e[32m[*]\e[0m Configuring sxhkd ...\n"
cp -r sxhkd /home/$input_username/.config

# CONFIGURING KITTY
echo -e "\e[32m[*]\e[0m Configuring kitty ...\n"
cp -r kitty /home/$input_username/.config
cp -r kitty /root/.config

# CONFIGURING PICOM
echo -e "\e[32m[*]\e[0m Configuring picom ...\n"
cp -r picom /home/$input_username/.config

# CONFIGURING PLUGIN SUDO ZSH
echo -e "\e[32m[*]\e[0m configuring zsh-sudo plugin ...\n"
cp -r zsh-sudo /usr/share

# CONFIGURING BSPWM
echo -e "\e[32m[*]\e[0m Configuring BSPWM ...\n"
cp -r bspwm /home/$input_username/.config
cd /home/$input_username/.config/bspwm 
chmod +x bspwmrc  
cd /home/$input_username/.config/bspwm/scripts 
chmod +x * 
cd "$installation_folder"

# CONFIGURING ROFI
echo -e "\e[32m[*]\e[0m Configuring rofi ...\n"
cp -r rofi /home/$input_username/.config 
cd /home/$input_username/.config/rofi  
cd launcher  
chmod +x launcher.sh 
cd ../powermenu 
chmod +x powermenu.sh
cd "$installation_folder"

# CONFIGURING POLYBAR
echo -e "\e[32m[*]\e[0m Configuring polybar ...\n"
chmod 755 bin/*
cp -r bin /usr
cp -r polybar /home/$input_username/.config
cd /home/$input_username/.config/polybar/scripts 
chmod +x *
mkdir /home/$input_username/.config/bin  
touch /home/$input_username/.config/bin/target  
cd "$installation_folder"

# CONFIGURING POWERLEVEL10K
echo -e "\e[32m[*]\e[0m Configuring powerlevel10k for user $input_username ...\n"
rm -rf /home/$input_username/powerlevel10k  
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /home/$input_username/powerlevel10k  
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>/home/$input_username/.zshrc  
mv zshrc .zshrc  
mv p10k.zsh .p10k.zsh  
cp .p10k.zsh /home/$input_username
cp .zshrc /home/$input_username

# CONFIGURING POWERLEVEL10K FOR ROOT
echo -e "\e[32m[*]\e[0m Configuring powerlevel10k for user root ...\n"
rm -rf /root/powerlevel10k  
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/powerlevel10k  
sh -c "echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> /root/.zshrc"  
cp .p10k.zsh /root 
cp .zshrc /root

# INSTALLATION AND CONFIGURATION FUNCTIONS
nvidia_drivers_installation(){
    while true; do
        read -p "$(echo -e "\e[33m[*]\e[0m Do you want to install the NVIDIA proprietary drivers? (YES/NO): ")" response
        response=$(echo "$response" | tr '[:upper:]' '[:lower:]')
      
        if [ "$response" = "yes" ] || [ "$response" = "y" ]; then
            echo -e "\e[32m[*]\e[0m Installing the NVIDIA proprietary drivers ...\n"
            apt install nvidia-detect nvidia-smi nvidia-driver nvidia-cuda-toolkit -y
            apt install $(apt-cache pkgnames | grep -E '^linux-headers-[0-9]+\.[0-9]+\.[0-9]+-amd64$' | sort -V | tail -n 1) -y
            break
        elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
            echo -e "\e[31m[*]\e[0m The NVIDIA proprietary drivers haven't been installed.\n"
            break
        else
            echo -e "\e[31m[*]\e[0m Invalid response. Please reply 'YES' or 'NO'.\n"
        fi
    done
}

fn_key_configuration(){
    while true; do
        read -p "$(echo -e "\e[33m[*]\e[0m Place the mouse pointer over the white window and enter the parameter that appears in the console for $1: ")" response
        echo "$response" >> /tmp/keys
        break
    done
}

replace_shortcut_sxhkdrc(){
    awk '!seen[$0]++' /tmp/keys | sponge /tmp/keys
    while IFS= read -r line; do
        sed -i "s/$1/$line/" /home/$input_username/.config/sxhkd/sxhkdrc
    done < /tmp/keys
    rm /tmp/keys
}

shortcuts_configuration(){
    while true; do
        read -p "$(echo -e "\e[33m[*]\e[0m Do you want to use the FN key or the WINDOWS key for keyboard shortcuts (it will be used to INCREASE/DECREASE VOLUME/BRIGHTNESS and to MUTE the SOUND)? (FN/WINDOWS): ")" response
        response=$(echo "$response" | tr '[:upper:]' '[:lower:]')
      
        if [ "$response" = "windows" ]; then
            echo -e "\e[32m[*]\e[0m Configuring Windows key ...\n"
            break
        elif [ "$response" = "fn" ]; then
            echo -e "\e[32m[*]\e[0m Configuring FN key ...\n"
            echo -e "\e[33m[*]\e[0m An output like this will appear (keysym 0x1008ff13, XF86AudioRaiseVolume) when you enter a key combination. You need to enter the third parameter, in this case, it is XF86AudioRaiseVolume. If you're using sxhkd, you must reload its configuration. If you installed BSPWM with this script, press WINDOWS + ESC"
            kitty --detach bash -c "xev | grep 'keysym'; exec bash"
            fn_key_configuration "turn up the volume"
            replace_shortcut_sxhkdrc "super + F7"
            fn_key_configuration "turn down the volume"
            replace_shortcut_sxhkdrc "super + F6"
            fn_key_configuration "mute and unmute the sound"
            replace_shortcut_sxhkdrc "super + F5"
            fn_key_configuration "turn up the brightness"
            replace_shortcut_sxhkdrc "super + F3"
            fn_key_configuration "turn down the brightness"
            replace_shortcut_sxhkdrc "super + F2"
            fn_key_configuration "turn on/off the color temperature"
            replace_shortcut_sxhkdrc "super + F8"
            fn_key_configuration "turn down the color temperature"
            replace_shortcut_sxhkdrc "super + F9"
            fn_key_configuration "turn up the color temperature"
            replace_shortcut_sxhkdrc "super + F10"
            echo -e "\e[33m[*]\e[0m You can now close the white window and the console where the output is displayed ...\n"
            break
        else
            echo -e "\e[31m[*]\e[0m Invalid response. Please reply 'YES' or 'NO'.\n"
        fi
    done
}

enable_bidirectional_clipboard(){
    while true; do
        read -p "$(echo -e "\e[33m[*]\e[0m Are you using VMware and want to enable bidirectional clipboard? (YES/NO): ")" response
        response=$(echo "$response" | tr '[:upper:]' '[:lower:]')
      
        if [ "$response" = "yes" ] || [ "$response" = "y" ]; then
            echo -e "\e[32m[*]\e[0m The bidirectional clipboard has been successfully configured.\n"
            break
        elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
            echo -e "\e[31m[*]\e[0m The bidirectional clipboard has not been enabled.\n"
            sed -i '/# bidirectional clipboard/,+2d' /home/$input_username/.config/bspwm/bspwmrc 
            break
        else
            echo -e "\e[31m[*]\e[0m Invalid response. Please reply 'YES' or 'NO'.\n"
        fi
    done
}

touchpad_configuration() {
    while true; do
        read -p "$(echo -e "\e[33m[*]\e[0m Do you want to disable the touchpad by default? (YES/NO): ")" response
        response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

        if [ "$response" = "yes" ] || [ "$response" = "y" ]; then
            echo -e "\e[32m[*]\e[0m Configuring the touchpad ...\n"
            apt install xinput -y
            touchpad=$(xinput list | grep -i touchpad)
            if [[ -n "$touchpad" ]]; then
                id_touchpad=$(echo "$touchpad" | awk -F'id=' '{print $2}' | awk '{print $1}')
                sed -i '/# fix java error/i # touchpad' /home/$input_username/.config/bspwm/bspwmrc
                sed -i "/# fix java error/i\touchpad=\$(xinput list | grep -i touchpad)" /home/$input_username/.config/bspwm/bspwmrc
                sed -i "/# fix java error/i touchpad_file=\$(cat /home/$input_username/.config/bin/touchpad)" /home/$input_username/.config/bspwm/bspwmrc
                sed -i "/# fix java error/i\touchpad_id=\$(echo \"\$touchpad\" | awk -F'id=' '{print \$2}' | awk '{print \$1}')" /home/$input_username/.config/bspwm/bspwmrc
                sed -i '/# fix java error/i if [ "$touchpad_file" = "Disabled" ]; then' /home/$input_username/.config/bspwm/bspwmrc
                sed -i '/# fix java error/i\    xinput disable $touchpad_id' /home/$input_username/.config/bspwm/bspwmrc
                sed -i '/# fix java error/i fi' /home/$input_username/.config/bspwm/bspwmrc
                sed -i '/# fix java error/i\\' /home/$input_username/.config/bspwm/bspwmrc
                touch /home/$input_username/.config/bin/touchpad
                echo 'Disabled' > /home/$input_username/.config/bin/touchpad
            else
                echo -e "\e[31m[*]\e[0m No touchpad was found.\n"
            fi
            break
        elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
            echo -e "\e[31m[*]\e[0m The touchpad has not been disabled.\n"
            sed -i '/# touchpad/,+7d' /home/$input_username/.config/bspwm/bspwmrc
            break
        else
            echo -e "\e[31m[*]\e[0m Invalid response. Please reply 'YES' or 'NO'.\n"
        fi
    done
}

laptop_and_desktop_configuration(){
    while true; do
        read -p "$(echo -e "\e[33m[*]\e[0m Are you using a desktop computer? (YES/NO): ")" response
        response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

        if [ "$response" = "yes" ] || [ "$response" = "y" ]; then
            echo -e "\e[32m[*]\e[0m Configuring the system for a desktop ...\n"
            remove_laptop_configuration
            break
        elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
            echo -e "\e[32m[*]\e[0m Configuring the system for a laptop ...\n"
            shortcuts_configuration
            touchpad_configuration
            dunst_installation
            redshift_installation
            break
        else
            echo -e "\e[31m[*]\e[0m Invalid response. Please reply 'YES' or 'NO'.\n"
        fi
      done
    sed -i '/# bidirectional clipboard/,+2d' /home/$input_username/.config/bspwm/bspwmrc
    apt install brightnessctl -y
}

redshift_installation(){
    echo -e "\e[32m[*]\e[0m Configuring redshift ...\n"
    apt install redshift -y
    touch /home/$input_username/.config/bin/color_temperature_kelvin
    touch /home/$input_username/.config/bin/color_temperature_percentage
    touch /home/$input_username/.config/bin/redshift_status
    echo 'Off' > /home/$input_username/.config/bin/redshift_status
    echo '100' > /home/$input_username/.config/bin/color_temperature_percentage
    echo '6500' > /home/$input_username/.config/bin/color_temperature_kelvin
}

dunst_installation(){
    echo -e "\e[32m[*]\e[0m Configuring dunst ...\n"
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
    cd "$installation_folder"
}

nvim_installation(){
    echo -e "\e[32m[*]\e[0m Installing nvim ..."
    rm -rf /root/.config/nvim 
    rm -rf /opt/*nvim*  
    rm -rf /home/$input_username/.config/nvim 
    apt install npm -y  
    latest_version=$(curl -s "https://api.github.com/repos/neovim/neovim/releases/latest" | grep "browser_download_url.*nvim-linux-x86_64.tar.gz" | cut -d : -f 2,3 | tr -d '," ')
    wget $latest_version -O nvim-linux-x86_64.tar.gz 
    tar -xf nvim-linux-x86_64.tar.gz
    mv nvim-linux-x86_64 nvim
    mv -f nvim /opt  
    chown -R root:root /opt/nvim

    echo -e "\e[32m[*]\e[0m Installing nvchad ..."
    mkdir /home/$input_username/.config/nvim  
    mkdir /root/.config/nvim  
    git clone https://github.com/NvChad/starter /home/$input_username/.config/nvim  
    git clone https://github.com/NvChad/starter /root/.config/nvim

    echo -e "\e[32m[*]\e[0m Creating symbolic link in nvim configuration files ..."
    ln -s -f /home/$input_username/.config/nvim /root/.config/nvim  
}

vscode_installation(){
    echo -e "\e[32m[*]\e[0m Installing vscode ...\n"
    latest_version=$(curl -s https://api.github.com/repos/microsoft/vscode/releases/latest | grep "tag_name" | cut -d '"' -f 4)
    wget "https://update.code.visualstudio.com/$latest_version/linux-deb-x64/stable" -O vscode-latest-version.deb
    apt install ./vscode-latest-version.deb  
}

caido_installation(){
    echo -e "\e[32m[*]\e[0m Installing caido ..."
    latest_version=$(curl -s "https://caido.download/releases/latest" | jq -r '.links[] | select(.platform == "linux-x86_64" and .kind == "desktop" and .format == "deb") | .link')
    wget $latest_version -O caido-latest-version.deb
    apt install ./caido-latest-version.deb  

    while true; do
        read -p "$(echo -e "\e[33m[*]\e[0m Do you want it to be your default proxy? (YES/NO): ")" response
        response=$(echo "$response" | tr '[:upper:]' '[:lower:]')
      
        if [ "$response" = "yes" ] || [ "$response" = "y" ]; then
            echo -e "\e[32m[*]\e[0m Configuring caido as your proxy ..."
            sed -i 's/burpsuite/caido/g' /home/$input_username/.config/sxhkd/sxhkdrc
            break
        elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
            echo -e "\e[31m[*]\e[0m Caido won't be your proxy ...\n"
            break
        else
            echo -e "\e[31m[*]\e[0m Invalid response. Please reply 'YES' or 'NO'.\n"
        fi
    done
}

burpsuite_professional_installation(){
    echo -e "\e[32m[*]\e[0m Installing burpsuite professional para el usuario root..."
    apt install git axel openjdk-21-jre -y
    rm -rf /opt/*Burpsuite-Professional*  
    cd /opt
    git clone https://github.com/xiv3r/Burpsuite-Professional.git 
    cd Burpsuite-Professional
    latest_version=$(curl -s https://portswigger.net/burp/releases/community/latest -L | grep -oP 'version=\K[0-9]+\.[0-9]+\.[0-9]+' | head -1)
    axel "https://portswigger-cdn.net/burp/releases/download?product=pro&type=Jar" -o "burpsuite_pro_v$latest_version.jar"
    (java -jar loader.jar) &
    echo "java --add-opens=java.desktop/javax.swing=ALL-UNNAMED --add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm.Opcodes=ALL-UNNAMED -javaagent:$(pwd)/loader.jar -noverify -jar $(pwd)/burpsuite_pro_v$version.jar &" > burpsuitepro
    chmod +x burpsuitepro
    cp burpsuitepro /bin/burpsuitepro
    (./burpsuitepro)

    while true; do
        read -p "$(echo -e "\e[33m[*]\e[0m Have you finished configuring burpsuite professional for root (enter YES once you have closed the windows)? (YES/NO): ")" response
        response=$(echo "$response" | tr '[:upper:]' '[:lower:]')
      
        if [ "$response" = "yes" ] || [ "$response" = "y" ]; then
            break
        elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
            echo -e "\e[31m[*]\e[0m You must configure burpsuite professional first ...\n"
            break
        else
            echo -e "\e[31m[*]\e[0m Invalid response. Please reply 'YES' or 'NO'.\n"
        fi
    done

    echo -e "\e[32m[*]\e[0m Installing burpsuite professional para el usuario $input_username..."
    su $input_username -c "bash /opt/Burpsuite-Professional/install.sh"
    cd "$installation_folder"    
    rm /opt/Burpsuite-Professional/burp_suite.ico
    cp burpsuite-professional.desktop /usr/share/applications
    cp icon.png /opt/Burpsuite-Professional
    cp icon.ico /opt/Burpsuite-Professional

    while true; do
        read -p "$(echo -e "\e[33m[*]\e[0m Do you want it to be your default proxy? (YES/NO): ")" response
        response=$(echo "$response" | tr '[:upper:]' '[:lower:]')
      
        if [ "$response" = "yes" ] || [ "$response" = "y" ]; then
            echo -e "\e[32m[*]\e[0m Configuring burpsuite professional as your proxy ..."
            sed -i -e 's/burpsuite/burpsuitepro/g' -e 's/caido/burpsuitepro/g' /home/$input_username/.config/sxhkd/sxhkdrc            
            break
        elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
            echo -e "\e[31m[*]\e[0m Burpsuite professional won't be your proxy ...\n"
            break
        else
            echo -e "\e[31m[*]\e[0m Invalid response. Please reply 'YES' or 'NO'.\n"
        fi
    done
}

rpcenum_installation(){
    echo -e "\e[32m[*]\e[0m Installing rpcEnum ...\n"
    wget https://raw.githubusercontent.com/Justice-Reaper/rpcEnum/refs/heads/main/rpcEnum.sh
    chmod +x rpcEnum.sh
    mv rpcEnum.sh rpcEnum
    mv -f rpcEnum /usr/bin
}

graphql_converter_installation(){
    echo -e "\e[32m[*]\e[0m Installing graphQLConverter ...\n"
    wget https://raw.githubusercontent.com/Justice-Reaper/graphQLConverter/refs/heads/main/graphQLConverter.py
    chmod +x graphQLConverter.py
    mv graphQLConverter.py graphQLConverter
    mv -f graphQLConverter /usr/bin
}

pycharm_community_installation(){
    echo -e "\e[32m[*]\e[0m Installing pycharm community ..."
    rm -rf /opt/Pycharm-Community
    latest_version=$(curl -s "https://data.services.jetbrains.com/products/releases?code=PCC&latest=true" | grep -o '"version":"[^"]*"' | head -1 | cut -d'"' -f4)
    download_url=$(curl -s "https://data.services.jetbrains.com/products/releases?code=PCC&latest=true" | grep -o '"linux":{"link":"[^"]*"' | head -1 | cut -d'"' -f6)    
    wget $download_url -O pycharm-community.tar.gz
    mkdir /opt/Pycharm-Community
    tar -xzf pycharm-community.tar.gz -C /opt/Pycharm-Community --strip-components=1
}

postman_installation(){
    echo -e "\e[32m[*]\e[0m Installing postman ..."
    rm -rf /opt/*Postman*  
    wget https://dl.pstmn.io/download/latest/linux64 -O postman.tar.gz
    mkdir /opt/Postman
    tar -xzf postman.tar.gz -C /opt/Postman --strip-components=1
    cp postman.desktop /usr/share/applications
}

kerbrute_installation(){
    echo -e "\e[32m[*]\e[0m Installing kerbrute ..."
    latest_version=$(curl -s https://api.github.com/repos/ropnop/kerbrute/releases/latest | jq -r '.assets[] | select(.name | contains("linux_amd64")) | .browser_download_url')
    wget $latest_version -O kerbrute_linux_amd64
    chmod +x kerbrute_linux_amd64
    mv kerbrute_linux_amd64 kerbrute
    mv -f kerbrute /usr/bin
}

windapsearch_installation(){
    echo -e "\e[32m[*]\e[0m Installing windapsearch ..."
    latest_version=$(curl -s https://api.github.com/repos/ropnop/go-windapsearch/releases/latest | jq -r '.assets[] | select(.name == "windapsearch-linux-amd64") | .browser_download_url')
    wget $latest_version -O windapsearch_linux_amd64
    chmod +x windapsearch_linux_amd64
    mv windapsearch_linux_amd64 windapsearch
    mv -f windapsearch /usr/bin
    echo -e "\e[32m[*]\e[0m Windapsearch installed successfully."
}

tor_installation(){
    echo -e "\e[32m[*]\e[0m Installing tor ..."
    rm -rf /home/$input_username/Browser
    latest_version=$(curl -s 'https://dist.torproject.org/torbrowser/' | grep -oP '(?<=href=")[0-9]+\.[0-9]+\.[0-9]+(?=/)' | sort -V | tail -n1)
    wget "https://dist.torproject.org/torbrowser/${latest_version}/tor-browser-linux-x86_64-${latest_version}.tar.xz" -O tor-browser.tar.xz
    tar -xf tor-browser.tar.xz -C /home/$input_username --strip-components=1
    rm /home/$input_username/start-tor-browser.desktop
    rm /home/$input_username/Browser/start-tor-browser.desktop
    mkdir -p /home/$input_username/.local/share/applications
    cp tor-browser.desktop /home/$input_username/.local/share/applications
    chmod 700 /home/$input_username/.local/share/applications/tor-browser.desktop
    sed -i "s/user_replace/$input_username/g" /home/$input_username/.local/share/applications/tor-browser.desktop

    while true; do
        read -p "$(echo -e "\e[33m[*]\e[0m Do you want it to be your default browser? (YES/NO): ")" response
        response=$(echo "$response" | tr '[:upper:]' '[:lower:]')
      
        if [ "$response" = "yes" ] || [ "$response" = "y" ]; then
            echo -e "\e[32m[*]\e[0m Configuring tor as your default browser ..."
            sed -i 's/# firefox/# tor/g' /home/$input_username/.config/sxhkd/sxhkdrc
            sed -i 's/firefox/tor-browser/g' /home/$input_username/.config/sxhkd/sxhkdrc
            break
        elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
            echo -e "\e[31m[*]\e[0m Tor won't be your default browser..\n"
            sed -i '/# tor/,+2d' /home/$input_username/.zshrc
            sed -i '/# tor/,+2d' /root/.zshrc
            break
        else
            echo -e "\e[31m[*]\e[0m Invalid response. Please reply 'YES' or 'NO'.\n"
        fi
    done
}

chrome_installation(){
    echo -e "\e[32m[*]\e[0m Installing google chrome ..."
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O google-chrome-stable_current_amd64.deb 
    apt install ./google-chrome-stable_current_amd64.deb

    while true; do
        read -p "$(echo -e "\e[33m[*]\e[0m Do you want it to be your default browser? (YES/NO): ")" response
        response=$(echo "$response" | tr '[:upper:]' '[:lower:]')
      
        if [ "$response" = "yes" ] || [ "$response" = "y" ]; then
            echo -e "\e[32m[*]\e[0m Configuring chrome as your default browser ..."
            sed -i -e 's/# firefox/# chrome/g' -e 's/# tor/# chrome/g' /home/$input_username/.config/sxhkd/sxhkdrc
            sed -i -e 's/firefox/google-chrome/g' -e 's/tor-browser/google-chrome/g' /home/$input_username/.config/sxhkd/sxhkdrc
            break
        elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
            echo -e "\e[31m[*]\e[0m Chrome won't be your default browser..\n"
            break
        else
            echo -e "\e[31m[*]\e[0m Invalid response. Please reply 'YES' or 'NO'.\n"
        fi
    done
}

grub_timeout_customization(){
    while true; do
        read -p "$(echo -e "\e[33m[*]\e[0m Enter the number of seconds GRUB will be displayed (if you enter -1, it will remain until manually selected): ")" response
        response=$(echo "$response" | tr '[:upper:]' '[:lower:]')
      
        if [[ "$response" =~ ^-?[0-9]+$ ]]; then
            echo -e "\e[32m[*]\e[0m Configuring the GRUB_TIMEOUT variable..."
            sed -i "s/^GRUB_TIMEOUT=.*/GRUB_TIMEOUT=$response/" /etc/default/grub 
            break
        else
            echo -e "\e[31m[*]\e[0m Invalid response. Please enter a valid number. Example: -1, 5, 15.\n"
        fi
    done
}

grub_theme_customization(){
    while true; do
        read -p "$(echo -e "\e[33m[*]\e[0m Do you want to use the classic black and white grub? (YES/NO): ")" response
        response=$(echo "$response" | tr '[:upper:]' '[:lower:]')
      
        if [ "$response" = "yes" ] || [ "$response" = "y" ]; then
            echo -e "\e[32m[*]\e[0m Configuring the classic grub..."
            sed -i '/^#GRUB_TERMINAL=console/s/^#//' /etc/default/grub
            
            if ! grep -q "set menu_color_normal=white/black" /etc/grub.d/40_custom; then
                sed -i '$a set menu_color_normal=white/black' /etc/grub.d/40_custom
            fi
            
            if ! grep -q "set menu_color_highlight=black/white" /etc/grub.d/40_custom; then
                sed -i '$a set menu_color_highlight=black/white' /etc/grub.d/40_custom
            fi
            
            update-grub
            
            break
        elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
            echo -e "\e[31m[*]\e[0m The grub theme won't be modified.\n"
            break
        else
            echo -e "\e[31m[*]\e[0m Invalid response. Please reply 'YES' or 'NO'.\n"
        fi
    done
}

warning(){
    while true; do
        read -p "$(echo -e "\e[33m[*]\e[0m If you are running the AutoBSPWM script from a desktop environment other than BSPWM, you need to restart. If you are already using BSPWM, no restart is needed. Do you want to restart? (YES/NO): ")" response
        response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

       if [ "$response" = "yes" ] || [ "$response" = "y" ]; then
           reboot
           break
       elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
           echo -e "\e[31m[*]\e[0m The restart will not be performed. If you have done a clean installation, just updated the packages, and are on a laptop, the touchpad may not be detected (restart if you want to disable it by default). If you're not in a BSPWM environment, you won't be able to configure the FN key instead of the WINDOWS key in the keyboard shortcuts.\n"
           break
       else
           echo -e "\e[31m[*]\e[0m Invalid response. Please reply 'YES' or 'NO'.\n"
       fi
    done
}

remove_laptop_configuration(){
    echo -e "\e[32m[*]\e[0m Configuring polybar ...\n"
    sed -i '/\[module\/brightness\]/{x;d;};x' /home/$input_username/.config/polybar/config.ini 
    sed -i '/\[module\/brightness\]/,$d' /home/$input_username/.config/polybar/config.ini 
    sed -i 's/battery //' /home/$input_username/.config/polybar/config.ini 
    sed -i 's/brightness //' /home/$input_username/.config/polybar/config.ini 
    sed -i 's/battery_notification //' /home/$input_username/.config/polybar/config.ini 
    sed -i 's/color_temperature //' /home/$input_username/.config/polybar/config.ini 
    rm /home/$input_username/.config/polybar/scripts/increase_brightness.sh 
    rm /home/$input_username/.config/polybar/scripts/decrease_brightness.sh 
    rm /home/$input_username/.config/polybar/scripts/brightness_control.sh
    rm /home/$input_username/.config/polybar/scripts/color_temperature_control.sh

    echo -e "\e[32m[*]\e[0m Configuring zsh ...\n"
    sed -i '/function enableTouchpad()/ {x;d}; x' /home/$input_username/.zshrc
    sed -i '/function enableTouchpad(){/,+12d' /home/$input_username/.zshrc 

    echo -e "\e[32m[*]\e[0m Configuring BSPWM ...\n"
    sed -i '/# dunst/,+2d' /home/$input_username/.config/bspwm/bspwmrc  
    sed -i '/# brightness/,+6d' /home/$input_username/.config/bspwm/bspwmrc

    echo -e "\e[32m[*]\e[0m Configuring sxhkdrc ...\n"
    sed -i '/# increase brightness/,+19d' /home/$input_username/.config/sxhkd/sxhkdrc 
}

# VIRTUAL MACHINE OR BARE METAL CHOICE
while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m Are you using a virtual machine? (YES/NO): ")" response
    response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

    if [ "$response" = "yes" ] || [ "$response" = "y" ]; then
        echo -e "\e[32m[*]\e[0m Configuring the system for a virtual machine...\n"
        echo -e "\e[32m[*]\e[0m Configuring picom ...\n"
        sed -i 's/^\(round-borders = 15;\)/# \1/' /home/$input_username/.config/picom/picom.conf
        sed -i 's/^\(corner-radius = 15;\)/# \1/' /home/$input_username/.config/picom/picom.conf
        sed -i '/backend = "glx"/d' /home/$input_username/.config/picom/picom.conf
        sed -i '/^vsync = true$/d' /home/$input_username/.config/picom/picom.conf   

        remove_laptop_configuration
        enable_bidirectional_clipboard
        break
    elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
        echo -e "\e[32m[*]\e[0m The system is being configured for a bare metal system...\n"
        sed -i '/backend = "xrender"/d' /home/$input_username/.config/picom/picom.conf
        sed -i "s/user_replace/$input_username/g" sound/scripts/*   
        cp -r sound /home/$input_username/.config
        sed -i "s/user_replace/$input_username/g" 99-usb-sound.rules
        cp 99-usb-sound.rules /etc/udev/rules.d
        chmod +x /home/$input_username/.config/sound/scripts/*

        warning
        laptop_and_desktop_configuration
        nvidia_drivers_installation
        break
    else
        echo -e "\e[31m[*]\e[0m Invalid response. Please reply 'YES' or 'NO'.\n"
    fi
done

# GRUB CUSTOMIZATION
while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m Do you want to customize grub? (YES/NO): ")" response
    response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

   if [ "$response" = "yes" ] || [ "$response" = "y" ]; then
        grub_timeout_customization
        grub_theme_customization
        update-grub
        break
   elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
        echo -e "\e[31m[*]\e[0m Grub won't be modified.\n"
        break
    else
        echo -e "\e[31m[*]\e[0m Invalid response. Please reply 'YES' or 'NO'.\n"
    fi
done

# OBSIDIAN
while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m Do you want to install OBSIDIAN? (YES/NO): ")" response
    response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

    if [ "$response" = "yes" ] || [ "$response" = "y" ]; then
        apt install obsidian -y
        break
    elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
        echo -e "\e[31m[*]\e[0m obsidian hasn't been installed.\n"
        sed -i '/# obsidian/,+3d' /home/$input_username/.config/sxhkd/sxhkdrc
        break
    else
        echo -e "\e[31m[*]\e[0m Invalid response. Please reply 'YES' or 'NO'.\n"
    fi
done

# KERBRUTE
while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m Do you want to install KERBRUTE? (YES/NO): ")" response
    response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

    if [ "$response" = "yes" ] || [ "$response" = "y" ]; then
        kerbrute_installation
        break
    elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
        echo -e "\e[31m[*]\e[0m kerbrute hasn't been installed.\n"
        break
    else
        echo -e "\e[31m[*]\e[0m Invalid response. Please reply 'YES' or 'NO'.\n"
    fi
done

# WINDAPSEARCH
while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m Do you want to install WINDAPSEARCH? (YES/NO): ")" response
    response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

    if [ "$response" = "yes" ] || [ "$response" = "y" ]; then
        windapsearch_installation
        break
    elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
        echo -e "\e[31m[*]\e[0m Windapsearch hasn't been installed.\n"
        break
    else
        echo -e "\e[31m[*]\e[0m Invalid response. Please reply 'YES' or 'NO'.\n"
    fi
done

# RPCENUM
while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m Do you want to install RPCENUM? (YES/NO): ")" response
    response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

    if [ "$response" = "yes" ] || [ "$response" = "y" ]; then
        rpcenum_installation
        break
    elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
        echo -e "\e[31m[*]\e[0m rpcEnum hasn't been installed.\n"
        break
    else
        echo -e "\e[31m[*]\e[0m Invalid response. Please reply 'YES' or 'NO'.\n"
    fi
done

# GRAPHQL CONVERTER
while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m Do you want to install GRAPHQL CONVERTER? (YES/NO): ")" response
    response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

    if [ "$response" = "yes" ] || [ "$response" = "y" ]; then
        graphql_converter_installation
        break
    elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
        echo -e "\e[31m[*]\e[0m graphQLConverter hasn't been installed.\n"
        break
    else
        echo -e "\e[31m[*]\e[0m Invalid response. Please reply 'YES' or 'NO'.\n"
    fi
done

# TOR
while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m Do you want to install TOR? (YES/NO): ")" response
    response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

    if [ "$response" = "yes" ] || [ "$response" = "y" ]; then
        tor_installation
        break
    elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
        echo -e "\e[31m[*]\e[0m Tor hasn't been installed.\n"
        break
    else
        echo -e "\e[31m[*]\e[0m Invalid response. Please reply 'YES' or 'NO'.\n"
    fi
done

# CHROME
while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m Do you want to install GOOGLE CHROME? (YES/NO): ")" response
    response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

    if [ "$response" = "yes" ] || [ "$response" = "y" ]; then
        chrome_installation
        break
    elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
        echo -e "\e[31m[*]\e[0m Chrome hasn't been installed.\n"
        break
    else
        echo -e "\e[31m[*]\e[0m Invalid response. Please reply 'YES' or 'NO'.\n"
    fi
done

# POSTMAN
while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m Do you want to install POSTMAN? (YES/NO): ")" response
    response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

    if [ "$response" = "yes" ] || [ "$response" = "y" ]; then
        postman_installation
        break
    elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
        echo -e "\e[31m[*]\e[0m Postman hasn't been installed.\n"
        sed -i '/# postman/,+3d' /home/$input_username/.config/sxhkd/sxhkdrc
        sed -i '/# postman/,+2d' /home/$input_username/.zshrc
        sed -i '/# postman/,+2d' /root/.zshrc
        break
    else
        echo -e "\e[31m[*]\e[0m Invalid response. Please reply 'YES' or 'NO'.\n"
    fi
done

# NVIM
while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m Do you want to install NVIM? (YES/NO): ")" response
    response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

    if [ "$response" = "yes" ] || [ "$response" = "y" ]; then
        nvim_installation
        break
    elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
        echo -e "\e[31m[*]\e[0m Nvim hasn't been installed.\n"
        sed -i '/# nvim/,+2d' /home/$input_username/.zshrc
        sed -i '/# nvim/,+2d' /root/.zshrc
        break
    else
        echo -e "\e[31m[*]\e[0m Invalid response. Please reply 'YES' or 'NO'.\n"
    fi
done

# VSCODE
while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m Do you want to install VSCODE? (YES/NO): ")" response
    response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

    if [ "$response" = "yes" ] || [ "$response" = "y" ]; then
        vscode_installation
        break
    elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
        echo -e "\e[31m[*]\e[0m Vscode hasn't been installed.\n"
        sed -i '/# vscode/,+3d' /home/$input_username/.config/sxhkd/sxhkdrc
        break
    else
        echo -e "\e[31m[*]\e[0m Invalid response. Please reply 'YES' or 'NO'.\n"
    fi
done

# CAIDO
while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m Do you want to install CAIDO? (YES/NO): ")" response
    response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

    if [ "$response" = "yes" ] || [ "$response" = "y" ]; then
        caido_installation
        break
    elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
        echo -e "\e[31m[*]\e[0m Caido hasn't been installed.\n"
        break
    else
        echo -e "\e[31m[*]\e[0m Invalid response. Please reply 'YES' or 'NO'.\n"
    fi
done

# BURPSUITE PROFESSIONAL
while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m Do you want to install BURPSUITE PROFESSIONAL? (YES/NO): ")" response
    response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

    if [ "$response" = "yes" ] || [ "$response" = "y" ]; then
        burpsuite_professional_installation
        break
    elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
        echo -e "\e[31m[*]\e[0m Burpsuite professional hasn't been installed.\n"
        sed -i '/# burpsuitepro/,+2d' /home/$input_username/.zshrc
        break
    else
        echo -e "\e[31m[*]\e[0m Invalid response. Please reply 'YES' or 'NO'.\n"
    fi
done

# PYCHARM COMMUNITY
while true; do
    read -p "$(echo -e "\e[33m[*]\e[0m Do you want to install PYCHARM COMMUNITY? (YES/NO): ")" response
    response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

    if [ "$response" = "yes" ] || [ "$response" = "y" ]; then
        pycharm_community_installation
        break
    elif [ "$response" = "no" ] || [ "$response" = "n" ]; then
        sed -i '/# pycharm/,+2d' /home/$input_username/.zshrc
        sed -i '/# pycharm/,+2d' /root/.zshrc
        sed -i '/# pycharm/,+3d' /home/$input_username/.config/sxhkd/sxhkdrc
        echo -e "\e[31m[*]\e[0m Pycharm community hasn't been installed.\n"
        break
    else
        echo -e "\e[31m[*]\e[0m Invalid response. Please reply 'YES' or 'NO'.\n"
    fi
done

# REPLACE USER_REPLACE WITH THE SELECTED USER
echo -e "\e[32m[*]\e[0m Configuring files...\n"
sed -i "s/user_replace/$input_username/g" /home/$input_username/.config/polybar/config.ini
sed -i "s/user_replace/$input_username/g" /home/$input_username/.config/polybar/scripts/*  
sed -i "s/user_replace/$input_username/g" /home/$input_username/.config/bspwm/bspwmrc  
sed -i "s/user_replace/$input_username/g" /home/$input_username/.config/sxhkd/sxhkdrc
sed -i "s/user_replace/$input_username/g" /home/$input_username/.p10k.zsh  
sed -i "s/user_replace/$input_username/g" /home/$input_username/.zshrc  

# REPLACE THE BATTERY AND POWER ADAPTER
battery="$(ls -1 /sys/class/power_supply | grep "BA" | cut -d'/' -f8-)"
adapter="$(ls -1 /sys/class/power_supply | grep "AC" | cut -d'/' -f8-)"
sed -i "s/battery_replace/$battery/g" "/home/$input_username/.config/polybar/config.ini"  
sed -i "s/adapter_replace/$adapter/g" "/home/$input_username/.config/polybar/config.ini"  

# CREATE A SYMBOLIC LINK BETWEEN THE CONFIGURATION FILES OF THE CHOSEN USER'S KITTY AND THOSE OF ROOT
echo -e "\e[32m[*]\e[0m Creating symbolic link in kitty.conf and kitty.color ...\n"
ln -s -f /home/$input_username/.config/kitty /root/.config/kitty

# CREATE A SYMBOLIC LINK BETWEEN THE CHOSEN USER'S ZSHRC AND ROOT'S ZSHRC
echo -e "\e[32m[*]\e[0m Creating symbolic link in the zshrc ...\n"
ln -s -f /home/$input_username/.zshrc /root/.zshrc

# CREATE A SYMBOLIC LINK BETWEEN THE CHOSEN USER'S P10K AND ROOT'S P10K
echo -e "\e[32m[*]\e[0m Creating symbolic link in the p10k.zsh file ...\n"
ln -s -f /home/$input_username/.p10k.zsh /root/.p10k.zsh

# ASSIGN THE CORRECT OWNER TO THE FILES
echo -e "\e[32m[*]\e[0m Assigning the correct owner to the configuration files ...\n"
chown -R $input_username:$input_username /home/$input_username

# REMOVE UNNECESSARY PACKAGES
echo -e "\e[32m[*]\e[0m Removing unnecessary apt packages ...\n"
apt autoremove -y  

# REMOVE CACHE FILES
echo -e "\e[32m[*]\e[0m Limpiando caché de paquetes apt ...\n"
apt clean -y

# BSPWM ENVIRONMENT CONFIGURED SUCCESSFULLY
echo -e "\e[32m[*]\e[0m the BSPWM environment has been successfully installed!\n"
echo -e "\e[32m[*]\e[0m it is recommended to restart/log in again for the configuration to load correctly\n"

# ENALBE KEYBOARD
stty sane
