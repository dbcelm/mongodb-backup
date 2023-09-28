#!/bin/bash

echo "----------------------------------------------------"
echo "Starting MongoDB Backup"
echo "----------------------------------------------------"

TIMESTAMP="$(date +"%F")-$(date +"%T")"

FILE="$DB_NAME-$TIMESTAMP"
MONGODB_URI="mongodb://$MONGODB_USERNAME:$MONGODB_PASSWORD@$MONGO_SERVICE_NAME:27017"

# Mount S3 Endpoint
mkdir -p mongodump

mount-s3 $S3_Bucket "mongodump"

# Run mongodump
mongodump --uri=$MONGODB_URI --out=mongodump/mongodb-backups/$(date +"%F")/$FILE
mongodump_exit_code=$?

if [ $mongodump_exit_code -ne 0 ]; then
    echo "mongodump failed with exit code $mongodump_exit_code."
    exit $mongodump_exit_code  # Mark the script as failed
fi

echo "----------------------------------------------------"
echo "Backup and upload completed successfully"
echo "----------------------------------------------------"