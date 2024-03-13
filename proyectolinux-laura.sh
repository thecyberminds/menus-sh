#!/bin/bash

# Solicitar el nombre del usuario y mostrar un mensaje de bienvenida
echo "Por favor, introduce tu nombre:"
read nombre_usuario
echo "Bienvenido@, $nombre_usuario. Selecciona una opción del menú."

# Función para mostrar el menú principal
mostrar_menu_principal() {
    echo "Menu principal"
    echo "Selecciona una opción:"
    echo "1. Comandos Básicos"
    echo "2. Gestión de Ficheros"
    echo "3. Gestión de Directorios"
    echo "4. Gestión de Permisos"
    echo "5. Gestión de Usuarios"
    echo "6. Calculadora"
    echo "7. Salir"
}

# Función para los comandos básicos
comandos_basicos() {
    while true; do
        clear
        echo "Menú de Comandos Básicos:"
        echo "1. Mostrar la fecha y hora actual (date)"
        echo "2. Mostrar informacion del sistema (uname)"
        echo "3. Mostrar procesos en ejecucion (ps aux)"
        echo "4. Mostrar quién está logueado (who)"
        echo "5. Mostrar el uso del disco (df)"
        echo "6. Mostrar la memoria libre (free)"
        echo "7. Ver el contenido de un archivo (cat)"
        echo "8. Mostrar las interfaces de red (ifconfig)"
        echo "9. Mostrar el manual de un comando (man)"
        echo "10. Mostrar conexiones de red (netstat)"
        echo "11. Salir al menú principal"
        read -p "Elige una opción: " opcion_cb

        case $opcion_cb in
            1) date ;;
            2) uname -a ;;
            3) ps aux ;;
            4) who ;;
            5) df ;;
            6) free ;;
            7) read -p "Introduce el nombre del archivo a ver: " archivo
               cat "$archivo" ;;
            8) ifconfig ;;
            9) read -p "Introduce el comando: " comando
               man "$comando" ;;
            10) netstat ;;
            11) clear && break ;;
            *) echo "Opción no válida. Por favor, intenta de nuevo." ;;
        esac
        echo "Pulsa una tecla para continuar..."
        read -n 1 # Espera a que el usuario presione una tecla
    done
}

# Función para la gestión de ficheros
gestion_ficheros() {
    while true; do
        clear # Limpia la pantalla antes de mostrar el menú
        echo "Los ficheros en el directorio actual son:"
        ls # Muestra los ficheros disponibles en el directorio actual
        echo "Menú de Gestión de Ficheros:"
        echo "1. Listar ficheros"
        echo "2. Crear un fichero"
        echo "3. Eliminar un fichero"
        echo "4. Copiar un fichero"
        echo "5. Mover/Renombrar un fichero"
        echo "6. Salir al menú principal"
        read -p "Elige una opción: " opcion_gf

        case $opcion_gf in
            1) ls ;;
            2) read -p "Introduce el nombre del fichero a crear: " fichero_crear
               touch "$fichero_crear"
               echo "Fichero '$fichero_crear' creado." ;;
            3) read -p "Introduce el nombre del fichero a eliminar: " fichero_eliminar
               rm -i "$fichero_eliminar" ;;
            4) read -p "Introduce el nombre del fichero a copiar: " fichero_copiar
               read -p "Introduce el nombre del fichero destino: " fichero_destino
               cp -i "$fichero_copiar" "$fichero_destino"
               echo "Fichero copiado de '$fichero_copiar' a '$fichero_destino'." ;;
            5) read -p "Introduce el nombre del fichero a mover/renombrar: " fichero_mover
               read -p "Introduce el nuevo nombre o ruta del fichero: " nuevo_nombre
               mv -i "$fichero_mover" "$nuevo_nombre"
               echo "Fichero '$fichero_mover' movido/renombrado a '$nuevo_nombre'." ;;
            6) break ;;
            *) echo "Opción no válida. Por favor, intenta de nuevo." ;;
        esac
        echo "Pulsa una tecla para continuar..."
        read -n 1
    done
}

