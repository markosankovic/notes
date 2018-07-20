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

## /etc/systemd/network/wired.network
    [Match]
    Name=enp2s0

    [Network]
    DHCP=ipv4
    IPForward=yes
    IPMasquerade=yes

## /etc/systemd/network/wireless.network
    [Match]
    Name=wl*

    [Network]
    DHCPServer=yes

    [Address]
    Address=192.168.0.1/24
    Broadcast=192.168.0.255

    [DHCPServer]
    PoolOffset=10
    PoolSize=10
    EmitDNS=yes
    DNS=8.8.8.8
    DNS=8.8.4.4
    DefaultLeaseTimeSec=600
    MaxLeaseTimeSec=7200

## /etc/wpa_supplicant/wpa_supplicant-wlx7cdd90d6ff9a.conf
    ap_scan=2

    network = {
        ssid="oblac-drives"
        mode=2
        key_mgmt=NONE
        frequency=2437
    }

Enable wpa_supplicant for interface

    $ sudo systemctl enable wpa_supplicant@wlx7cdd90d6f9a.service

## /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg
    network: {config: disabled}

Remove everything from `/etc/netplan/`.

## /etc/ufw/sysctl.conf

Uncomment

    net/ipv4/ip_forward=1

## Disable wait online service

Use

    $ systemctl disable systemd-networkd-wait-online.service
    
to disable the wait-online service to prevent the system from waiting on a network connection, and use

    $ systemctl mask systemd-networkd-wait-online.service

to prevent the service from starting if requested by another service (the service is symlinked to /dev/null).

## /etc/ufw/before.rules

Add the following to the top of the file just after the header comments

    # NAT table rules
    *nat
    :POSTROUTING ACCEPT [0:0]
    
    # Forward traffic from enp2s0
    -A POSTROUTING -s 192.168.0.0/24 -o enp2s0 -j MASQUERADE
    
    # don't delete the 'COMMIT' line or these rules won't be processed
    COMMIT

Disable and re-enable ufw to apply the changes:

    $ sudo ufw disable && sudo ufw enable

## netplan

### /etc/netplan/60-wifi.yml
    nework:
        wifis:
            wlx7cdd90d6ff9a:
                access-points:
                    "synapticon-guest":
                        password: "webui..."
                addresses: []
                dhcp4: true
                optional: true
        version: 2

### /etc/netplan/50-cloud-init.yaml
    # This file is generated from information provided by
    # the datasource. Changes to it will not persist across an instance.
    # To disable cloud-init's network configuration capabilities, write a file
    # /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
    # network: {config: disabled}
    network:
        ethernets:
            enp2s0
                addresses: []
                dhcp4: true
                optional: true
        version: 2

    $ netplan apply

## journal -xe

Running `$ journal -xe` will show any errors with wpa_supplicant and netplan.

## Steps

Install Ubuntu Server, use *ubuntu* for username and password, *oblac-drives* for hostname.

    $ sudo su
    $ rm /etc/netplan/*
    $ vim /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg
    network: {config: disabled}
    $ netplan generate && netplan apply
    $ vim /etc/systemd/network/wired.network
    [Match]
    Name=enp2s0

    [Network]
    DHCP=ipv4
    $ vim /etc/systemd/network/wireless.network
    [Match]
    Name=wl*

    [Network]
    DHCPServer=yes

    [Address]
    Address=192.168.0.1/24
    Broadcast=192.168.0.255

    [DHCPServer]
    PoolOffset=10
    PoolSize=10
    EmitDNS=yes
    DNS=8.8.8.8
    DNS=8.8.4.4
    DefaultLeaseTimeSec=600
    MaxLeaseTimeSec=7200
    $ apt install wpasupplicant
    $ networkctl | awk '/wlan/ {print $2}'
    wlx7cdd90d6ff9a
    $ vim /etc/wpa_supplicant/wpa_supplicant-wlx7cdd90d6ff9a.conf
    ap_scan=2

    network = {
        ssid="oblac-drives"
        mode=2
        key_mgmt=NONE
        frequency=2437
    }
    $ systemctl enable wpa_supplicant@wlx7cdd90d6f9a.service
    $ systemctl disable systemd-networkd-wait-online.service
    $ systemctl mask systemd-networkd-wait-online.service
    $ vim /etc/ufw/before.rules
    # NAT table rules
    *nat
    :POSTROUTING ACCEPT [0:0]

    # Forward traffic from enp2s0
    -A POSTROUTING -s 192.168.0.0/24 -o enp2s0 -j MASQUERADE

    # don't delete the 'COMMIT' line or these rules won't be processed
    COMMIT
    
    ...
    $ vim /etc/default/ufw
    DEFAULT_INPUT_POLICY="ACCEPT"
    DEFAULT_FORWARD_POLICY="ACCEPT"
    $ vim /etc/ufw/sysctl.conf
    net/ipv4/ip_forward=1
    $ ufw disable && sudo ufw enable
    $ reboot

## Links

- https://help.ubuntu.com/lts/serverguide/firewall.html#ip-masquerading
- https://forum.manjaro.org/t/how-to-use-systemd-networkd-to-manage-your-wifi/1557
- https://wiki.gentoo.org/wiki/Hostapd
- https://bbs.archlinux.org/viewtopic.php?pid=1393759#p1393759
- https://askubuntu.com/questions/972215/a-start-job-is-running-for-wait-for-network-to-be-configured-ubuntu-server-17-1
- https://askubuntu.com/questions/802643/port-forwarding-with-dnat-not-working
- https://unix.stackexchange.com/questions/361558/difference-between-systemd-wpa-supplicant-service-and-wpa-supplicantwlan0-servi
- https://wiki.archlinux.org/index.php/WPA_supplicant
- https://linuxcommando.blogspot.com/2013/10/how-to-connect-to-wpawpa2-wifi-network.html
- https://www.itzgeek.com/how-tos/linux/ubuntu-how-tos/netplan-how-to-configure-static-ip-address-in-ubuntu-18-04-using-netplan.html
