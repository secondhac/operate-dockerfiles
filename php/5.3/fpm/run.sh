#!/bin/bash

variables=( "PHP_FPM_PORT" "PHP_ERROR_REPORTING" "ENVIRONMENT" )

for var in "${variables[@]}"
do
   :
   sed -i "s|%$var%|${!var}|g" /etc/php5/fpm/php-fpm.conf
done
sed -i "s|%SMTP_SERVER%|$SMTP_SERVER|g" /etc/ssmtp/ssmtp.conf
sed -i "s|%ROOT_EMAIL%|$ROOT_EMAIL|g" /etc/ssmtp/ssmtp.conf

if [ ! -z $PHP_FPM_GID ]; then
    groupmod -g $PHP_FPM_GID www-data
fi

if [ ! -z $PHP_FPM_UID ]; then
    usermod -u $PHP_FPM_UID www-data
fi

/usr/sbin/php5-fpm -c /etc/php5/fpm
