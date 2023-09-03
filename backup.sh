#!/bin/bash

echo ******************************************************
echo Starting Mongo Backup
echo ******************************************************
TIMESTAMP="$(date +"%F")-$(date +"%T")"

FILE="$DB_NAME-$TIMESTAMP"
MONGODB_URI="mongodb://$MONGODB_USERNAME:$MONGODB_PASSWORD@$MONGO_SERVICE_NAME:27017/$DB_NAME"

mongodump --uri=$MONGODB_URI  --out=/mongodump/db/$FILE

sleep 30 | echo Backup-Complete

echo ******************************************************
echo Uploading Mongo Backup to S3
echo ******************************************************

aws s3 cp /mongodump/db/$FILE s3://$S3_Bucket/mongo-backups/$(date +"%F")

sleep 5 | echo Upload-Complete