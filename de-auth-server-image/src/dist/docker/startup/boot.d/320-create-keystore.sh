#!/bin/sh
set -e
umask 0027

if [[ -z "${DEPLOYMENT_HOSTNAME}" ]]; then
    echo "`date +\"%F %T\"` [INFO] DE service variable DEPLOYMENT_HOSTNAME is not set. Default value 'localhost' will be used."
    DEPLOYMENT_HOSTNAME="localhost"
fi

if [[ -z "${DEPLOYMENT_CONF_DIR}" ]]; then
    echo "`date +\"%F %T\"` [INFO] DE service variable DEPLOYMENT_CONF_DIR is not set. Default value '/opt/DE/conf' will be used."
    DEPLOYMENT_CONF_DIR="/opt/DE/conf"
fi


$JAVA_HOME/bin/keytool -genkey -alias de -keyalg rsa -sigalg SHA256withRSA -keysize 2048 -dname "CN=$DEPLOYMENT_HOSTNAME,OU=DE,O=DE,L=Bangalore,ST=KA,C=India" -keystore $DEPLOYMENT_CONF_DIR/de.keystore -keypass dataelicit@01 -storepass dataelicit@01 -storetype PKCS12
$JAVA_HOME/bin/keytool -export -alias de -file $DEPLOYMENT_CONF_DIR/de.cer -keystore $DEPLOYMENT_CONF_DIR/de.keystore -storetype PKCS12 -storepass dataelicit@01
$JAVA_HOME/bin/keytool -import -alias de -file $DEPLOYMENT_CONF_DIR/de.cer -noprompt -keystore $DEPLOYMENT_CONF_DIR/de.truststore -storetype PKCS12 -storepass dataelicit@01

