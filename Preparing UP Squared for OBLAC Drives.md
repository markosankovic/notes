# Preparing UP Squared for OBLAC Drives

Using the USB wireless dongle Laptone 300mbps WPS with AAEON UP Squared.

    $ networkctl
    IDX LINK             TYPE          OPERATIONAL SETUP
      1 lo               loopback      carrier     unmanaged
      2 enp2s0           ether         off         unmanaged
      3 enp3s0           ether         no-carrier  configuring
      4 wlx7cdd90d6ff9a  wlan          no-carrier  unmanaged
    
    4 links listed.

Ubuntu 18.04 uses [Netplan](https://netplan.io/) that either works with [NetworkManager](https://help.ubuntu.com/community/NetworkManager) or [Systemd-networkd](http://manpages.ubuntu.com/manpages/bionic/man5/systemd.network.5.html). From the Netplan documentation:


> mode (scalar)
> Possible access point modes are infrastructure (the default), ap (create an access point to which other devices can connect), and adhoc (peer to peer networks without a central access point). **ap is only supported with NetworkManager**.

NetworkManager uses a lot of resources. Alternative systemd-networkd does not natively support wifi, so you need wpasupplicant installed if you let the networkd renderer handle wifi.

    $ sudo apt install wpasupplicant

Get the WiFi name:

    $ networkctl | awk '/wlan/ {print $2}'
    wlx7cdd90d6ff9a

Connect to WiFi AP with systemd-networkd and wpa_supplicant:

    $ sudo wpa_passphrase my_ssid my_pass >> /etc/wpa_supplicant/wpa_supplicant-wlx7cdd90d6ff9a.conf
    $ sudo cat /etc/wpa_supplicant/wpa_supplicant-wlx7cdd90d6ff9a.conf
    network={
        ssid="my_ssid"
        #psk="my_pass"
        psk=12345678901234567809876543aaccddeeff
    }
    $ sudo vim /etc/systemd/network/wireless.network
    [Match]
    Name=wlx7cdd90d6ff9a
    
    [Network]
    DHCP=yes

Get device capabilities:

    $ iw list

## /etc/wpa_supplicant/wpa_supplicant-wlx7cdd90d6ff9a.conf

    ap_scan=2

    network = {
        ssid="oblac-drives"
        mode=2
        key_mgmt=NONE
        frequency=2437
    }

## Disable wait online service

Use

    $ systemctl disable systemd-networkd-wait-online.service
    
to disable the wait-online service to prevent the system from waiting on a network connection, and use

    $ systemctl mask systemd-networkd-wait-online.service

to prevent the service from starting if requested by another service (the service is symlinked to /dev/null).

## Links

https://forum.manjaro.org/t/how-to-use-systemd-networkd-to-manage-your-wifi/1557
https://wiki.gentoo.org/wiki/Hostapd
https://bbs.archlinux.org/viewtopic.php?pid=1393759#p1393759
https://askubuntu.com/questions/972215/a-start-job-is-running-for-wait-for-network-to-be-configured-ubuntu-server-17-1


