FROM nginx:latest

RUN mkdir -p /var/www

RUN chown -R www-data:www-data /var/www

RUN chmod 755 /var/www

RUN useradd -u 1003 webdev -G www-data

WORKDIR /var/www
