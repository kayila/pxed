<?php
  $entries[] = array(
    "key" => "bionicsrvamd64",
    "title" => "Install Ubuntu server Bionic amd64 (With preseed)",
    "body" => <<<BODY
kernel /images/ubuntu-installer/bionic-updates/amd64/linux
initrd /images/ubuntu-installer/bionic-updates/amd64/initrd.gz
imgargs linux auto=true preseed/url=http://pxeserver.fox/preseed/ubuntu-installer/bionic/amd64/server.preseed
BODY
    );
?>
