FROM ubuntu:22.04

RUN set -eux ; \
  apt-get update ; \
  apt-get upgrade -y

RUN set -eux ; \
  apt-get update ; \
  apt-get install -y --no-install-recommends \
  build-essential git curl ca-certificates

RUN set -eux ; \
  apt-get update ; \
  apt-get install -y --no-install-recommends \
  build-essential cmake pkgconf libusb-1.0-0-dev libuvc-dev

RUN set -eux  ; \
  mkdir /asdf ; cd /asdf ; \
  git clone https://github.com/steve-m/hsdaoh.git ; \
  mkdir hsdaoh/build ; \
  cd hsdaoh/build ; \
  cmake ../ -DINSTALL_UDEV_RULES=ON ; \
  make -j $(nproc) ; \
  make install ; \
  ldconfig ; \
  rm -rf /asdf

RUN set -eux ; \
  apt-get update ; \
  apt-get install -y --no-install-recommends \
  libflac-dev

RUN set -eux ; \
  mkdir /asdf ; cd /asdf ; \
  git clone https://github.com/Stefan-Olt/MISRC.git

RUN set -eux ; \
  cd /asdf/MISRC/misrc_tools ; \
  mkdir build ; cd build ; \
  cmake .. ; \
  make
