#!/bin/bash

echo ******************************************************
echo Starting restore $FILE_NAME
echo ******************************************************


mongorestore --uri=$MONGODB_URI --drop /mongodump/db/$FILE_NAME


sleep 30 | echo EndRestore