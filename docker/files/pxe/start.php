<?php

    $itworksmsg = <<<EOT
#!ipxe

set menu-timeout 60000

cpuid --ext 29 && set arch x64 || set arch x86
cpuid --ext 29 && set archl amd64 || set archl i386

:start
echo
echo
menu It works!
item --gap --        tftpd/nginx/php/iPXE is configured correctly!
item --gap --        Please mount of folder onto the /tftpboot/pxe folder inside the
item --gap --        docker container to specify the provide of pxe booting options
item
item --key x exit    Exit iPXE and continue normal boot
choose selected
goto \${selected}

:exit
exit

EOT;

    header('Content-Type: application/octet-stream');
    print($itworksmsg);
?>
