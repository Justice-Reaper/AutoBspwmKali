# AutoBSPWM
Este script AutoBSPWM ha sido creado por investigación propia utilizando como base el curso de personalización de linux de la academia de Hack4u https://hack4u.io/cursos/personalizacion-de-entorno-en-linux/  
Ha sido testeado en kali linux, se desconoce si puede acarrear problemas en otros sistemas operativos  
Si tienes alguna duda o deseas que implemente alguna nueva funcionalidad no dudes en consultarme  

# Instalación
```
git clone https://github.com/Justice-Reaper/AutoBSPWM.git  
cd AutoBSPWM/  
chmod +x AutoBSPWM.sh  
./AutoBSPWM.sh  
```

## Vista general
![Preview Entorno BSPWM](/Preview/image.png "autoBSPWM by justice-reaper")

## Utilidades:
- **imagemagick**:  Suite de software para crear, editar o convertir imágenes desde la línea de comandos.
- **brightnessctl**: Herramienta para controlar el brillo de la pantalla desde la línea de comandos.
- **feh**: Visor de imágenes ligero, configurable y versátil.
- **xclip**: Utilidad para manejar el portapapeles en entornos de línea de comandos.
- **bspwm**: Gestor de ventanas de mosaico.
- **sxhkd**: "Demonio" que escucha los eventos del teclado y ejecuta comandos.
- **wmname**: Utilidad para cambiar el nombre de la ventana del gestor de ventanas.
- **polybar**: Herramienta para crear barras de estado personalizadas.
- **betterlockscreen**: Permite personalizar y bloquear la pantalla con fondos de pantalla y efectos personalizados.
- **bat**: Clon mejorado de cat con resaltado de sintaxis y otras características.
- **lsd**: Reemplazo moderno del comando ls con mejoras visuales y de usabilidad.
- **fzf**: Buscador difuso de línea de comandos de propósito general.
- **flameshot**: Herramienta de captura de pantalla con capacidades de anotación y edición.
- **picom**: Compositor para X11 con efectos visuales y transparencias para ventanas.
- **rofi**: Selector de ventana y lanzador de aplicaciones.
- **kitty**: Emulador de terminal altamente configurable y de alto rendimiento.
- **zsh**: Shell de Unix interactiva y potente.
- **VSCode**: Editor de código fuente altamente personalizable desarrollado por Microsoft.
- **nvim**: Editor de texto extremadamente configurable y poderoso, una versión mejorada del clásico Vim.

## Shortcuts de Ventanas
<kbd>Windows</kbd> + <kbd>S</kbd>: Crear ventanas flotantes.  
<kbd>Windows</kbd> + <kbd>Right click</kbd>: Resizear ventanas flotantes.  
<kbd>Windows</kbd> + <kbd>Alt</kbd> + <kbd>(⬆⬅⬇➡)</kbd>: Resizear ventanas.  
<kbd>Windows</kbd> + <kbd>Left click</kbd>: Mover ventanas flotantes.  
<kbd>Windows</kbd> + <kbd>T</kbd> : Cambiar la ventana actual a modo "terminal" (normal). Nos sirve cuando la ventana está en modo pantalla completa o flotante.    
<kbd>Windows</kbd> + <kbd>M</kbd> : Cambiar la ventana actual a modo "completo" (no ocupa la polybar). Presione la mismas teclas para volver a modo "terminal" (normal).    
<kbd>Windows</kbd> + <kbd>F</kbd> : Cambiar la ventana actual a modo pantalla completa (ocupa todo incluyendo la polybar). 
<kbd>Windows</kbd> + <kbd>W</kbd> : Cerrar la ventana actual.  
<kbd>Windows</kbd> + <kbd>(⬆⬅⬇➡)</kbd> : Moverse por las ventanas en la workspace actual.  

## Shortcuts de Workspaces
<kbd>Windows</kbd> + <kbd>(1,2,3,4,5,6,7,8,9,0)</kbd> : Cambiar de workspace.  
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>(1,2,3,4,5,6,7,8,9,0)</kbd> : Desplazar ventana a otro espacio del workspace.  

## Shortcuts de Bspwm y Sxhkd
<kbd>Windows</kbd> + <kbd>Esc</kbd> : Reiniciar la configuración del sxhkd.    
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>R</kbd> : Reiniciar la configuración del bspwm.  
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>Q</kbd> : Cerrar sesión de bspwm.  

