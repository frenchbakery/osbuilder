#!/bin/bash

WORKSPACE=$PWD
RMHOST="192.168.4.43"
RMUSER="access"

SYSROOT=$WORKSPACE/rpi-sysroot
#QTFOLDER=$WORKSPACE/qt5

QTHOSTBUILD=$WORKSPACE/qt-host-build
QTPIBUILD=$WORKSPACE/qt-raspi-build
QTHOSTBIN=$WORKSPACE/qt-host
QTPIBIN=$WORKSPACE/qt-raspi

TOOLCHAIN=$WORKSPACE/toolchain.cmake