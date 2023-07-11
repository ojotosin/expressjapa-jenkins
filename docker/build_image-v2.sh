#!/bin/bash

# Run the docker build command
docker build \
--no-cache \
--build-arg PERSONAL_ACCESS_TOKEN='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' \
--build-arg GITHUB_USERNAME='ojotosin' \
--build-arg REPOSITORY_NAME='expressjapa-jenkins'  \
--build-arg WEB_FILE_ZIP='expressjapa.zip' \
--build-arg WEB_FILE_UNZIP='expressjapa' \
--build-arg RDS_DB_ENDPOINT='expressjapadb-v1.ckarc33mlfud.us-east-1.rds.amazonaws.com' \
--build-arg RDS_DB_NAME='expressjapa_db_v1' \
--build-arg RDS_MASTER_USERNAME='mysqluser' \
--build-arg RDS_DB_PASSWORD='mysqlpassword' \
-t expressjapa-v1 .    # tag name
