#!/bin/bash
######################################
# Backup script
# Description: Full backup script for Home Assistant and Raspbian configs files
# Version 1.01
# Author: Asert
# Help:
#       rclone - https://1cloud.ru/help/cloud-storage/rclone-dlya-raboty-s-oblachnym-hranilishchem
# Contact: https://github.com/asert
######################################

set -e

BAKUP_FILES="/home/homeassistant /etc /root"
# Don't use root / in EXCLUDE_DIRS
EXCLUDE_DIRS="home/homeassistant/.cache/*"
BAKUP_DIR="/home/backup"
KEEP_DAYS=7

CURRENT_DATE=`date +"%Y%m%d-%H%M"`
HOSTNAME=$(hostname)

ARCHIVE_FILE="$BAKUP_DIR/$HOSTNAME-$CURRENT_DATE.tar.gz"

tar -cvpzf $ARCHIVE_FILE --exclude "$EXCLUDE_DIRS" $BAKUP_FILES

find $BAKUP_DIR -type f -name '*.tar.gz' -mtime +$KEEP_DAYS -delete

rclone sync /home/backup google:backup
