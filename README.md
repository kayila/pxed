# PXEd: a Docker-based PXE server

**NOTE:** I (@duckinator) have no idea what I am doing and @kayila has left
me unattended, so parts of this may be hilariously inaccurate.

This setup is designed to build and run a Docker container which contains
a fully-configured PXE server.

It runs a TFTP server and HTTP server (nginx). Your DHCP server should be
configured to chainload iPXE's `undionly.kpxe` (examples for dd-wrt and
pfsense are below).

PXEd builds a custom version of `undionly.kpxe`, which includes a script
that chainloads `tftp://<IP the TFTP server is on>/next.ipxe`.

This `next.ipxe` script then chainloads `http://<IP the TFTP server is on>/`.
This means you can just do everything with nginx and PHP scripts. :)

The web root for nginx is `/tftpboot/pxe` inside the Docker container.
The default setup (using `make run`; see the Makefile for details) will
mount `./imageprep/pxeoverlay` at this location.

## DHCP, PXE, launching yourself into the sun for your own sanity, etc

In order for this to work, the DHCP server needs to be have the dhcp-boot
parameter pointed at the docker container and set to the `undionly.kpxe`
boot image.

### Configuration for pfSense

TODO: Figure this out?

### Configuration for dd-wrt

Below is an example of this configuration line for dd-wrt.

Note for dd-wrt, this must go into DNSMasq additional options, NOT DHCP.

```
dhcp-boot=undionly.kpxe,pxebootcontainer,192.168.1.114
```

## Build

To build the container, run `make`.

## Run

To run a basic server to test PXE Boot functionality, run `make demo`

To run a server with all the images available, simply run `make run`.

## Startup

NGINX will look for the start file in the following order:

* index.php
* start.php
* index.ipxe
* start.ipxe

## Advanced Usage

### Modifying the startup behavior

The kpxe file which is served to the booting client has a script embedded,
which tells it to load `next.ipxe` from the same tftp server which the
image is loaded from. This is done to allow chain booting into another file.

The provided `next.ipxe` is configured to chain boot to a web server running
on the same IP. In typical usage, this is the embedded nginx server,
which allows you to use PHP scripts to create a more complex system.

If this behavior needs to be changed, then `kpxeprep/bootstrap/checktftp.ipxe`
may be modified to change where it looks to for the next script, and
`files/next.ipxe` can be modified to change the next.

It is unlikely that you'll need to change `checktftp.ipxe`.
However, changing `next.ipxe` can be useful if e.g. the web server runs on
a different machine or port.

In order to rebuild the kpxe binary with `checktftp.ipxe` included, run
`build.sh` from inside the kpxeprep folder.

### HTTPS

While iPXE can support HTTPS, the version used by default in this package
does not.

The reason for this is due to the way that iPXE handles the trust chain for
HTTPS certs. If you need to use this feature, you can compile a custom
version of undionly.kpxe which supports it.

Please see https://ipxe.org/crypto for information explaining the details of this feature.

## License
This code is licenced under the MIT License. See the included LICENSE
file for details.
