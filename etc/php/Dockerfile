FROM php:7.4-fpm

#RUN apt-get update
#
#RUN apt-get install -y zlib1g-dev libzip-dev curl unzip ssh iproute2 \
#    && docker-php-ext-install pdo_mysql zip opcache
#
#RUN pecl install xdebug-2.9.2 \
#    && pecl install imagick \
#    && docker-php-ext-enable xdebug \
#    && docker-php-ext-enable imagick


RUN set -ex; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		imagemagick \
#		less \
#		mariadb-client msmtp \
#		libc-client-dev \
#		libfreetype6-dev \
#		libjpeg-dev \
#		libjpeg62-turbo-dev \
#		libkrb5-dev \
#		libmagickwand-dev \
#		libmcrypt-dev \
#		libmemcached-dev \
#		libxml2-dev \
#		libpng-dev \
        iproute2 \
        curl \
		libzip-dev \
        libssl-dev \
		unzip \
		vim \
		zip

# Install PHP Extensions
RUN pecl install imagick; \
    pecl install xdebug-2.9.2; \
    docker-php-ext-install imap; \
    docker-php-ext-install pdo pdo_mysql; \
    docker-php-ext-install opcache; \
    docker-php-ext-install soap; \
    docker-php-ext-install zip; \
    docker-php-ext-install gettext; \
    docker-php-ext-install exif; \
	docker-php-ext-enable imagick mcrypt redis; \
	docker-php-ext-install bcmath; \
	docker-php-ext-enable xdebug; \
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	rm -rf /var/lib/apt/lists/*;

RUN docker-php-ext-install pcntl

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

#RUN sed -i 's/:9000/:5001/' /usr/local/etc/php-fpm.d/zz-docker.conf

RUN echo "$(ip route | awk 'NR==1 {print $3}') host.docker.internal" >> /etc/host

RUN chown -R www-data:www-data /var/www

RUN chmod 755 /var/www

RUN useradd -u 1003 webdev -G www-data

COPY start.sh /usr/local/bin/start

RUN chmod u+x /usr/local/bin/start

WORKDIR /var/www

CMD ["/usr/local/bin/start"]
