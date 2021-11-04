#!/bin/sh

if [[ -z "${DEPLOYMENT_CONF_DIR}" ]]; then
    echo "`date +\"%F %T\"` [INFO] DE service variable DEPLOYMENT_CONF_DIR is not set. Default value '/opt/DE/conf' will be used."
    DEPLOYMENT_CONF_DIR="/opt/DE/conf"
fi

if [[ -z "${DEPLOYMENT_DB_SVC_NAME}" ]]; then
    echo "`date +\"%F %T\"` [INFO] DE service variable DEPLOYMENT_DB_SVC_NAME is not set. Default value 'localhost' will be used."
    DEPLOYMENT_DB_SVC_NAME="localhost"
fi

if [[ -z "${DEPLOYMENT_DB_SVC_PORT}" ]]; then
    echo "`date +\"%F %T\"` [INFO] DE service variable DEPLOYMENT_DB_SVC_PORT is not set. Default value '5432' will be used."
    DEPLOYMENT_DB_SVC_PORT="5432"
fi

if [[ -z "${DEPLOYMENT_DB_SVC_DATABASE_NAME}" ]]; then
    echo "`date +\"%F %T\"` [INFO] DE service variable DEPLOYMENT_DB_SVC_DATABASE_NAME is not set. Default value 'postgres' will be used."
    DEPLOYMENT_DB_SVC_DATABASE_NAME="postgres"
fi

if [[ -z "${DEPLOYMENT_DB_SVC_USER_NAME}" ]]; then
    echo "`date +\"%F %T\"` [INFO] DE service variable DEPLOYMENT_DB_SVC_USER_NAME is not set. Default value 'postgres' will be used."
    DEPLOYMENT_DB_SVC_USER_NAME="postgres"
fi

if [[ -z "${DEPLOYMENT_DB_SVC_PASSWORD}" ]]; then
    echo "`date +\"%F %T\"` [INFO] DE service variable DEPLOYMENT_DB_SVC_PASSWORD is not set. Default value 'postgres' will be used."
    DEPLOYMENT_DB_SVC_PASSWORD="postgres"
fi

DEPLOYMENT_DB_JDBC_URL="jdbc:postgresql://$DEPLOYMENT_DB_SVC_NAME:$DEPLOYMENT_DB_SVC_PORT/$DEPLOYMENT_DB_SVC_DATABASE_NAME"


echo "`date +\"%F %T\"` [INFO] Database JDBC URL:$DEPLOYMENT_DB_JDBC_URL"

echo "

spring.datasource.url= $DEPLOYMENT_DB_JDBC_URL
spring.datasource.username= $DEPLOYMENT_DB_SVC_USER_NAME
spring.datasource.password= $DEPLOYMENT_DB_SVC_PASSWORD

" >> $DEPLOYMENT_CONF_DIR/application.properties
