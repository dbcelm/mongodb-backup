#!/bin/bash

echo "----------------------------------------------------"
echo "Starting restore of $BACKUP_FILE_NAME"
echo "----------------------------------------------------"

mkdir -p mongodump

mount-s3 $S3_Bucket "mongodump"

MONGODB_URI="mongodb://$MONGODB_USERNAME:$MONGODB_PASSWORD@$MONGO_SERVICE_NAME:27017"

mongorestore --uri=$MONGODB_URI --drop mongodump/zde-mongodb-backups/$BACKUP_FILE_NAME
mongorestore_exit_code=$?

if [ $mongorestore_exit_code -ne 0 ]; then
    echo "mongorestore failed with exit code $mongorestore_exit_code."
    exit $mongorestore_exit_code  # Mark the script as failed
fi

sleep 30 | echo Restore Complete