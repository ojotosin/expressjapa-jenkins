#!/bin/bash

# Run the docker build command
docker build \
--no-cache \
--build-arg PERSONAL_ACCESS_TOKEN='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' \
--build-arg GITHUB_USERNAME='ojotosin' \
--build-arg REPOSITORY_NAME='expressjapa-jenkins'  \
--build-arg WEB_FILE_ZIP='expressjapa.zip' \
--build-arg WEB_FILE_UNZIP='expressjapa' \
--build-arg RDS_DB_ENDPOINT='expressjapadb-v1new.ckarc33mlfud.us-east-1.rds.amazonaws.com' \
--build-arg RDS_DB_NAME='expressjapadb' \
--build-arg RDS_MASTER_USERNAME='mysqluser' \
--build-arg RDS_DB_PASSWORD='mysqlpassword' \
-t expressjapa-v1 .    # tag name
