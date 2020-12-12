<?php
  $fedora_version = "33";

  $entries[] = array(
    "key" => "fedora${fedora_version}amd64",
    "title" => "Install Fedora ${fedora_version} amd64",
    "body" => <<<BODY
kernel /images/fedora-installer/${fedora_version}/amd64/vmlinuz
initrd /images/fedora-installer/${fedora_version}/amd64/initrd.img
imgargs vmlinuz initrd=initrd.img inst.repo=https://dl.fedoraproject.org/pub/fedora/linux/releases/33/Everything/x86_64/os
BODY
  );
?>
