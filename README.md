# AutoBSPWM
Simplifica la configuración de BSPWM con scripts y herramientas predefinidas para una experiencia optimizada. Instalación fácil y gestión eficiente de ventanas y atajos. ¡Potencia tu entorno BSPWM en segundos!

Se ha testeado este script en ParrotOS, Kali y Ubuntu.
Funciona para todos los sistemas operativos basados en Debian.

# Instalación
```
git clone https://github.com/Justice-Reaper/AutoBSPWM.git
cd AutoBSPWM/
chmod +x AutoBSPWM.sh
./AutoBSPWM.sh
```
## Vista general
![BSPWM](/Preview/image_1.png "autoBSPWM by justice-reaper")

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

## Shortcuts (atajos de teclado)
<kbd>Windows</kbd> + <kbd>Enter</kbd> : Abrir la consola (kitty-terminal).  
<kbd>Windows</kbd> + <kbd>W</kbd> : Cerrar la ventana actual.  
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>R</kbd> : Reiniciar la configuración del bspwm.  
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>Q</kbd> : Cerrar sesión.  
<kbd>Windows</kbd> + <kbd>(⬆⬅⬇➡)</kbd> : Moverse por las ventanas en la workspace actual.  
<kbd>Windows</kbd> + <kbd>(1,2,3,4,5,6,7,8,9,0)</kbd> : Cambiar el workspace.  
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>D</kbd> : Abrir el Rofi. 
<kbd>Esc</kbd> Salir del rofi.  
<kbd>Windows</kbd> + <kbd>F7</kbd> : Subir el volumen.    
<kbd>Windows</kbd> + <kbd>F6</kbd> : Bajar el volumen.    
<kbd>Windows</kbd> + <kbd>F3</kbd> : Subir el brillo.    
<kbd>Windows</kbd> + <kbd>F2</kbd> : Bajar el brillo.    
<kbd>Windows</kbd> + <kbd>Esc</kbd> : Reiniciar la configuración del sxhkd.    
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>R</kbd> : Reiniciar la configuración del bspwm.
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>(1,2,3,4,5,6,7,8,9,0)</kbd> : Desplazar ventana a otro espacio del workspace.
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>F</kbd> : Abrir el firefox.
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>B</kbd> : Abrir el burpsuite.
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>E</kbd> : Abrir el editor de código.
<kbd>Impr Pa</kbd> : Hacer captura de pantalla.
<kbd>Ctrl</kbd> + <kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>(⬆⬅⬇➡)</kbd>: Preselectores en la consola (kitty-terminal).
<kbd>Ctrl</kbd> + <kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>(Space)</kbd>: Cancelar preselección (kitty-terminal).
<kbd>Windows</kbd> + <kbd>S</kbd>: Crear ventanas flotantes.
<kbd>Windows</kbd> + <kbd>Right click</kbd>: Resizear ventanas flotantes.
<kbd>Windows</kbd> + <kbd>Alt</kbd> + <kbd>(⬆⬅⬇➡)</kbd>: Resizear ventanas flotantes.
<kbd>Windows</kbd> + <kbd>Left click</kbd>: Mover ventanas flotantes.











<kbd>Windows</kbd> + <kbd>T</kbd> : Cambiar la ventana actual a modo "terminal" (normal). Nos sirve cuando la ventana está en modo pantalla completa o flotante.  
<kbd>Windows</kbd> + <kbd>M</kbd> : Cambiar la ventana actual a modo "completo" (no ocupa la polybar). Presione la mismas teclas para volver a modo "terminal" (normal).  
<kbd>Windows</kbd> + <kbd>F</kbd> : Cambiar la ventana actual a modo pantalla completa (ocupa todo incluyendo la polybar).  
<kbd>Windows</kbd> + <kbd>S</kbd> : Cambiar la ventana actual a modo "flotante".  
<kbd>Windows</kbd> + <kbd>Alt</kbd> + <kbd>(1,2,3,4,5,6,7,8,9,0)</kbd> : Mover la ventana actual a otro workspace.  
<kbd>Windows</kbd> + <kbd>Alt</kbd> + <kbd>(⬆⬅⬇➡)</kbd> : Cambiar el tamaño de la ventana actual (solo funciona si está en modo terminal o flotante).  
<kbd>Windows</kbd> + <kbd>Ctrl</kbd> + <kbd>(⬆⬅⬇➡)</kbd> : Cambiar la posición de la ventana actual (solo funciona en modo flotante).  
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>G</kbd> : Abrir Google Chrome (es necesario instalarlo primero).  
<kbd>Windows</kbd> + <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>(⬆⬅⬇➡)</kbd> : Mostrar una preselección para luego abrir una ventana (una terminal, Google Chrome, un archivo, etc.). <kbd>Windows</kbd> + <kbd>Ctrl</kbd> + <kbd>Space</kbd> para deshacer la preselección.  

## Créditos
- Autor: justice-reaper
- Inspirado en el entorno mostrado en la academia de hack4u de s4vitar
