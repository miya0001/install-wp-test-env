#!/usr/bin/env bash
# order: wordpress_test root 'wordpress' localhost latest

DB_NAME=${1-wordpress_test}
DB_USER=${2-root}
DB_PASS=${3-''}
DB_HOST=${4-localhost}
WP_VERSION=${5-latest}
#SKIP_DB_CREATE=${6-false}

# set DB_PASS with -p argument to send it mysql command if set DB_PASS
if [ -z "${DB_PASS}" ]; then
  # "empty" might be connect by socket
  DB_PASS_ARG=''
else
  DB_PASS_ARG='-p'${DB_PASS}
fi

set -ex;

echo 'DROP DATABASE IF EXISTS '${DB_NAME}';' | mysql -u ${DB_USER} -h ${DB_HOST} ${DB_PASS_ARG}

if [ -e /tmp/wordpress ]; then
    rm -fr /tmp/wordpress
fi

if [ -e /tmp/wordpress-tests-lib ]; then
    rm -fr /tmp/wordpress-tests-lib
fi

bash bin/install-wp-tests.sh ${DB_NAME} ${DB_USER} ${DB_PASS} ${DB_HOST} ${WP_VERSION};
