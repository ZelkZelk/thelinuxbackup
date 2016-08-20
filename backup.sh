#!/bin/bash

source "/root/backup/conf.sh"
source "/root/backup/env.sh"
source "/root/backup/util.sh"

##################################################
# Script que crea un backup de todo lo necesario #
##################################################

FILE="/root/.last_backup"
SUBJECT="[SUCCESS] $LABEL BACKUP FINALIZADO"
EMAIL_TXT="/root/.backup_email"
TODAY=$($DATE | $AWK '{print $3"-"$2"-"$6}')

#####################
# Inicio del Backup #
#####################

STARTING=$($DATE)
message "Comenzando Backup"
message "Fecha Server: $STARTING"

#########################################
# Creamos la carpeta destino del backup #
#########################################

FOLDER="$MOUNTPOINT/$TODAY/$LABEL";
$MKDIR -p $FOLDER

if [[ ! -d $FOLDER ]] ; then
	error "No existe $FOLDER, tal vez no se pudo crear con $MKDIR -p $FOLDER" "[FAIL] Backup @ $LABEL" "$EMAIL"	
	exit;
fi

##############################
# Mysqldumps de todas las BD #
##############################

if [ "$MYSQL_BACKUP" = true ] ; then
	MYSQL_DUMP_DIR=$FOLDER$MYSQL_DUMP_DST
	$MKDIR -p $MYSQL_DUMP_DIR
	message "MySQL Dumps [$MYSQL_DATA > $MYSQL_DUMP_DIR]";

	if [[ ! -d $MYSQL_DUMP_DIR ]] ; then
        	error "No existe $MYSQL_DUMP_DIR, tal vez no se pudo crear con $MKDIR -p $MYSQL_DUMP_DIR" "[FAIL] Backup @ $LABEL" "$EMAIL"
		exit;
	fi

	for d in $(ls $MYSQL_DATA)
	do
		if [[ -d "$MYSQL_DATA/$d" ]] ; then
			message "Database $d"

			if [[ $MYSQL_PASS == "" ]] ; then
        	       		$MYSQLDUMP -u $MYSQL_USER  $d > "$MYSQL_DUMP_DIR/$d.sql"
                	else
                        	$MYSQLDUMP -u $MYSQL_USER -p"$MYSQL_PASS" $d > "$MYSQL_DUMP_DIR/$d.sql"
	                fi
                  
        	        s=$?

                	if [[ $s -ne 0 ]]; then
				message "MySQL problems at $d"
        	        fi
	         fi
	done
fi

#####################
# Mongo Full Backup #
#####################

if [ "$MONGO_BACKUP" = true ] ; then
	MONGO_DUMP_DIR=$FOLDER$MONGO_DUMP_DST
	$MKDIR -p $MONGO_DUMP_DIR
	message "MongoDB Dumps [$MONGO_DUMP_DIR]";

        if [[ ! -d $MONGO_DUMP_DIR ]] ; then
                error "No existe $MONGO_DUMP_DIR, tal vez no se pudo crear con $MKDIR -p $MONGO_DUMP_DIR" "[FAIL] Backup @ $LABEL" "$EMAIL"
                exit;
        fi

	$MONGODUMP --out $MONGO_DUMP_DIR
fi

########################
# Respaldo de carpetas #
########################

for f in $($CAT $FOLDER_LIST)
do
	if [[ -d $f ]] ; then
		DST=$FOLDER$f
		$MKDIR -p $DST

		if [[ ! -d $DST ]] ; then
		      error "No existe $DST, tal vez no se pudo crear con $MKDIR -p $DST" "[FAIL] Backup @ $LABEL" "$EMAIL"
	       	      exit;
		fi

		message "Folder [$f > $DST]";
		cp $f -R $DST
	fi
done

###########################
# Finalizacion del Backup #
###########################

SIZE=$($DU -sh $FOLDER | $AWK '{ print $1 }')
ENDING=$($DATE)

message "Finalizando Backup"
message "Total: $SIZE"
message "Fecha Server: $ENDING"
summary "[DONE] Backup @ $LABEL" "$EMAIL"
