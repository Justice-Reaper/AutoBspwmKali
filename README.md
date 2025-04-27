# AutoBSPWM  
- This AutoBSPWM script was created through independent research, based on the Linux customization course from the Hack4u academy: https://hack4u.io/cursos/personalizacion-de-entorno-en-linux/  

- This AutoBSPWM script has been tested on both bare metal Kali Linux and virtual machines  

- On a bare metal system, you'll have sound notifications when connecting or disconnecting USB devices, as well as brightness and volume controls. For battery management, you’ll receive custom notifications for full charge, low battery, and charging status  

- This bspwm environment is designed to work with the XFCE desktop environment  

- Installation options: bare metal desktop PC, bare metal laptop, and virtual machine  

- Whenever you want to update any of the environment’s components, you can simply run the script again. It will remove the old components and install the updated ones  

- If you have any questions or would like me to implement a new feature, feel free to reach out  

# Donations
Would you like to support the continued development of this project? You can contribute with a small donation by clicking the button below

[![Thank you for your support !!! ☕](https://img.buymeacoffee.com/button-api/?text=Gracias%20por%20tu%20apoyo%20!!!&emoji=☕&slug=justiceReaper&button_colour=FF5F5F&font_colour=ffffff&font_family=Cookie&outline_colour=000000&coffee_colour=FFDD00)](https://www.buymeacoffee.com/justiceReaper)

# Installation
```
git clone https://github.com/Justice-Reaper/AutoBspwmKali.git    
cd AutoBspwmKali/  
chmod +x AutoBSPWM.sh  
sudo ./AutoBSPWM.sh  
```

## Overview
![BSPWM Environment Preview](/Preview/preview.png)

## Componentes:
- **redshift**: Tool to adjust the screen’s color temperature  
- **dunst**: Notification daemon that reports battery status (charging, full charge, and low battery)  
- **bloodhound**: Tool for mapping relationships and privileges in Active Directory  
- **neo4j**: Graph database that stores and queries data using nodes, relationships, and properties  
- **obsidian**: Lightweight Markdown-based note-taking tool  
- **seclists**: Collection of wordlists for pentesting  
- **imagemagick**: Software suite to create, edit, or convert images from the command line  
- **rpcEnum**: Tool to enumerate MSRPC services  
- **postman**: Collaborative tool for developing, testing, and documenting APIs, with powerful enumeration and debugging features  
- **jetbrains tools**: Set of integrated development tools for various programming languages  
- **kerbrute**: Brute-force tool to enumerate valid users via Kerberos  
- **windapsearch**: Lightweight tool to enumerate data on LDAP servers  
- **brightnessctl**: Tool to control screen brightness from the command line  
- **feh**: Lightweight, configurable, and versatile image viewer  
- **xclip**: Utility for clipboard management in command-line environments  
- **bspwm**: Tiling window manager  
- **sxhkd**: Daemon that listens for keyboard events and executes commands  
- **wmname**: Utility to change the window manager's window name  
- **polybar**: Tool to create customizable status bars  
- **betterlockscreen**: Lets you lock and customize your screen with wallpapers and visual effects  
- **bat**: Enhanced `cat` clone with syntax highlighting and other features  
- **lsd**: Modern replacement for `ls` with improved visuals and usability  
- **fzf**: General-purpose command-line fuzzy finder  
- **flameshot**: Screenshot tool with annotation and editing capabilities  
- **picom**: X11 compositor with visual effects and window transparency  
- **rofi**: Window switcher and application launcher  
- **kitty**: Highly configurable and high-performance terminal emulator  
- **zsh**: Powerful and interactive Unix shell  
- **vscode**: Highly customizable source code editor developed by Microsoft  
- **nvim**: Extremely configurable and powerful text editor, an enhanced version of classic Vim  
- **npm**: Package manager that simplifies managing dependencies and modules in projects  
- **nvchad**: A set of pre-configured settings and plugins for Neovim to enhance the user experience

## Shortcuts IP's
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>F1</kbd> : Copy local machine IP address  
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>F2</kbd> : Copy VPN IP address  
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>F3</kbd> : Copy target IP address    

## Window Shortcuts
<kbd>Windows</kbd> + <kbd>S</kbd>: Create floating windows    
<kbd>Windows</kbd> + <kbd>Right click</kbd>: Resize floating windows  
<kbd>Windows</kbd> + <kbd>Alt</kbd> + <kbd>(⬆⬅⬇➡)</kbd>: Resize windows  
<kbd>Windows</kbd> + <kbd>Left click</kbd>: Move floating window  
<kbd>Windows</kbd> + <kbd>T</kbd> : Change the current window to "terminal" mode (normal). This is useful when the window is in fullscreen or floating mode    
<kbd>Windows</kbd> + <kbd>M</kbd> : Change the current window to "full" mode (does not occupy the polybar). Press the same keys to return to "terminal" mode (normal)    
<kbd>Windows</kbd> + <kbd>F</kbd> : Change the current window to fullscreen mode (occupies the whole screen, including the polybar) 
<kbd>Windows</kbd> + <kbd>W</kbd> : Close the current window  
<kbd>Windows</kbd> + <kbd>(⬆⬅⬇➡)</kbd> : Navigate through windows in the current workspac  

## Workspace Shortcuts
<kbd>Windows</kbd> + <kbd>(1,2,3,4,5,6,7,8,9,0)</kbd> : Switch between workspaces  
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>(1,2,3,4,5,6,7,8,9,0)</kbd> : Move window to another workspace  

## Bspwm and Sxhkd Shortcuts
<kbd>Windows</kbd> + <kbd>Esc</kbd> : Reload sxhkd configuration    
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>R</kbd> : Reload bspwm configuration  
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>Q</kbd> : Log out of bspwm  

## Volume, Color Temperature and Brightness Shortcuts
<kbd>Windows/FN</kbd> + <kbd>F2</kbd> : Turn down the brightness  
<kbd>Windows/FN</kbd> + <kbd>F3</kbd> : Turn up the brightness  
<kbd>Windows/FN</kbd> + <kbd>F5</kbd> : Mute and unmute the sound  
<kbd>Windows/FN</kbd> + <kbd>F6</kbd> : Turn down the volume  
<kbd>Windows/FN</kbd> + <kbd>F7</kbd> : Turn up the volume    
<kbd>Windows/FN</kbd> + <kbd>F8</kbd> : Turn on/off the color temperature    
<kbd>Windows/FN</kbd> + <kbd>F9</kbd> : Turn down the color temperature  
<kbd>Windows/FN</kbd> + <kbd>F10</kbd> : Turn up the color temperature    

## Application Shortcuts
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>A</kbd> : Open Postman    
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>O</kbd> : Open Obsidian    
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>S</kbd> : Open Pycharm    
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>F</kbd> : Open Firefox/Chrome  
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>B</kbd> : Open Burpsuite  
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>V</kbd> : Open VSCode  
<kbd>PrtSc</kbd> : Take a screenshot  
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>D</kbd> : Open Rofi launcher  
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> : Open Rofi power menu  
<kbd>Esc</kbd> : Exit Rofi  
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>G</kbd> : Open Thunar file manager
  
## Kitty Shortcuts
<kbd>Windows</kbd> + <kbd>Enter</kbd> : Open console (kitty-terminal)  
<kbd>Ctrl</kbd> + <kbd>Windows</kbd> + <kbd>Alt</kbd> + <kbd>(⬆⬅⬇➡)</kbd> : Preselectors in Kitty  
<kbd>Ctrl</kbd> + <kbd>Windows</kbd> + <kbd>Alt</kbd> + <kbd>(1,2,3,4,5,6,7,8,9,0)</kbd> : Control preselector ratio in Kitty  
<kbd>Ctrl</kbd> + <kbd>Windows</kbd> + <kbd>Alt</kbd> + <kbd>(Space)</kbd> : Cancel preselection (kitty-terminal)  
<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>Enter</kbd> : Open subterminal inside Kitty  
<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>T</kbd> : Create tab in Kitty  
<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>(⬆⬅⬇➡)</kbd> : Navigate through tabs in Kitty  
<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>T</kbd> : Rename tabs in Kitty  
<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>R</kbd> : Activate resize mode in Kitty  
<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>Z</kbd> : Zoom in on a subterminal in Kitty  
<kbd>Resize Kitty activated</kbd> + <kbd>W</kbd> : Increase width of Kitty  
<kbd>Resize Kitty activated</kbd> + <kbd>N</kbd> : Decrease width of Kitty  
<kbd>Resize Kitty activated</kbd> + <kbd>T</kbd> : Increase height of Kitty  
<kbd>Resize Kitty activated</kbd> + <kbd>S</kbd> : Decrease height of Kitty  
<kbd>Resize Kitty activated</kbd> + <kbd>Ctrl</kbd> + <kbd>W</kbd> : Double the width of Kitty  
<kbd>Resize Kitty activated</kbd> + <kbd>Ctrl</kbd> + <kbd>N</kbd> : Halve the width of Kitty  
<kbd>Resize Kitty activated</kbd> + <kbd>Ctrl</kbd> + <kbd>T</kbd> : Double the height of Kitty  
<kbd>Resize Kitty activated</kbd> + <kbd>Ctrl</kbd> + <kbd>S</kbd> : Halve the height of Kitty  
<kbd>Resize Kitty activated</kbd> + <kbd>Esc</kbd> : Exit resize mode in Kitty  
<kbd>Ctrl</kbd> + <kbd>(⬆⬅⬇➡)</kbd> : Navigate through subterminals in Kitty  
<kbd>F1</kbd> : Copy content to the first clipboard in Kitty  
<kbd>F2</kbd> : Paste content from the first clipboard in Kitty  
<kbd>F3</kbd> : Copy content to the second clipboard in Kitty  
<kbd>F4</kbd> : Paste content from the second clipboard in Kitty
 
## Zsh Shortcuts
<kbd>Alt</kbd> + <kbd>.</kbd>: Insert the argument from the previous command    
<kbd>Ctrl</kbd> + <kbd>U</kbd>: Delete the entire line    
<kbd>Alt</kbd> + <kbd>Del</kbd>: Delete a word    
<kbd>Alt</kbd> + <kbd>(⬆⬅⬇➡)</kbd>: Move between words    
<kbd>Del</kbd>: Delete the character to the right of the cursor    
<kbd>Backspace</kbd>: Delete the character to the left of the cursor    
<kbd>Alt</kbd> + <kbd>Del</kbd>: Delete the word to the right of the cursor    
<kbd>Alt</kbd> + <kbd>Backspace</kbd>: Delete the word to the left of the cursor    
<kbd>Home</kbd>: Move to the beginning of the line    
<kbd>End</kbd>: Move to the end of the line    
<kbd>Shift</kbd> + <kbd>Tab</kbd>: Undo the last action    
<kbd>Page Up</kbd>: Scroll up in paginate mode    
<kbd>Page Down</kbd>: Scroll down in paginate mode    
<kbd>Ctrl</kbd> + <kbd>R</kbd>: Use fzf to autocomplete files/directories    
<kbd>Ctrl</kbd> + <kbd>R</kbd>: Use fzf to run commands from the zsh history    
<kbd>Esc</kbd> + <kbd>Esc</kbd>: Activates the sudo-zsh plugin and adds sudo at the beginning of the command in kitty    
<kbd>setTarget</kbd>: This function in zsh sets the target in the polybar    
<kbd>clearTarget</kbd>: This function in zsh clears the target from the polybar    
<kbd>mkt</kbd>: Create a folder and several work directories inside it    
<kbd>clearHistory</kbd>: Clear the zsh history    
<kbd>removeHistory</kbd>: Remove the zsh history    
<kbd>extractPorts</kbd>: Extract ports from a file in nmap -oG format and copy them to the clipboard    
<kbd>enableTouchpad</kbd>: Enable the laptop's touchpad    
<kbd>disableTouchpad</kbd>: Disable the laptop's touchpad  

## Credits
Author: Justice-Reaper    
Inspiration: Environment shown in the hack4u academy by s4vitar  
