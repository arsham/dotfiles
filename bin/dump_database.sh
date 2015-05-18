#!/bin/bash

TEMP_FOLDER="/tmp"
REMOPTE_TEMP_FOLDER="/tmp"

if [ "$1" == "--help" ]; then
    echo "
    Usage: bring_dump.sh OPTION
    Example: bring_dump.sh -h localhost -u arsham -p my_password

    Options are:
        -h, --host hostname
        -P, --port #
        -u, --username username
        -p, --password password
        -t, --tmp-folder temp_folder
        -r, --remote-tmp-folder remopte_temp_folder
    ";
    exit 0;
fi;

while [[ $# > 1 ]]; do
        key="$1"

        case $key in
            -h|--host)
                HOST=" -h $2"
                shift
            ;;
            -u|--username)
                USERNAME=" -u $2"
                shift
            ;;
            -p|--password)
                PASSWORD=" -p$2"
                shift
            ;;
            -P|--port)
                PORT=" -P$2"
                shift
            ;;
            -t|--tmp-folder)
                TEMP_FOLDER="$2"
                shift
            ;;
            -r|--remote-tmp-folder)
                REMOPTE_TEMP_FOLDER="$2"
                shift
            ;;
            *)
                # unknown option
            ;;
        esac
    shift
done



echo "dumping into $TEMP_FOLDER, remote: $REMOPTE_TEMP_FOLDER"
echo mysql $USERNAME$PASSWORD$HOST$PORT

# cd /home/arsham/Desktop/Stuff/
# echo "Creating dump on server ..."
# ssh $1 "cd bin; bash dump_g4.sh"
# echo "Bringing back the dump ..."
# scp $1:/tmp/$2.sql.gz ./
# [ -f $2.sql ] && rm -f $2.sql
# echo "Uncompressing ..."
# gunzip $2.sql.gz
#
# echo "Erasing current database"
# mysql  -u $3 -p$4 $2 -e "drop database $2; create database $2 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ;"
# echo "Inserting in db ..."
# mysql  -u $3 -p$4 $2 < $2.sql
#
# echo "All done!"
