# Configuración de SWAY para Ubuntu/Debian con Wayland

Este repositorio está diseñado para configurar SWAY rápidamente y de forma sencilla en una instalación mínima de Ubuntu, Debian o Arch con Wayland. \
Ofrece una configuración, personalización y funcionamiento básico suficiente para la mayoría de los usuarios.

> **Nota:** Se recomienda leer la documentación oficial de SWAY para comprender mejor las opciones y ajustes disponibles.

## Características Principales

- Teclas de acceso modificadas [Mas familiares a un usuario regular].
- Aplicaciones básicas configuradas:
  \- Bloqueo de pantalla
  \- Capturas de pantalla
  \- Navegador
  \- Explorador de archivos\
  \- Terminal
- Soporte para gestos en trackpad.
- Configuración visual básica: Fondo de pantalla, fuentes (Nerd font), colores y bordes editados.
- Accesos de teclado: Brillo, Volumen, Controles multimedia, Bloqueo de pantalla etc.. configurados

## Configuración de Variables

- **Fondo de pantalla:** Cambia `$background` por la ruta de tu imagen.
  ```bash
  set $background ~/.local/share/backgrounds/bg.jpg
  ```
- **Tecla Modificadora:** 'Mod4' (Tecla de Windows) - 'Mod1' (Tecla Alt) - 'Control' (tecla CTRL)
  ```bash
  set $mod Mod4
  ```
- **Aplicaciones:** Personaliza tus aplicaciones predeterminadas (ej. terminal, navegador, gestor de archivos, etc.).
  ```bash
  set $term foot
  set $menu wofi --show drun
  set $browser firefox --new-tab
  set $filemanager thunar
  ```

## Teclas de Acceso Rápido

### Básicas

- Abrir terminal: `$mod` + `Shift` + `Return`
- Iniciar lanzador de aplicaciones: `$mod` + `Return`
- Cerrar ventana enfocada: `$mod` + `Delete`

### Movimiento entre ventanas

- Cambiar enfoque: `Alt` + `Tab` / `Alt` + `Shift` + `Tab`
- Mover enfoque:
  - Izquierda: `$mod` + `Left`
  - Derecha: `$mod` + `Right`
  - Arriba: `$mod` + `Up`
  - Abajo: `$mod` + `Down`
- Mover ventana enfocada: Agregar `Shift` a las combinaciones anteriores.

### Espacios de Trabajo (Workspaces)

- Cambiar de espacio de trabajo:
  ```bash
  $mod + [Número del espacio] (ej. $mod + 1)
  ```
- Mover ventana al espacio de trabajo:
  ```bash
  $mod + Shift + [Número del espacio]
  ```

### Gestos en Trackpad

- Cambiar de espacio de trabajo:
  - Deslizar hacia la derecha: `next workspace `
  - Deslizar hacia la izquierda: `prev workspace `
- Mostrar / Ocultar contenedores:
  - Deslizar hacia arriba: Ocultar ventanas del contenedor activo
  - Deslizar hacia abajo: Mostrar ventanas ocultas

### Accesos directos del teclado;

Las teclas para las siguientes funciones ya están configuradas:

- **Brillo**
- **Volumen**
- **Controles multimedia**
- **Accesos directos** (como abrir la calculadora o tomar un screenshot)

Sin embargo, algunos teclados pueden incluir teclas adicionales que no están preconfiguradas. En esos casos, será necesario configurarlas manualmente en el archivo `config` de SWAY.

## Configuración Visual

- **Fuente:**
  ```bash
  font pango:'Hasklug Nerd Font' 10
  ```
- **Colores:** Puedes modificar los colores de las ventanas y el fondo según tus preferencias.
  ```bash
  set $bg1 #32323200
  set $tx1 #285577ff
  ```
- **Barras de estado:** Los colores también modificaran la barra de estado

## Requisitos

- **Dependencias:** Instala las siguientes herramientas antes de usar esta configuración:
  - `sway`
  - `swaybg`
  - `swayidle`
  - `swaylock`
  - `wofi`
  - `brightnessctl`
  - `pipewire`
  - `playerctl`
  - `firefox-esr / firefox`
  - `p7zip-full`
  - `thunar`

## Instalación

En ```bash
   git clone https://github.com/leoleguizamon97/Desktop
   ```
Hay un instalador que busca ofrecer una configuracion de SWAY completa para instalaciones minimas de Debian/ubuntu o Arch. Te recomiendo ver el proyecto que implementa este archivo

También se puede copiar directamente este archivo a la configuración de SWAY

1. Clona este repositorio:
   ```bash
   git clone https://github.com/leoleguizamon97/sway.git
   ```
2. Copia los archivos de configuración a tu directorio de usuario:
   ```bash
   cp config ~/.config/sway/config
   ```
3. Reinicia SWAY para aplicar los cambios:
   ```bash
   swaymsg reload
   ```

---

**Contribuciones:** Se aceptan sugerencias y mejoras mediante Pull Requests. ¡Gracias por colaborar!