# Función para la gestión de directorios
gestion_directorios() {
    while true; do
        clear # Limpia la pantalla antes de mostrar el menú
        echo "Menú de Gestión de Directorios:"
        echo "1. Buscar directorio"
        echo "2. Crear un directorio"
        echo "3. Eliminar un directorio"
        echo "4. Cambiar el directorio actual"
        echo "5. Mostrar el directorio actual"
        echo "6. Salir al menú principal"
        read -p "Elige una opción: " opcion_gd

        case $opcion_gd in
            1) read -p "Introduce el nombre del directorio a buscar: " nombre_directorio
               echo "Buscando directorios llamados '$nombre_directorio'..."
               resultados=$(find / -type d -name "$nombre_directorio" 2>/dev/null)
               if [ -z "$resultados" ]; then
                   echo "No se ha encontrado ningún directorio llamado '$nombre_directorio'."
               else
                   echo "Directorio(s) encontrado(s):"
                   echo "$resultados"
               fi ;;
            2) read -p "Introduce el nombre del directorio a crear: " directorio_crear
               mkdir -p "$directorio_crear"
               echo "Directorio '$directorio_crear' creado." ;;
            3) read -p "Introduce el nombre del directorio a eliminar: " directorio_eliminar
               rmdir "$directorio_eliminar" 2>/dev/null || echo "El directorio no está vacío o no existe."
               echo "Intenta eliminar el directorio '$directorio_eliminar'." ;;
            4) read -p "Introduce la ruta del directorio al que cambiar: " directorio_cambiar
               if cd "$directorio_cambiar" 2>/dev/null; then
                   echo "Cambiado al directorio '$directorio_cambiar'."
               else
                   echo "El directorio no existe o no se pudo cambiar."
               fi ;;
            5) echo "Directorio actual: $(pwd)" ;;
            6) break ;;
            *) echo "Opción no válida. Por favor, intenta de nuevo." ;;
        esac
        echo "Pulsa una tecla para continuar..."
        read -n 1
    done
}

# Función para la gestión de permisos
gestion_permisos() {
    while true; do
        clear # Limpia la pantalla antes de mostrar el menú
        echo "Menú de Gestión de Permisos:"
        echo "1. Asignar permisos a un archivo o directorio"
        echo "2. Añadir permisos a un archivo o directorio"
        echo "3. Suprimir permisos de un archivo o directorio"
        echo "4. Cambiar la máscara de permisos por defecto (umask)"
        echo "5. Salir al menú principal"
        read -p "Elige una opción: " opcion_gp

        case $opcion_gp in
            1) read -p "Introduce la ruta del archivo/directorio: " ruta
               read -p "Introduce los permisos en formato octal (ej. 755): " permisos
               chmod $permisos "$ruta"
               echo "Permisos asignados a '$ruta'." ;;
            2) read -p "Introduce la ruta del archivo/directorio: " ruta
               read -p "Introduce los permisos a añadir (ej. rwx): " permisos
               chmod +$permisos "$ruta"
               echo "Permisos añadidos a '$ruta'." ;;
            3) read -p "Introduce la ruta del archivo/directorio: " ruta
               read -p "Introduce los permisos a suprimir (ej. rwx): " permisos
               chmod -$permisos "$ruta"
               echo "Permisos suprimidos de '$ruta'." ;;
            4) read -p "Introduce la nueva máscara de permisos por defecto (ej. 022): " nueva_umask
               umask $nueva_umask
               echo "La máscara de permisos por defecto ha sido cambiada a $nueva_umask." ;;
            5) break ;;
            *) echo "Opción no válida. Por favor, intenta de nuevo." ;;
        esac
        echo "Pulsa una tecla para continuar..."
        read -n 1
    done
}

