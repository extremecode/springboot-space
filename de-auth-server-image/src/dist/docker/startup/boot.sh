#!/bin/sh

set -e
umask 0027

echo "`date +\"%F %T\"` [INFO] Running DE Auth server boot scripts..."
for script in $(ls -1 $DE_BOOT/*.sh)
do
	. $script;
done
echo "`date +\"%F %T\"` [INFO] Completed execution of all DE Auth server boot scripts..."

if [[ -z "${DEPLOYMENT_CONF_DIR}" ]]; then
    echo "`date +\"%F %T\"` [INFO] DE service variable DEPLOYMENT_CONF_DIR is not set. Default value '/opt/DE/conf' will be used."
    DEPLOYMENT_CONF_DIR="/opt/DE/conf"
fi

if [[ -z "${DEPLOYMENT_LIB_DIR}" ]]; then
    echo "`date +\"%F %T\"` [INFO] DE service variable DEPLOYMENT_LIB_DIR is not set. Default value '/opt/DE/lib' will be used."
    DEPLOYMENT_LIB_DIR="/opt/DE/lib"
fi



echo "`date +\"%F %T\"` [INFO] Starting DE AUTH server..."
exec ${JAVA_HOME}/jre/bin/java -Dloader.path=$DEPLOYMENT_CONF_DIR  -Djavax.net.ssl.trustStorePassword=dataelicit@01 -Djavax.net.ssl.trustStore=$DEPLOYMENT_CONF_DIR/de.truststore  -cp $DEPLOYMENT_LIB_DIR/app.jar org.springframework.boot.loader.PropertiesLauncher



