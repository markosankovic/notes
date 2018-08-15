# Ubuntu 18.04 on Dell XPS 15 9570

## NVIDIA GeForce GTX 1050 Ti Max-Q GPU

Open Software & Updates / Additiona Drivers and select Using Nvidia driver metapackage from nvidia-driver-390(proprietary, tested).
Open NVIDIA X Server Settings / PRIMER Profiles and select Intel (Power Saving Mode).
Follow [Ubuntu 18.04 prime-select intel is not powering off the nvidia card](https://github.com/stockmind/dell-xps-9560-ubuntu-respin/issues/8). Install powertop and check the battery discharge rate while idle, it should be below 10 W. If not, then enable [this service](https://github.com/stockmind/dell-xps-9560-ubuntu-respin/blob/master/services/gpuoff.service) and put `GRUB_CMDLINE_LINUX_DEFAULT="quiet acpi_rev_override=1 i915.modeset=1 nouveau.modeset=0 nvidia-drm.modeset=1"` into `/etc/default/grub`, then run `$ sudo update-grub`. This `nvidia-drm.modeset=1` fixes the screen tearing.

## Initial Configuration

    $ sudo update-alternatives --config editor
    $ sudo visudo
    marko ALL=(ALL) NOPASSWD: ALL

Settings / Region & Language / Add an Input Source.
Settings / Online Accounts / Google.
Settings / Privacy / Screen Lock.
