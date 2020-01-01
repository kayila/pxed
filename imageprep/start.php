<?php
  header("Content-Type: text/plain");
  print("#!ipxe\n");

  $ip = "INSERT_IP_ADDRESS";
  $port = 80;

  $baseurl = "http://{$ip}:{$port}/";

  $entries = array();

  foreach (scandir("entries") as $filename) {
    $path = "entries/" . $filename;
    if (is_file($path) && substr_compare($path, ".php", -4, 4, true) == 0) {
      require $path;
    }
  }
?>

set menu-timeout 0
set submenu-timeout 0

# Yea, I don't remember why these are needed. Good luck.
cpuid --ext 29 && set arch x64 || set arch x86
cpuid --ext 29 && set archl amd64 || set archl i386

:start
echo Booting iPXE from NGINX
echo
menu iPXE boot menu for ${initiator-iqn}
item --gap -- Operating systems
<?php
  foreach( $entries as $entry ) {
    printf("item %s %s\n", $entry["key"], $entry["title"]);
  }
?>
item
item --key x exit Exit iPXE and continue normal boot
choose selected
goto ${selected}

<?php
  foreach( $entries as $entry ) {
    print(":" . $entry["key"] . "\n");
    printf("echo Selected %s\n", $entry["title"]);
    print($entry["body"]);
    print("\n");
    print("boot\ngoto start\n");
  }
?>

