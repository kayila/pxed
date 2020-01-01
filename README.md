# Docker based PXE server backend
This setup is designed to build a docker container which contains all the requrired bits to do a pxe booting server with an embedded nginx web server (configured to work with a self-contained php as well)

In order for this to work, the DHCP server needs to be have the dhcp-boot parameter pointed at the docker container and set to the `undionly.kpxe` boot image. An example of this configuration line is shown here for dd-wrt. (Note for dd-wrt, this must go into DNSMasq additional options, NOT DHCP.
```
dhcp-boot=undionly.kpxe,pxebootcontainer,192.168.1.114
```

## Build
To build the container, it's as simple as:
```
docker build . -t pxe
```

## Run
To setup a simple server to test for PXE Booting capability, simply run the container
```
docker run -it --rm -p 80:80 -p 69:69/udp --name pxe pxe
```

In actual use, you'll probably want to mount a replacement for the /tftpboot/pxe folder which is served by nginx in order to provide custom boot images.
```
docker run -it --rm -p 80:80 -p 69:69/udp --name pxe -v $(pwd)/imageprep/pxeoverlay:/tftpboot/pxe pxe
```
NGINX will look for the start file in the following order:
* index.php
* start.php
* index.html
* start.html
* index.htm
* start.htm
* index.ipxe
* start.ipxe

## Advanced Usage
### Modifying the startup behavior
The kpxe file which this machine serves to the booting client has a script embedded which tells it to load `next.ipxe` from the same tftp server which the image is loaded from. This is done to allow chain booting into another file. As currently checked in, `next.ipxe` is configured to chain boot to a web server running in this docker container which contains the more complex, dynamically configurable suite of scripts. If this behavior needs to be changed, then `kpxeprep/bootstrap/checktftp.ipxe` may be modified to change where it looks to for the next script, and `files/next.ipxe` can be modified to change what it does next. It is unlikely that you'll need to change `checktftp.ipxe`, however changing `next.ipxe` can be useful if, for example, the web server runs on a different machine or port.

In order to rebuild the kpxe binary with `checktftp.ipxe` included, run `build.sh` from inside the kpxeprep folder.

### HTTPS
While iPXE can support HTTPS, the version used by default in this package does not. The reason for this is due to the way that iPXE handles the trust chain for HTTPS certs. If you need to use this feature, you can compile a custom version of undionly.kpxe which supports it, please see https://ipxe.org/crypto for information explaining the details of this feature.

## Possible features still planned:
* Make `next.ipxe` dynamically configurable via env var
* Create scripts to automatically populate/create some base images (memtest+, clonezilla, gparted, PING, etc)

## License
This code is licenced under the MIT License. See the included LICENSE
file for details
