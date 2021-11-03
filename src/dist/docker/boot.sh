#!/bin/sh
set -e
umask 0027

echo "`date +\"%F %T\"` [INFO] Setting server properties."

if [[ -z "${DEPLOYMENT_HOSTNAME}" ]]; then
    echo "`date +\"%F %T\"` [INFO] DE service variable DEPLOYMENT_HOSTNAME is not set. Default value 'localhost' will be used."
    DEPLOYMENT_HOSTNAME="localhost"
fi

$JAVA_HOME/bin/keytool -genkey -alias de -keyalg rsa -sigalg SHA256withRSA -keysize 2048 -dname "CN=$DEPLOYMENT_HOSTNAME,OU=DE,O=DE,L=Bangalore,ST=KA,C=India" -keystore /opt/DE/de.keystore -keypass dataelicit@01 -storepass dataelicit@01 -storetype PKCS12
$JAVA_HOME/bin/keytool -export -alias de -file de.cer -keystore /opt/DE/de.keystore -storetype PKCS12 -storepass dataelicit@01
$JAVA_HOME/bin/keytool -import -alias de -file de.cer -noprompt -keystore /opt/DE/de.truststore -storetype PKCS12 -storepass dataelicit@01


exec ${JAVA_HOME}/jre/bin/java -Djavax.net.ssl.trustStorePassword=dataelicit@01 -Djavax.net.ssl.trustStore=/opt/DE/de.truststore  -jar /opt/DE/app.jar

