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

[![Thanks for all your support](https://img.buymeacoffee.com/button-api/?text=Thanks%20for%20all%20your%20support&emoji=☕&slug=justiceReaper&button_colour=FF5F5F&font_colour=ffffff&font_family=Lato&outline_colour=000000&coffee_colour=FFDD00)](https://www.buymeacoffee.com/justiceReaper)

# Installation
```
git clone https://github.com/Justice-Reaper/AutoBspwmKali.git    
cd AutoBspwmKali/  
chmod +x AutoBSPWM.sh  
sudo ./AutoBSPWM.sh  
```

## Overview
![Preview 1](/preview/preview-1.png)

![Preview 2](/preview/preview-2.png)

![Preview 3](/preview/preview-3.png)

![Preview 4](/preview/preview-4.png)

![Preview 5](/preview/preview-5.png)

## Componentes:
- **redshift**: Tool to adjust the screen’s color temperature  
- **dunst**: Notification daemon that reports battery status (charging, full charge, and low battery)  
- **bloodhound**: Tool for mapping relationships and privileges in Active Directory  
- **neo4j**: Graph database that stores and queries data using nodes, relationships, and properties  
- **obsidian**: Lightweight Markdown-based note-taking tool  
- **seclists**: Collection of wordlists for pentesting  
- **imagemagick**: Software suite to create, edit, or convert images from the command line  
- **rpcEnum**: Tool to enumerate MSRPC services
- **graphQLConverter**: Tool to convert GraphQL JSON to x-www-form-urlencoded format
- **payloadSplitter**: Tool to split large files into smaller chunks with customizable sizes
- **getTopPorts**: Tool that extracts the most common ports from Nmap and saves them to a text file in two different formats
- **postman**: Collaborative tool for developing, testing, and documenting APIs, with powerful enumeration and debugging features  
- **pycharm**: Python IDE
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
- **bat**: Enhanced cat clone with syntax highlighting and other features  
- **lsd**: Modern replacement for ls with improved visuals and usability  
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
- **clearTarget**: Clears the target in the polybar
- **disableTouchpad**: Disables the touchpad  
- **enableTouchpad**: Enables the touchpad
- **extractPorts**: Extracts ports obtained through nmap and copies them to the clipboard
- **mkt**: Creates the necessary working directories for performing a pentest
- **setTarget**: Sets the target in the polybar
- **setWallpaper**: Configures the desktop wallpaper
- **ipRangeGenerator**: Generates IP address ranges  
- **showHelpPanel**: Displays all commands and shortcuts of the environment

## Bspwm Shortcuts
<kbd>Windows</kbd> + <kbd>(1,2,3,4,5,6,7,8,9,0)</kbd> : Switch between workspaces  

<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>R</kbd> : Reload bspwm configuration  

<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>Q</kbd> : Log out of bspwm  

<kbd>Ctrl</kbd> + <kbd>Windows</kbd> + <kbd>Alt</kbd> + <kbd>(⬆⬅⬇➡)</kbd> : Activate preselectors (Requires an open window)   
<kbd>Ctrl</kbd> + <kbd>Windows</kbd> + <kbd>Alt</kbd> + <kbd>(1,2,3,4,5,6,7,8,9,0)</kbd> : Control preselector ratio (Requires an open window)  
<kbd>Preselectors activated</kbd> + <kbd>Ctrl</kbd> + <kbd>Windows</kbd> + <kbd>Alt</kbd> + <kbd>(Space)</kbd> : Cancel preselection  

## Sxhkd Shortcuts
<kbd>Windows</kbd> + <kbd>Esc</kbd> : Reload sxhkd configuration    

## Polybar Shortcuts
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>F1</kbd> : Copy local machine IP address  
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>F2</kbd> : Copy VPN IP address  
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>F3</kbd> : Copy target IP address    

<kbd>Windows/FN</kbd> + <kbd>F2</kbd> : Turn down the brightness  
<kbd>Windows/FN</kbd> + <kbd>F3</kbd> : Turn up the brightness  

<kbd>Windows/FN</kbd> + <kbd>F5</kbd> : Mute and unmute the sound  
<kbd>Windows/FN</kbd> + <kbd>F6</kbd> : Turn down the volume  
<kbd>Windows/FN</kbd> + <kbd>F7</kbd> : Turn up the volume    

<kbd>Windows/FN</kbd> + <kbd>F8</kbd> : Turn on/off the color temperature    
<kbd>Windows/FN</kbd> + <kbd>F9</kbd> : Turn down the color temperature  
<kbd>Windows/FN</kbd> + <kbd>F10</kbd> : Turn up the color temperature    

<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>D</kbd> : Open Rofi launcher  
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> : Open Rofi power menu  

## Window Shortcuts
<kbd>Windows</kbd> + <kbd>Alt</kbd> + <kbd>(⬆⬅⬇➡)</kbd>: Resize normal windows  

<kbd>Windows</kbd> + <kbd>W</kbd> : Close the current window  

<kbd>Windows</kbd> + <kbd>S</kbd>: Create floating windows    
<kbd>Windows</kbd> + <kbd>Right click</kbd>: Resize floating windows  
<kbd>Windows</kbd> + <kbd>Left click</kbd>: Move floating window  

<kbd>Windows</kbd> + <kbd>T</kbd> : Change the current window to "terminal" mode (normal). This is useful when the window is in fullscreen or floating mode    
<kbd>Windows</kbd> + <kbd>M</kbd> : Change the current window to "full" mode (does not occupy the polybar). Press the same keys to return to "terminal" mode (normal)    
<kbd>Windows</kbd> + <kbd>F</kbd> : Change the current window to fullscreen mode (occupies the whole screen, including the polybar)  

<kbd>Windows</kbd> + <kbd>(⬆⬅⬇➡)</kbd> : Navigate through windows in the current workspace
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>(1,2,3,4,5,6,7,8,9,0)</kbd> : Move window to another workspace  

## Kitty Shortcuts
<kbd>Windows</kbd> + <kbd>Enter</kbd> : Open console (kitty-terminal)

<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>T</kbd> : Create tab  
<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>(⬆⬅⬇➡)</kbd> : Navigate through tabs  
<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>T</kbd> : Rename tabs

<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>Enter</kbd> : Open subterminal  
<kbd>Ctrl</kbd> + <kbd>(⬆⬅⬇➡)</kbd> : Navigate through subterminals  
<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>R</kbd> : Activate resize mode on a subterminal  
<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>Z</kbd> : Zoom in on a subterminal  
<kbd>Kitty resize mode activated</kbd> + <kbd>W</kbd> : Increase width on a subterminal   
<kbd>Kitty resize mode activated</kbd> + <kbd>N</kbd> : Decrease width on a subterminal  
<kbd>Kitty resize mode activated</kbd> + <kbd>T</kbd> : Increase height on a subterminal    
<kbd>Kitty resize mode activated</kbd> + <kbd>S</kbd> : Decrease height on a subterminal  
<kbd>Kitty resize mode activated</kbd> + <kbd>Ctrl</kbd> + <kbd>W</kbd> : Double the width on a subterminal  
<kbd>Kitty resize mode activated</kbd> + <kbd>Ctrl</kbd> + <kbd>N</kbd> : Halve the width on a subterminal  
<kbd>Kitty resize mode activated</kbd> + <kbd>Ctrl</kbd> + <kbd>T</kbd> : Double the height on a subterminal  
<kbd>Kitty resize mode activated</kbd> + <kbd>Ctrl</kbd> + <kbd>S</kbd> : Halve the height on a subterminal  
<kbd>Kitty resize mode activated</kbd> + <kbd>Esc</kbd> : Exit resize mode on a subterminal 

<kbd>F1</kbd> : Copy content to the first clipboard  
<kbd>F2</kbd> : Paste content from the first clipboard  
<kbd>F3</kbd> : Copy content to the second clipboard  
<kbd>F4</kbd> : Paste content from the second clipboard

## Zsh Shortcuts
<kbd>Alt</kbd> + <kbd>.</kbd>: Insert the argument from the previous command    

<kbd>Alt</kbd> + <kbd>(⬆⬅⬇➡)</kbd>: Move between words    
<kbd>Home</kbd>: Move to the beginning of the line    
<kbd>End</kbd>: Move to the end of the line   

<kbd>Ctrl</kbd> + <kbd>U</kbd>: Delete from cursor to beginning  
<kbd>Ctrl</kbd> + <kbd>K</kbd>: Delete from cursor to end  
<kbd>Ctrl</kbd> + <kbd>W</kbd>: Delete the entire line  

<kbd>Alt</kbd> + <kbd>Del</kbd>: Delete the word to the right of the cursor    
<kbd>Alt</kbd> + <kbd>Backspace</kbd>: Delete the word to the left of the cursor    

<kbd>Del</kbd>: Delete the character to the right of the cursor  
<kbd>Backspace</kbd>: Delete the character to the left of the cursor   

<kbd>Page Up</kbd>: Scroll up in paginate mode    
<kbd>Page Down</kbd>: Scroll down in paginate mode   

<kbd>Shift</kbd> + <kbd>Tab</kbd>: Undo the last action    
 
<kbd>Ctrl</kbd> + <kbd>R</kbd>: Use fzf to autocomplete files/directories    
<kbd>Ctrl</kbd> + <kbd>R</kbd>: Use fzf to run commands from the zsh history    

<kbd>Esc</kbd> + <kbd>Esc</kbd>: Add sudo at the beginning of the line and if there is no text, add sudo followed by the last executed command  

## Rofi Shortcuts
<kbd>Alt</kbd> + <kbd>(⬆⬅⬇➡)</kbd>: Move between words    
<kbd>Home</kbd>: Move to the beginning of the line    
<kbd>End</kbd>: Move to the end of the line   

<kbd>Ctrl</kbd> + <kbd>U</kbd>: Delete from cursor to beginning  
<kbd>Ctrl</kbd> + <kbd>K</kbd>: Delete from cursor to end  
<kbd>Ctrl</kbd> + <kbd>W</kbd>: Delete the entire line  

<kbd>Alt</kbd> + <kbd>Del</kbd>: Delete the word to the right of the cursor    
<kbd>Alt</kbd> + <kbd>Backspace</kbd>: Delete the word to the left of the cursor    

<kbd>Del</kbd>: Delete the character to the right of the cursor
<kbd>Backspace</kbd>: Delete the character to the left of the cursor    

<kbd>Esc</kbd> : Exit Rofi  

## Application Shortcuts
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>A</kbd> : Open Postman    
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>O</kbd> : Open Obsidian    
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>S</kbd> : Open Pycharm    
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>F</kbd> : Open Browser  
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>B</kbd> : Open Proxy  
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>V</kbd> : Open VSCode  
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>G</kbd> : Open Thunar file manager   
<kbd>PrtSc</kbd> : Take a screenshot with Flameshot  

## Commands
<kbd>setTarget</kbd>: This function in zsh sets the target in the polybar    
<kbd>clearTarget</kbd>: This function in zsh clears the target from the polybar    

<kbd>clearHistory</kbd>: Clear the zsh history    
<kbd>removeHistory</kbd>: Remove the zsh history    

<kbd>enableTouchpad</kbd>: Enable the laptop's touchpad    
<kbd>disableTouchpad</kbd>: Disable the laptop's touchpad  

<kbd>setWallpaper</kbd>: Set a wallpaper    

<kbd>extractPorts</kbd>: Extract ports from a file in nmap -oG format and copy them to the clipboard    

<kbd>mkt</kbd>: Create a folder and several work directories inside it  

<kbd>showHelpPanel</kbd> : Displays all commands and shortcuts of the desktop environment
  
## Credits
Author: Justice-Reaper    
Inspiration: Environment shown in the hack4u academy by s4vitar  
