#!/bin/bash

# Run the docker build command
docker build \
--build-arg PERSONAL_ACCESS_TOKEN='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' \
--build-arg GITHUB_USERNAME='ojotosin' \
--build-arg REPOSITORY_NAME='expressjapa-ecs'  \
--build-arg WEB_FILE_ZIP='travelfresh.zip' \
--build-arg WEB_FILE_UNZIP='travelfresh' \
--build-arg RDS_DB_ENDPOINT='expressjapadb-v1.ckarc33mlfud.us-east-1.rds.amazonaws.com' \
--build-arg RDS_DB_NAME='expressjapa_db_v1' \
--build-arg RDS_MASTER_USERNAME='mysqluser' \
--build-arg RDS_DB_PASSWORD='mysqlpassword' \
-t travelfreshv2 .    # tag name