# Función para la gestión de usuarios
gestion_usuarios() {
    while true; do
        clear # Limpia la pantalla antes de mostrar el menú
        echo "Menú de Gestión de Usuarios:"
        echo "1. Añadir un nuevo usuario"
        echo "2. Eliminar un usuario"
        echo "3. Cambiar contraseña de un usuario"
        echo "4. Listar usuarios del sistema"
        echo "5. Salir al menú principal"
        read -p "Elige una opción: " opcion_gu

        case $opcion_gu in
            1) read -p "Introduce el nombre del nuevo usuario: " nuevo_usuario
               sudo adduser "$nuevo_usuario"
               echo "Usuario '$nuevo_usuario' añadido al sistema." ;;
            2) read -p "Introduce el nombre del usuario a eliminar: " usuario_eliminar
               sudo deluser "$usuario_eliminar"
               echo "Usuario '$usuario_eliminar' eliminado del sistema." ;;
            3) read -p "Introduce el nombre del usuario para cambiar contraseña: " usuario_contrasena
               sudo passwd "$usuario_contrasena"
               echo "Contraseña cambiada para el usuario '$usuario_contrasena'." ;;
            4) echo "Listando usuarios del sistema..."
               awk -F':' '{ print $1}' /etc/passwd ;;
            5) break ;;
            *) echo "Opción no válida. Por favor, intenta de nuevo." ;;
        esac
        echo "Pulsa una tecla para continuar..."
        read -n 1
    done
}

# Función para la calculadora
calculadora() {
    while true; do
        clear # Limpia la pantalla antes de mostrar el menú de la calculadora
        echo "Calculadora"
        numeros=() # Arreglo para almacenar los números introducidos
        operaciones=() # Arreglo para almacenar las operaciones elegidas
        
        # Capturar el primer número
        read -p "Introduce el primer número: " num
        numeros+=("$num")
        
        # Bucle para capturar números adicionales y la operación a realizar con el número anterior
        while true; do
            echo "Introduce el símbolo de la operación que deseas realizar con el siguiente número:"
            echo "+ para suma, - para resta, * para multiplicación, / para división"
            echo "Escribe 'fin' para terminar y mostrar el resultado."
            read -p "Operación: " operacion
            
            # Verificar si el usuario quiere terminar y mostrar el resultado
            if [[ "$operacion" == "fin" ]]; then
                break
            fi
            
            # Verificar que la operación sea válida
            if [[ "$operacion" != "+" && "$operacion" != "-" && "$operacion" != "*" && "$operacion" != "/" ]]; then
                echo "Operación no válida. Por favor, introduce una operación válida."
                continue
            fi
            
            # Capturar el siguiente número
            read -p "Introduce el siguiente número: " num
            # Verificar si el input es numérico
            if ! [[ "$num" =~ ^-?[0-9]+(\.[0-9]+)?$ ]]; then
                echo "Por favor, introduce un número válido."
                continue
            fi
            
            numeros+=("$num")
            operaciones+=("$operacion")
        done
        
        # Calcular el resultado
        resultado=${numeros[0]}
        for (( i = 1; i < ${#numeros[@]}; i++ )); do
            case ${operaciones[$((i-1))]} in
                +) resultado=$((resultado + ${numeros[i]})) ;;
                -) resultado=$((resultado - ${numeros[i]})) ;;
                *) resultado=$((resultado * ${numeros[i]})) ;; # Multiplicación
                /) if [ ${numeros[i]} -eq 0 ]; then
                       echo "Error: División por cero no es posible."
                       exit 1
                   else
                       # Bash realiza división entera, para punto flotante se requiere bc u otra herramienta
                       resultado=$((resultado / ${numeros[i]}))
                   fi ;;
            esac
        done
        
        echo "El resultado final es: $resultado"
        echo "Pulsa una tecla para continuar..."
        read -n 1
        
        echo "¿Deseas realizar otro cálculo? (s/n)"
        read -p "Selección: " decision
        if [[ "$decision" != "s" ]]; then
            break
        fi
    done
}
# Función para salir
salir() {
    echo "Gracias por usar el sistema, $nombre_usuario. Hasta la próxima."
    sleep 3s
    clear
    exit 0
}

# Bucle principal del programa
while true; do
    clear
    mostrar_menu_principal
    read opcion
    case $opcion in
        1) comandos_basicos ;;
        2) gestion_ficheros ;;
        3) gestion_directorios ;;
        4) gestion_permisos ;;
        5) gestion_usuarios ;;
        6) calculadora ;;
        7) salir ;;
        *) echo "Opción no válida. Por favor, intenta de nuevo." ;;
    esac
    echo "Pulsa una tecla para continuar..."
    read -n 1 # Espera a que el usuario presione una tecla
done
