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
