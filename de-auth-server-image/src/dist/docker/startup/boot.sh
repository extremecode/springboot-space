#!/bin/sh

set -e
umask 0027

echo "`date +\"%F %T\"` [INFO] Running DE Auth server boot scripts..."
for script in $(ls -1 $DE_BOOT/*.sh)
do
	. $script;
done
echo "`date +\"%F %T\"` [INFO] Completed execution of all DE Auth server boot scripts..."

if [[ -z "${DEPLOYMENT_INSTALL_DIR}" ]]; then
    echo "`date +\"%F %T\"` [INFO] DE service variable DEPLOYMENT_INSTALL_DIR is not set. Default value '/opt/DE' will be used."
    DEPLOYMENT_INSTALL_DIR="/opt/DE"
fi

echo "`date +\"%F %T\"` [INFO] Starting DE AUTH server..."
exec ${JAVA_HOME}/jre/bin/java -Dloader.path=$DEPLOYMENT_INSTALL_DIR  -Djavax.net.ssl.trustStorePassword=dataelicit@01 -Djavax.net.ssl.trustStore=$DEPLOYMENT_INSTALL_DIR/de.truststore  -cp $DEPLOYMENT_INSTALL_DIR/app.jar org.springframework.boot.loader.PropertiesLauncher



