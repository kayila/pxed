#!/bin/sh

echo "Starting tftp server"
in.tftpd -L --verbose -m /tftpboot/mapfile -u tftp --secure /tftpboot &

echo "Starting php"
php-fpm7

echo "Starting NGINX"
nginx
