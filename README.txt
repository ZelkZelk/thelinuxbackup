BACKUPS para linux
==================

La idea es montar via NFS u otro protocolo una carpeta del DATASTORAGE en el server para realizar un COPY PASTE convencional sobre el file system.

El script se encarga de hacer los dumps de las bases de datos configuradas.

CONFIG
======

Se provee configuracion de ejemplo en exampleconf, copiar todos los archivos para que esten en el mismo level de backup.sh.
De momento todo debe estar en /root/backup, espero cambiar esto pronto.

Luego de copiar los archivos ajustar a las necesidades de cada linux box.

CRONTAB
=======

El script backup.sh lo ejecuto en el crontab dependiendo de la necesidad.

# Backup
0 0 * * MON /root/backup/backup.sh
0 0 * * WED /root/backup/backup.sh
0 0 * * FRI /root/backup/backup.sh

CHANGELOG
=========

 * v0.1

	- Soporte para copiar carpetas enteras
	- Soporte para MySQL
	- Soporte para MongoDB

CONTACTO
========

felipeklez@gmail.com
