#!/bin/sh
#
#  Copyright (C) 2018 Alexander Petrovskiy <alexpe@mellanox.com>
#
#  SPDX-License-Identifier: GPL-2.0
#
#  Script to pack Linux OS image file (ISO, IMG, etc.) into ONIE installer
#

INSTDIR=./installers
DEFINST=ubuntu18xx-iso
DATE=`date +%Y%m%d`
ONIEIMG="onie-installer-x86_64-${DATE}.bin"

usage() {
        echo "Usage: $0 [-i installer] os_image"
        echo "  Supported installers:"
        for file in ./installers/*; do
            inst=`basename $file`
            if [ "$inst" = "$DEFINST" ]; then
	            echo "  - `basename $file` [default]"
            else
                echo "  - `basename $file`"
            fi
        done
        exit
}

fail() {
    [ "$1" != "" ] && echo $1
    exit 1
}

[ -d $INSTDIR ] || fail "Installers dir not found: $INSTDIR"

if [ $# -lt 1 ]; then
    usage
elif [ $# -eq 1 ]; then
    INSTALLER=$DEFINST
    OSIMG=$1
elif [ $# -eq 3 ] && [ "$1" = "-i"  ]; then
    INSTALLER=$2
    OSIMG=$3
else
    usage
fi

INSTPATH="$INSTDIR/$INSTALLER"
[ -f $INSTPATH ] || fail "Unsupported installer: $INSTALLER"
[ -f $OSIMG ] || fail "OS image is not available: $OSIMG"

echo "== Installer selected: $INSTALLER"
echo "== Packing OS image: $OSIMG"
cp -f $INSTPATH $ONIEIMG
echo >> $ONIEIMG
cat "$OSIMG" >> $ONIEIMG
echo "== ONIE installer is ready: $ONIEIMG (`du -sh $ONIEIMG | awk '{ print $1 }'`)"
