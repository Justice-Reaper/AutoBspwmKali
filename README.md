# AutoBSPWM
- Este script AutoBSPWM ha sido creado por investigación propia utilizando como base el curso de personalización de linux de la academia de Hack4u https://hack4u.io/cursos/personalizacion-de-entorno-en-linux/
  
- Este script AutoBSPWM ha sido sido testeado en kali linux nativo y máquina virtual

- Con el sistema nativo dispondremos de sonido al insertar y extraer dispositivos usb, así como controladores para el brillo y sonido. Para la batería dispondremos de notificaciones personalizadas de carga completa, batería baja y sobre el estado de carga

- Este entorno bspwm está diseñado para funcionar con el entorno de escritorio XFCE

- Opciones de instalación: Equipo de escritorio nativo, portátil nativo y máquina virtual
  
- Cada vez que se desee actualizar cualquiera de los componentes del entorno puedes ejecutar el script y se eliminarán los componentes antiguos y se instalarán los componentes actualizados
  
- Si tienes alguna duda o deseas que implemente alguna nueva funcionalidad no dudes en consultarme

# Donaciones

¿Quieres ayudarme a seguir mejorando este proyecto? Puedes apoyarme con una pequeña donación pulsando en este botón

[![Gracias por el apoyo !!! ☕](https://img.buymeacoffee.com/button-api/?text=Gracias%20por%20el%20apoyo%20!!!&emoji=☕&slug=justiceReaper&button_colour=FF5F5F&font_colour=ffffff&font_family=Cookie&outline_colour=000000&coffee_colour=FFDD00)](https://www.buymeacoffee.com/justiceReaper)

# Instalación
```
git clone https://github.com/Justice-Reaper/AutoBspwmKali.git    
cd AutoBspwmKali/  
chmod +x AutoBSPWM.sh  
sudo ./AutoBSPWM.sh  
```

## Vista general
![Preview Entorno BSPWM](/Preview/image.png "autoBSPWM by justice-reaper")

## Componentes:
- **dunst**: Demonio de notificaciones que informará del estado de la batería (cargando, carga completa y batería baja)
- **bloodhound**: Herramienta para mapear relaciones y privilegios en Active Directory
- **neo4j**: Base de datos de grafos que almacena y consulta datos mediante nodos, relaciones y propiedades
- **obsidian**: Herramienta ligera para la toma de notas basada en Markdown
- **seclists**: Colección de diccionarios para pentesting
- **imagemagick**: Suite de software para crear, editar o convertir imágenes desde la línea de comandos
- **rpcEnum**: Herramienta para enumerar servicios MSRPC
- **postman**: Herramienta colaborativa para desarrollar, probar y documentar APIs, con potentes herramientas de enumeración y depuración
- **jetbrains tools**: Conjunto de herramientas de desarrollo integradas para diferentes lenguajes de programación
- **kerbrute**: Herramienta de fuerza bruta para enumerar usuarios válidos mediante kerberos
- **windapsearch**: Herramienta ligera para enumerar datos en servidores LDAP
- **brightnessctl**: Herramienta para controlar el brillo de la pantalla desde la línea de comandos
- **feh**: Visor de imágenes ligero, configurable y versátil
- **xclip**: Utilidad para manejar el portapapeles en entornos de línea de comandos
- **bspwm**: Gestor de ventanas de mosaico
- **sxhkd**: "Demonio" que escucha los eventos del teclado y ejecuta comandos
- **wmname**: Utilidad para cambiar el nombre de la ventana del gestor de ventanas
- **polybar**: Herramienta para crear barras de estado personalizadas
- **betterlockscreen**: Permite personalizar y bloquear la pantalla con fondos de pantalla y efectos personalizados
- **bat**: Clon mejorado de cat con resaltado de sintaxis y otras características
- **lsd**: Reemplazo moderno del comando ls con mejoras visuales y de usabilidad
- **fzf**: Buscador difuso de línea de comandos de propósito general
- **flameshot**: Herramienta de captura de pantalla con capacidades de anotación y edición
- **picom**: Compositor para X11 con efectos visuales y transparencias para ventanas
- **rofi**: Selector de ventana y lanzador de aplicaciones
- **kitty**: Emulador de terminal altamente configurable y de alto rendimiento
- **zsh**: Shell de Unix interactiva y potente
- **vscode**: Editor de código fuente altamente personalizable desarrollado por Microsoft
- **nvim**: Editor de texto extremadamente configurable y poderoso, una versión mejorada del clásico Vim
- **npm**: Administrador de paquetes que simplifica la gestión de dependencias y módulos en proyectos
- **nvchad**: Un conjunto de configuraciones y complementos preconfigurados para Neovim, que mejora la experiencia de uso de este potente editor de texto

## Shortcuts IP's
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>F1</kbd> : Copiar dirección ip del equipo local  
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>F2</kbd> : Copiar dirección ip de la vpn  
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>F3</kbd> : Copiar dirección ip del target  

## Shortcuts de Ventanas
<kbd>Windows</kbd> + <kbd>S</kbd>: Crear ventanas flotantes  
<kbd>Windows</kbd> + <kbd>Right click</kbd>: Resizear ventanas flotantes  
<kbd>Windows</kbd> + <kbd>Alt</kbd> + <kbd>(⬆⬅⬇➡)</kbd>: Resizear ventanas  
<kbd>Windows</kbd> + <kbd>Left click</kbd>: Mover ventanas flotantes  
<kbd>Windows</kbd> + <kbd>T</kbd> : Cambiar la ventana actual a modo "terminal" (normal). Nos sirve cuando la ventana está en modo pantalla completa o flotante    
<kbd>Windows</kbd> + <kbd>M</kbd> : Cambiar la ventana actual a modo "completo" (no ocupa la polybar). Presione la mismas teclas para volver a modo "terminal" (normal)    
<kbd>Windows</kbd> + <kbd>F</kbd> : Cambiar la ventana actual a modo pantalla completa (ocupa todo incluyendo la polybar) 
<kbd>Windows</kbd> + <kbd>W</kbd> : Cerrar la ventana actual  
<kbd>Windows</kbd> + <kbd>(⬆⬅⬇➡)</kbd> : Moverse por las ventanas en la workspace actual  

## Shortcuts de Workspaces
<kbd>Windows</kbd> + <kbd>(1,2,3,4,5,6,7,8,9,0)</kbd> : Cambiar de workspace  
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>(1,2,3,4,5,6,7,8,9,0)</kbd> : Desplazar ventana a otro espacio del workspace  

## Shortcuts de Bspwm y Sxhkd
<kbd>Windows</kbd> + <kbd>Esc</kbd> : Reiniciar la configuración del sxhkd    
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>R</kbd> : Reiniciar la configuración del bspwm  
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>Q</kbd> : Cerrar sesión de bspwm  

## Shortcuts de Volumen y Brillo
<kbd>Windows</kbd> + <kbd>F7</kbd> : Subir el volumen  
<kbd>Windows</kbd> + <kbd>F6</kbd> : Bajar el volumen  
<kbd>Windows</kbd> + <kbd>F3</kbd> : Subir el brillo  
<kbd>Windows</kbd> + <kbd>F2</kbd> : Bajar el brillo  

## Shortcuts de Aplicaciones
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>A</kbd> : Abrir Postman  
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>O</kbd> : Abrir Obsidian  
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>S</kbd> : Abrir Pycharm  
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>F</kbd> : Abrir el firefox/chrome  
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>B</kbd> : Abrir el burpsuite  
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>V</kbd> : Abrir el vscode   
<kbd>Impr Pa</kbd> : Hacer captura de pantalla   
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>D</kbd> : Abrir el rofi launcher  
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> : Abrir el rofi powermenu  
<kbd>Esc</kbd> Salir del rofi  
<kbd>Windows</kbd> + <kbd>Shift</kbd> + <kbd>G</kbd> : Abrir el gestor de archivos thunar  

## Shortcuts de la Kitty
<kbd>Windows</kbd> + <kbd>Enter</kbd> : Abrir la consola (kitty-terminal)  
<kbd>Ctrl</kbd> + <kbd>Windows</kbd> + <kbd>Alt</kbd> + <kbd>(⬆⬅⬇➡)</kbd>: Preselectores en la kitty  
<kbd>Ctrl</kbd> + <kbd>Windows</kbd> + <kbd>Alt</kbd> + <kbd>(1,2,3,4,5,6,7,8,9,0)</kbd>: Controlar el ratio de los preselectores en la kitty  
<kbd>Ctrl</kbd> + <kbd>Windows</kbd> + <kbd>Alt</kbd> + <kbd>(Space)</kbd>: Cancelar preselección (kitty-terminal)   
<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>Enter</kbd>: Abrir subterminal dentro de la kitty    
<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>T</kbd>: Crear tab en la kitty  
<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>(⬆⬅⬇➡)</kbd>: Desplazarse por los tabs de la kitty  
<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>T</kbd>: Cambiar el nombre de los tabs de la kitty  
<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>R</kbd>: Activar resize de la kitty  
<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>Z</kbd>: Hacer zoom a un subterminal de la kitty  
<kbd>Resize kitty activado</kbd> + <kbd>W</kbd>: Aumentar el ancho de la kitty  
<kbd>Resize kitty activado</kbd> + <kbd>N</kbd>: Disminuir el ancho de la kitty  
<kbd>Resize kitty activado</kbd> + <kbd>T</kbd>: Aumentar la altura de la kitty  
<kbd>Resize kitty activado</kbd> + <kbd>S</kbd>: Disminuir la altura de la kitty   
<kbd>Resize kitty activado</kbd>+ <kbd>Ctrl</kbd> + <kbd>W</kbd>: Aumentar el ancho de la kitty el doble  
<kbd>Resize kitty activado</kbd>+ <kbd>Ctrl</kbd> + <kbd>N</kbd>: Disminuir el ancho de la kitty el doble  
<kbd>Resize kitty activado</kbd>+ <kbd>Ctrl</kbd> + <kbd>T</kbd>: Aumentar la altura de la kitty el doble  
<kbd>Resize kitty activado</kbd> + <kbd>Ctrl</kbd> + <kbd>S</kbd>: Disminuir la altura de la kitty el doble  
<kbd>Resize kitty activado</kbd> + <kbd>Esc</kbd>: Salir del modo resize de la kitty  
<kbd>Ctrl</kbd> + <kbd>(⬆⬅⬇➡)</kbd>: Desplazarse por las subterminales de la kitty  
<kbd>F1</kbd>: Copiar contenido en la primera clipboard de la kitty  
<kbd>F2</kbd>: Pegar contenido de la primera clipboard de la kitty  
<kbd>F3</kbd>: Copiar contenido en la segunda clipboard de la kitty  
<kbd>F4</kbd>: Pegar contenido de la segunda clipboard de la kitty  

## Shortcuts de la Zsh
<kbd>Alt</kbd> + <kbd>.</kbd>: Insertar el argumento del comando anterior  
<kbd>Ctrl</kbd> + <kbd>U</kbd>: Eliminar toda la línea  
<kbd>Alt</kbd> + <kbd>Supr</kbd>: Eliminar una palabra  
<kbd>Alt</kbd> + <kbd>(⬆⬅⬇➡)</kbd>: Desplazarse entre palabras  
<kbd>Supr</kbd>: Eliminar la letra a la derecha del cursor  
<kbd>Backspace</kbd>: Eliminar la letra a la izquierda del cursor  
<kbd>Alt</kbd> + <kbd>Supr</kbd>: Eliminar la palabra a la derecha del cursor  
<kbd>Alt</kbd> + <kbd>Backspace</kbd>: Eliminar la palabra la izquierda del cursor  
<kbd>Home</kbd>: Desplazamiento al inicio de la línea    
<kbd>End</kbd>: Desplazamiento al final de la línea    
<kbd>Shift</kbd> + <kbd>Tab</kbd>: Deshacer la última acción  
<kbd>Page Up</kbd>: Desplazarse hacia arriba en modo paginate  
<kbd>Page Down</kbd>: Desplazarse hacia abajo en modo paginate  
<kbd>Ctrl</kbd> + <kbd>R</kbd>: Mediante fzf nos autocompleta los archivos/directorios  
<kbd>Ctrl</kbd> + <kbd>R</kbd>: Mediante fzf podemos ejecutar comandos del histórico de la zsh  
<kbd>Esc</kbd> + <kbd>Esc</kbd>: Se activa el plugin sudo-zsh y nos añade sudo al principio del comando en la kitty  
<kbd>setTarget</kbd>: Mediante esta función en la zsh seteamos el target en la polybar  
<kbd>clearTarget</kbd>: Mediante esta función en la zsh limpiamos el target de la polybar  
<kbd>mkt</kbd>: Se crea una carpeta y dentro de ella varios directorios de trabajo  
<kbd>clearHistory</kbd>: Limpiar el historial de la zsh  
<kbd>removeHistory</kbd>: Eliminar el historial de la zsh  
<kbd>extractPorts</kbd>: Extrae los puertos de un archivo con formato -oG de nmap y los copia en la clipboard  
<kbd>enableTouchpad</kbd>: Habilitamos el touchpad del portátil  
<kbd>disableTouchpad</kbd>: Deshabilitamos el touchpad del portátil  

## Créditos
Autor: Justice-Reaper  
Inspiración: Entorno mostrado en la academia de hack4u de s4vitar
