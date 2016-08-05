#!/bin/bash

DB_NAME="drupal"
DB_TYPE="mysql"
DB_HOST="localhost"
DB_USER="root"
DB_PASSWORD=""
DB_URL="${DB_TYPE}://${DB_USER}:${DB_PASSWORD}@${DB_HOST}/${DB_NAME}"

echo "Found Drush: `which drush`"
echo "Found Composer: `which composer`"
echo "Found NPM: `which npm`"
echo "Found Rsync: `which rsync`"

composer install
cd docroot
drush site-install biiir --account-pass=admin --db-url=$DB_URL
drush config-set system.performance css.preprocess 0 --yes --format=boolean
drush config-set system.performance js.preprocess 0 --yes --format=boolean
drush config-set system.logging error_level all --yes

if [ $VERSION != "HEAD" ]; then
drush cache-rebuild
drush updatedb --yes
fi