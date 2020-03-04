https://www.youtube.com/watch?v=zVLKPtGCtN4

https://jumpnowtek.com/rpi/Raspberry-Pi-Systems-with-Yocto.html

```
git clone git://git.yoctoproject.org/poky

git checkout -t origin/zeus

git clone git://git.yoctoproject.org/meta-raspberrypi

source oe-init-build-env

  You had no conf/local.conf file. This configuration file has therefore been
  created for you with some default values. You may wish to edit it to, for
  example, select a different MACHINE (target hardware). See conf/local.conf
  for more information as common configuration options are commented.

  You had no conf/bblayers.conf file. This configuration file has therefore been
  created for you with some default values. To add additional metadata layers
  into your configuration please add entries to conf/bblayers.conf.

  The Yocto Project has extensive documentation about OE including a reference
  manual which can be found at:
      http://yoctoproject.org/documentation

  For more information about OpenEmbedded see their website:
      http://www.openembedded.org/


  ### Shell environment set up for builds. ###

  You can now run 'bitbake <target>'

  Common targets are:
      core-image-minimal
      core-image-sato
      meta-toolchain
      meta-ide-support

  You can also run generated qemu images with a command like 'runqemu qemux86'

vim build/conf/bblayers.conf

  # POKY_BBLAYERS_CONF_VERSION is increased each time build/conf/bblayers.conf
  # changes incompatibly
  POKY_BBLAYERS_CONF_VERSION = "2"

  BBPATH = "${TOPDIR}"
  BBFILES ?= ""

  BBLAYERS ?= " \
    /home/marko/learn/poky/meta \
    /home/marko/learn/poky/meta-poky \
    /home/marko/learn/poky/meta-yocto-bsp \
    /home/marko/learn/poky/meta-raspberrypi \
    "

vim build/conf/local.conf

  MACHINE ??= "raspberrypi3"
  GPU_MEM = "16"

cd meta-raspberrypi
git checkout -t origin/zeus

cd ../build/
bitbake rpi-basic-image

```