## Shortcuts de Volumen y Brillo
<kbd>Windows</kbd> + <kbd>F7</kbd> : Subir el volumen.  
<kbd>Windows</kbd> + <kbd>F6</kbd> : Bajar el volumen.  
<kbd>Windows</kbd> + <kbd>F3</kbd> : Subir el brillo.  
<kbd>Windows</kbd> + <kbd>F2</kbd> : Bajar el brillo.  

## Shortcuts de Aplicaciones
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>F</kbd> : Abrir el firefox.  
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>B</kbd> : Abrir el burpsuite.  
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>E</kbd> : Abrir el editor de código. 
<kbd>Impr Pa</kbd> : Hacer captura de pantalla. 
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>D</kbd> : Abrir el rofi launcher.  
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> : Abrir el rofi powermenu.  
<kbd>Esc</kbd> Salir del rofi.  

## Shortcuts de la Kitty
<kbd>Windows</kbd> + <kbd>Enter</kbd> : Abrir la consola (kitty-terminal).  
<kbd>Ctrl</kbd> + <kbd>Windows</kbd> + <kbd>Alt</kbd> + <kbd>(⬆⬅⬇➡)</kbd>: Preselectores en la kitty.  
<kbd>Ctrl</kbd> + <kbd>Windows</kbd> + <kbd>Alt</kbd> + <kbd>(1,2,3,4,5,6,7,8,9,0)</kbd>: Controlar el ratio de los preselectores en la kitty.  
<kbd>Ctrl</kbd> + <kbd>Windows</kbd> + <kbd>Alt</kbd> + <kbd>(Space)</kbd>: Cancelar preselección (kitty-terminal). 
<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>Enter</kbd>: Abrir subterminal dentro de la kitty.  
<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>T</kbd>: Crear tab en la kitty.  
<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>(⬆⬅⬇➡)</kbd>: Desplazarse por los tabs de la kitty.  
<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>T</kbd>: Cambiar el nombre de los tabs de la kitty.  
<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>R</kbd>: Activar resize de la kitty.  
<kbd>Resize kitty activado</kbd> + <kbd>W</kbd>: Aumentar el ancho de la kitty.  
<kbd>Resize kitty activado</kbd> + <kbd>N</kbd>: Disminuir el ancho de la kitty.  
<kbd>Resize kitty activado</kbd> + <kbd>T</kbd>: Aumentar la altura de la kitty.  
<kbd>Resize kitty activado</kbd> + <kbd>S</kbd>: Disminuir la altura de la kitty.   
<kbd>Resize kitty activado</kbd>+ <kbd>Ctrl</kbd> + <kbd>W</kbd>: Aumentar el ancho de la kitty el doble.  
<kbd>Resize kitty activado</kbd>+ <kbd>Ctrl</kbd> + <kbd>N</kbd>: Disminuir el ancho de la kitty el doble.  
<kbd>Resize kitty activado</kbd>+ <kbd>Ctrl</kbd> + <kbd>T</kbd>: Aumentar la altura de la kitty el doble.  
<kbd>Resize kitty activado</kbd> + <kbd>Ctrl</kbd> + <kbd>S</kbd>: Disminuir la altura de la kitty el doble.  
<kbd>Resize kitty activado</kbd> + <kbd>Esc</kbd>: Salir del modo resize de la kitty.  
<kbd>Ctrl</kbd> + <kbd>(⬆⬅⬇➡)</kbd>: Desplazarse por las subterminales de la kitty.  

## Shortcuts de la Zsh
<kbd>Ctrl</kbd> + <kbd>R</kbd>: Mediante fzf nos autocompleta los archivos/directorios.  
<kbd>Ctrl</kbd> + <kbd>R</kbd>: Mediante fzf podemos ejecutar comandos del histórico de la zsh.  
<kbd>Esc</kbd> + <kbd>Esc</kbd>: Se activa el plugin sudo-zsh y nos añade sudo al principio del comando en la kitty.  
<kbd>Settarget</kbd>: Mediante esta función en la zsh seteamos el target en la polybar.  
<kbd>Cleartarget</kbd>: Mediante esta función en la zsh limpiamos el target de la polybar.  
<kbd>Mkt</kbd>: Se crean varios directorios de trabajo.  

## Créditos
- Autor: justice-reaper
- Inspirado en el entorno mostrado en la academia de hack4u de s4vitar
- Para los keybindings me he inspirado en el autoBSPWM de yorkox0 https://github.com/yorkox0/autoBspwm/tree/main
