#!/bin/bash

function show_menu {
    clear
    echo "  っ◔◡◔)っ FRANCK TSCHERIG  V1.2 "
    echo ""
	echo "herramientas para ayudar a detectar procesos sospechosos:"
	echo ""
	echo ""
    echo "1. Ver procesos sospechosos (uso alto de CPU o memoria)"
    echo "2. Ver conexiones de red activas"
    echo "3. Ver archivos abiertos por procesos"
    echo "4. Ver información detallada de un proceso con strace"
    echo "5. Ver tabla ARP"
    echo "6. Ver conexiones establecidas"
    echo "7. Ver puertos abiertos y servicios en escucha"
    echo "8. Ver procesos ocultos y guardar lista"
    echo "9. Ver módulos de kernel cargados"
    echo "10. Escanear archivos en busca de malware conocido"
    echo "11. Ver tráfico de red sospechoso y detener escaneo"
    echo "12. Ver procesos en modo privilegiado"
    echo "13. Ver todas las conexiones (TCP y UDP)"
    echo "14. Salir"
}



function check_high_usage_processes {
    echo "Procesos con uso alto de CPU o memoria:"
    ps aux | awk 'NR>1 {if ($3 >= 50 || $4 >= 50) print $2, $11}'
}

function check_hidden_processes {
    echo "Procesos ocultos:"
    ps aux | grep -v "$(basename $0)" | grep -v "grep"
}

function check_hidden_processes_and_save {
    dateTime=$(date +"%Y-%m-%d_%H-%M-%S")
    echo "Procesos ocultos:"
    ps aux | grep -v "$(basename $0)" | grep -v "grep" > procesos_ocultos_$dateTime.txt
    echo "Lista de procesos ocultos guardada en procesos_ocultos_$dateTime.txt"
}

function check_active_network_connections {
    echo "Conexiones de red activas:"
    netstat -tuln
    echo ""

}

function check_open_files_by_processes {
    echo "Lista de procesos:"
    ps aux | awk 'NR>1 {print $2, $11}'

    echo "Ingrese el PID del proceso para ver sus archivos abiertos:"
    read pid

    echo "Archivos abiertos por el proceso con PID $pid:"
    lsof -p $pid
}

function detailed_process_info_with_strace {
    echo "Lista de procesos:"
    ps aux | awk 'NR>1 {print $2, $11}'

    echo "Ingrese el PID del proceso para obtener información detallada con strace:"
    read pid

    echo "Ingrese el tiempo límite en segundos para la ejecución de strace:"
    read timeout_value

    echo "Ejecutando strace en el proceso con PID $pid y guardando la salida en strace_output_PID_$pid.txt..."

    # Utilizamos timeout para limitar el tiempo de ejecución de strace
    timeout $timeout_value strace -p $pid &> strace_output_PID_$pid.txt

    echo "Información detallada del proceso con PID $pid guardada en strace_output_PID_$pid.txt"
}


function view_arp_table {
    echo "Tabla ARP:"
    arp -a
}

function view_established_connections {
    echo "Conexiones establecidas:"
    ss -tunapl | grep ESTAB
}

function view_open_ports {
    echo "Puertos abiertos y servicios en escucha:"
    netstat -tuln
}

function view_loaded_kernel_modules {
    dateTime=$(date +"%Y-%m-%d_%H-%M-%S")
    echo "Módulos de kernel cargados:"
    lsmod > kernel_modules_$dateTime.txt
    echo "Lista de módulos de kernel cargados guardada en kernel_modules_$dateTime.txt"
}

function scan_for_malware {
     dateTime=$(date +"%Y-%m-%d_%H-%M-%S")
         echo "Ingrese el directorio o archivo a escanear:(ejemplo /home/franck/)"
    read target

    echo "Escaneando $target en busca de malware conocido..."
    echo " ...... Escaneando ......." 
    clamscan -r "$target"> malware_scan_$dateTime.txt
    echo "Resultados del escaneo de malware guardados en malware_scan_$dateTime.txt"
}

function view_suspicious_network_traffic {
dateTime=$(date +"%Y-%m-%d_%H-%M-%S")
    echo "Iniciando captura de tráfico de red sospechoso..."
    sudo tcpdump -i eth0 -w suspicious_traffic.pcap &
    tcpdump_pid=$!

    echo "La captura de tráfico de red sospechoso ha comenzado. Presione Enter para detener el escaneo."
    read -p ""

    echo "Deteniendo la captura de tráfico de red..."
    sudo kill $tcpdump_pid
    echo "Captura de tráfico de red sospechoso detenida."

    echo "Analizando el archivo de captura suspicious_traffic.pcap..."
    tshark -r suspicious_traffic.pcap > suspicious_traffic_$dateTime.txt
    echo "Resultados de la captura de tráfico sospechoso guardados en suspicious_traffic_$dateTime.txt"
}
function view_privileged_processes {
	dateTime=$(date +"%Y-%m-%d_%H-%M-%S")
    echo "Procesos en modo privilegiado (root):"
    ps aux | grep "root" > privileged_processes_$dateTime.txt
    echo "Lista de procesos en modo privilegiado guardada en privileged_processes_$dateTime.txt"
}

function view_all_connections {
    echo "Todas las conexiones (TCP):"
    ss -tuna

    echo "Todas las conexiones (UDP):"
    ss -u

    echo "Todas las conexiones (RAW):"
    ss -w
        echo "NOTA"
    echo "Si aparece 224.0.0.251 no asustarse, es Multicast DNS y usa el puerto 5353. Muchos sistemas operativos lo utilizan para descubrir nuevos dispositivos/impresoras/enrutadores"
}

# Menú principal
while true; do
    show_menu
    read -p "Seleccione una opción (1-14): " choice

    case $choice in
        1) check_high_usage_processes ;;
        2) check_active_network_connections ;;
        3) check_open_files_by_processes ;;
        4) detailed_process_info_with_strace ;;
        5) view_arp_table ;;
        6) view_established_connections ;;
        7) view_open_ports ;;
        8) check_hidden_processes_and_save ;;
        9) view_loaded_kernel_modules ;;
        10) scan_for_malware ;;
        11) view_suspicious_network_traffic ;;
        12) view_privileged_processes ;;
        13) view_all_connections ;;
        14) break ;;
        *) echo "Opción no válida. Por favor, seleccione una opción válida." ;;
    esac

    read -p $'\nPresione Enter para continuar...'
done
