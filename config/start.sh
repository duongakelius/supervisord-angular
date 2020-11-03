#!/usr/bin/env sh

##### Configmap script #####

set -e


SUPERVISORD_CONFIG_FILE="/etc/supervisord.conf"

ls -la $SUPERVISORD_CONFIG_FILE

whoami

echo "start supervisor.d using config file: $SUPERVISORD_CONFIG_FILE"
/usr/bin/supervisord -n -c ${SUPERVISORD_CONFIG_FILE}
