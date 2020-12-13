FROM nginx:1.13.9-alpine

# Install tftpd
# http://forum.alpinelinux.org/apk/main/x86_64/tftp-hpa
RUN apk add --no-cache tftp-hpa

RUN apk add --no-cache php7-fpm

EXPOSE 69/udp 80

RUN adduser -D tftp

# Support clients that use backslash instead of forward slash.
COPY files/mapfile /tftpboot/

# Add the ipxe boot image and next.ipxe script for chain booting to NGINX
COPY files/undionly.kpxe /tftpboot/
COPY files/next.ipxe /tftpboot/

# Add NGINX & PHP configs
COPY files/nginx.conf /etc/nginx/nginx.conf
COPY files/php-fpm.conf /etc/php7/php-fpm.conf

# Add script to start everything up
COPY files/run.sh /run.sh

# Add safe defaults that can be overriden easily.
COPY files/pxe /tftpboot/pxe/

# Do not track further change to /tftpboot/pxe
VOLUME /tftpboot/pxe

# Run the script
ENTRYPOINT ["/run.sh"]
