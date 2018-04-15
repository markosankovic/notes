# SOMANET

## ESI

Split ESI file into parts for storing onto slaves:

    $ zip - SOMANET_CiA_402.xml | split -b 9000 -a 3 -d - SOMANET_CiA_402.xml.zip.part

**TODO**: How to write ESI files to flash.

## Firmware

Install firmware:

    $ sudo ethercat states -p 0 BOOT
    $ sudo ethercat -p 0 foe_write firmware_ComEtherCAT-a_CoreC2X-a_Drive1000-d1_v3.2.0-rc4.bin

## Bootloader

The following command will clear flash which means it will delete the previously installed SDK:

    $ xflash --erase-all --target-file SOMANET-CoreC2X.xn

Install bootloader:

    $ xflash --write-all app_SOMANET_bootloader-CoreC2X-ENET_b1-UART.bin --target-file SOMANET-CoreC2X.xn --boot-partition-size 0x90000

Check if bootloader is installed:

    $ ethercat state -p 1 BOOT
    $ ethercat slave
    1 0:1 INIT E SOMANET CiA402 Drive

If the command above doesn't change slave state to BOOT and C2X has GREEN LED on only and no blink, then it means that no bootloader is installed.

## Stack Info

Download [build_stack_info_json.py] and then:

    $ sudo python3 build_stack_info_json.py --mac ABCDEF --board "Core C2X" "A.4" 11111 --board "Drive 1000" "D.2" 22222 --board "COM EtherCAT" "B.1" 33333
    $ sudo ethercat foe_read stack_info.json
    
[build_stack_info_json.py]: https://github.com/synapticon/sw_somanet-firmware/blob/develop/tools/build_stack_info_json.py
