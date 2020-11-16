#!/usr/bin/env bash

set -e

role=${CONTAINER_ROLE:-app}
env=${APP_ENV:-production}
workdir=${WORKDIR:-/var/www/vhosts}
artisan=${WORKDIR}/artisan

if [ "$role" = "app" ]; then

    exec php-fpm

elif [ "$role" = "queue" ]; then

    echo "Queue role"
    php $artisan horizon
    exit 1

elif [ "$role" = "scheduler" ]; then

    echo "Scheduler role"
    while [ true ]
    do
      php $artisan schedule:run --verbose --no-interaction &
      sleep 60
    done

else
    echo "Could not match the container role \"$role\""
    exit 1
fi