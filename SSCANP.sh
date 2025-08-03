#!/bin/bash
puertos_comunes=(
    21     # FTP
    22     # SSH
    23     # Telnet
    25     # SMTP
    53     # DNS
    80     # HTTP
    110    # POP3
    111    # RPCbind
    135    # MS RPC
    139    # NetBIOS
    143    # IMAP
    443    # HTTPS
    445    # SMB
    465    # SMTPS
    514    # Syslog
    587    # SMTP (submission)
    993    # IMAPS
    995    # POP3S
    1025   # MS RPC
    1433   # MS SQL Server
    1521   # Oracle DB
    2049   # NFS
    2077   # WebDAV
    2082   # cPanel
    2083   # cPanel SSL
    2086   # WHM
    2087   # WHM SSL
    2095   # Webmail
    2096   # Webmail SSL
    2181   # ZooKeeper
    2375   # Docker
    2376   # Docker SSL
    3000   # Node.js
    3306   # MySQL
    3389   # RDP
    3690   # Subversion
    4000   # Ruby on Rails
    4040   # Spark UI
    4369   # Erlang Port Mapper
    5000   # Flask/UPnP
    5432   # PostgreSQL
    5601   # Kibana
    5672   # AMQP (RabbitMQ)
    5900   # VNC
    5938   # TeamViewer
    6379   # Redis
    7001   # WebLogic
    8000   # HTTP Alt
    8080   # HTTP Proxy
    8443    # HTTPS Alt
    27017   # MongoDB
    50000   # SAP
)
#Valores por defecto de la ip y puerto del squid proxy y de la ip la cual va a ser escaneada a través del SQUID Proxy

IpSquid=""
Port=""
IpToSCan=""
while getopts ":i:s:p:" opt; do # getopts ":l:p:" opt define que esperamos opciones -l y -p, ambas requieren argumentos (por los : después de cada letra).
  case $opt in 
    i)
      IpSquid="$OPTARG"
      ;;

    s)
      IpToSCan="$OPTARG"
      ;;

    p)
      Port="$OPTARG"
      ;;
    \?)
      echo "Opción inválida: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "La opción -$OPTARG requiere un argumento." >&2
      exit 1
      ;;
  esac
done
 
  



for puerto in "${puertos_comunes[@]}"; do
  respuesta=$(curl http://$IpToSCan:$puerto --proxy http://$IpSquid:$Port -i -s | head -n 1 | awk '{print $2}')
 if [ $respuesta -ne 503 ];then
   echo -e "\n [+] Puerto abierto: $puerto"
 fi
done

