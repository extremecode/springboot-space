#!/bin/sh

if [[ -z "${DEPLOYMENT_INSTALL_DIR}" ]]; then
    echo "`date +\"%F %T\"` [INFO] DE service variable DEPLOYMENT_INSTALL_DIR is not set. Default value '/opt/DE' will be used."
    DEPLOYMENT_INSTALL_DIR="/opt/DE"
fi

echo "`date +\"%F %T\"` [INFO] Setting server SSL properties."
echo "security.require-ssl=true
server.ssl.protocol=TLS
server.ssl.enabled-protocols=TLSv1.3,TLSv1.2
server.ssl.ciphers=TLS_AES_256_GCM_SHA384,TLS_CHACHA20_POLY1305_SHA256,TLS_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
server.ssl.key-store=$DEPLOYMENT_INSTALL_DIR/de.keystore
server.ssl.keyAlias=de
server.ssl.keyStoreType=PKCS12
server.ssl.key-store-password=dataelicit@01

server.ssl.key-store-type=PKCS12
server.ssl.trust-store-type=PKCS12
server.ssl.trust-store=$DEPLOYMENT_INSTALL_DIR/de.truststore
server.ssl.trust-store-password=dataelicit@01
server.ssl.enabled=true" >> $DEPLOYMENT_INSTALL_DIR/application.properties

