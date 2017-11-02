#!/usr/bin/env bash
# order: wordpress_test root 'wordpress' localhost latest

DB_NAME=wordpress_test
DB_USER=root
DB_PASS=''
DB_HOST=localhost
WP_VERSION=${1-latest}
#SKIP_DB_CREATE=${6-false}

TMPDIR=${TMPDIR-/tmp}
TMPDIR=$(echo $TMPDIR | sed -e "s/\/$//")
WP_TESTS_DIR=${WP_TESTS_DIR-$TMPDIR/wordpress-tests-lib}
WP_CORE_DIR=${WP_CORE_DIR-$TMPDIR/wordpress/}

# set DB_PASS with -p argument to send it mysql command if set DB_PASS
if [ -z "${DB_PASS}" ]; then
  # "empty" might be connect by socket
  DB_PASS_ARG=''
else
  DB_PASS_ARG='-p'${DB_PASS}
fi

set -ex;

echo 'DROP DATABASE IF EXISTS '${DB_NAME}';' | mysql -u ${DB_USER} -h ${DB_HOST} ${DB_PASS_ARG}

if [ -e $WP_CORE_DIR ]; then
    rm -fr $WP_CORE_DIR
fi

if [ -e $WP_TESTS_DIR ]; then
    rm -fr $WP_TESTS_DIR
fi

bash bin/install-wp-tests.sh "${DB_NAME}" "${DB_USER}" "${DB_PASS}" "${DB_HOST}" "${WP_VERSION}";
