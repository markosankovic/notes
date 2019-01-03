# SOMANET

## Motor Configs

https://github.com/synapticon/somanet_software/tree/develop/sc_somanet_sdk/configuration_parameters/motor_configs

## ESI

Split ESI file into parts for storing onto slaves:

    $ zip - SOMANET_CiA_402.xml | split -b 9000 -a 3 -d - SOMANET_CiA_402.xml.zip.part

**TODO**: How to write ESI files to flash.

## Firmware

Install firmware:

    $ sudo ethercat states -p 0 BOOT
    $ sudo ethercat -p 0 foe_write firmware_ComEtherCAT-a_CoreC2X-a_Drive1000-d1_v3.2.0-rc4.bin

## Bootloader

* https://github.com/synapticon/somanet_bootloader/releases
* https://github.com/synapticon/somanet_software/blob/develop/sc_somanet_sdk/somanet_base/module_board-support/targets/SOMANET-CoreC2X.xn

The following command will clear flash which means it will delete the previously installed SDK:

    $ xflash --erase-all --target-file SOMANET-CoreC2X.xn

Install bootloader:

    $ xflash --write-all app_SOMANET_bootloader-CoreC2X-ECAT-UART.bin --target-file SOMANET-CoreC2X.xn --boot-partition 0x90000

Check if bootloader is installed:

    $ ethercat state -p 1 BOOT
    $ ethercat slave
    1 0:1 INIT E SOMANET CiA402 Drive

If the command above doesn't change slave state to BOOT and C2X has GREEN LED on only and no blink, then it means that no bootloader is installed.

## Stack Info

Download [build_stack_info_json.py] and then:

    $ sudo python3 build_stack_info_json.py --mac f48e38d6e68a --stack_serial_number=0123-12-9876543-1817 --board "Core C2X" "A.4" 1111-11-1111111-1111 --board "Drive 1000" "D.2" 2222-22-2222222-2222 --board "Com EtherCAT" "B.1" 3333-33-3333333-3333
    
    [INFO] Started on 2018-06-05 at 11:20:47
    [INFO] Logging to /home/marko/github:synapticon/somanet_bootloader/tools/stack_info_0123-12-9876543-1817.log
    [INFO] MAC: f4:8e:38:d6:e6:8a
    [INFO] Stack Serial: 0123-12-9876543-1817
    [INFO] Com EtherCAT revision B.1 with SN 3333-33-3333333-3333
    [INFO] Core C2X revision A.4 with SN 1111-11-1111111-1111
    [INFO] Drive 1000 revision D.2 with SN 2222-22-2222222-2222
    [INFO] {"mac_address": 268891676141194, "stack_serial_number": "0123-12-9876543-1817", "boards": [{"description": "Core C2X", "serial_number": "1111-11-1111111-1111", "revision": "A.4"}, {"description": "Drive 1000", "serial_number": "2222-22-2222222-2222", "revision": "D.2"}, {"description": "Com EtherCAT", "serial_number": "3333-33-3333333-3333", "revision": "B.1"}]}
    File stack_info.json unlocked

The command above will write stack_info.json file to flash, read the file with the following command:

```
$ sudo ethercat foe_read stack_info.json

{
  "mac_address": 268891676141194,
  "stack_serial_number": "0123-12-9876543-1817"
  "boards": [{
    "description": "Core C2X",
    "serial_number": "1111-11-1111111-1111",
    "revision": "A.4"
  }, {
    "description": "Drive 1000",
    "serial_number": "2222-22-2222222-2222",
    "revision": "D.2"
  }, {
    "description": "Com EtherCAT",
    "serial_number": "3333-33-3333333-3333",
    "revision": "B.1"
  }]
}
```

[build_stack_info_json.py]: https://github.com/synapticon/sw_somanet-firmware/blob/develop/tools/build_stack_info_json.py

## Update Motion Master with the latest test version

    $ wget -O - https://synapticon-tools.s3.amazonaws.com/motion-master/test/update_motion_master.sh | bash

## File Over EtherCAT

    $ ethercat foe_read fs-getlist
    $ ethercat foe_read fs-remove
    $ ethercat foe_read stack_info.json

## Compiling and Running

    xmake -j DRIVE_BOARD=Drive1000-rev-d.bsp
    make release clean
    make distclean
    make release package

`somanet_software/sw_applications/app_motion_drive` is the main application.
