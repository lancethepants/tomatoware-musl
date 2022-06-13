#!/bin/bash

set -e
set -x

export BASE=`pwd`
export SRC=$BASE/src

BUILDROOTVER="git"
TOOLCHAINDIR="/opt/tomatoware/$DESTARCH-$FLOAT-musl-1.1.24"


if [ ! -d /opt/tomatoware ]; then

	sudo mkdir -p /opt/tomatoware
	sudo chmod -R 777 /opt/tomatoware
fi

if [ ! -f $TOOLCHAINDIR/bin/$DESTARCH-linux-gcc ]; then
	mkdir $BASE/toolchain
	tar xvJf $SRC/toolchain/buildroot-${BUILDROOTVER}.tar.xz -C $BASE/toolchain
#	patch -d $BASE/toolchain/buildroot-${BUILDROOTVER} -p1 < $PATCHES/buildroot/buildroot.patch
	cp $SRC/toolchain/defconfig.$DESTARCH $BASE/toolchain/buildroot-${BUILDROOTVER}/defconfig
	cp -r $SRC/toolchain/patches $BASE/toolchain
	mv $BASE/toolchain/patches/linux-headers.$DESTARCH $BASE/toolchain/patches/linux-headers
	cd $BASE/toolchain/buildroot-${BUILDROOTVER}
	make defconfig BR2_DEFCONFIG=defconfig
	make
fi
