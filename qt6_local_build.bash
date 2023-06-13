#!/bin/bash

# load variables
. env.bash

cd $WORKSPACE

#mkdir -p $SYSROOT/usr $SYSROOT/opt
##mkdir -p $QTHOSTBIN $QTHOSTBUILD $QTPIBIN $QTPIBUILD
#
##read
#
## install local deps
##sudo apt-get update
##sudo apt-get install make build-essential libclang-dev ninja-build gcc git bison python3 gperf pkg-config libfontconfig1-dev libfreetype6-dev libx11-dev libx11-xcb-dev libxext-dev libxfixes-dev libxi-dev libxrender-dev libxcb1-dev libxcb-glx0-dev libxcb-keysyms1-dev libxcb-image0-dev libxcb-shm0-dev libxcb-icccm4-dev libxcb-sync-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-randr0-dev libxcb-render-util0-dev libxcb-util-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev libatspi2.0-dev libgl1-mesa-dev libglu1-mesa-dev freeglut3-dev
##sudo apt-get install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu symlinks
##sudo apt-get install freeglut3 freeglut3-dev binutils-gold libglew-dev mesa-common-dev libglew1.5-dev libglm-dev libgles2-mesa-dev xorg-dev
#
##exit
#
#echo "done install deps"
#read
#
## copy sysroot
#rsync -avz --rsync-path="sudo rsync" --delete "$RMUSER"@"$RMHOST":/lib "$SYSROOT"
#rsync -avz --rsync-path="sudo rsync" --delete "$RMUSER"@"$RMHOST":/usr/include "$SYSROOT"/usr
#rsync -avz --rsync-path="sudo rsync" --delete "$RMUSER"@"$RMHOST":/usr/lib "$SYSROOT"/usr
#rsync -avz --rsync-path="sudo rsync" --delete "$RMUSER"@"$RMHOST":/opt/vc "$SYSROOT"/opt
#
##exit
#
#echo "done sysroot copy"
#read
#
## fix symlinks in sysroot
#symlinks -rc "$SYSROOT"

echo "done symlinks"
read

# build qt for host
#git clone "https://codereview.qt-project.org/qt/qt5"
#cd qt5/
#git checkout 6.4.0
#perl init-repository -f
#cd ..
#read
#cd $QTHOSTBUILD
#cmake ../qt5/ -GNinja -DCMAKE_BUILD_TYPE=Release -DQT_BUILD_EXAMPLES=OFF -DQT_BUILD_TESTS=OFF -DCMAKE_INSTALL_PREFIX=$QTHOSTBIN
#cmake --build . --parallel 4
#cmake --install .

echo "done installing host"
read

# build qt for raspi
cd $QTPIBUILD
#cmake ../qt5/ -GNinja -DCMAKE_BUILD_TYPE=Release -DINPUT_opengl=es2 -DQT_BUILD_EXAMPLES=OFF -DQT_BUILD_TESTS=OFF -DQT_HOST_PATH=$QTHOSTBIN -DCMAKE_STAGING_PREFIX=$QTPIBIN -DCMAKE_INSTALL_PREFIX=/usr/local/qt6 -DQT_FEATURE_opengles2=ON -DQT_FEATURE_opengles3=ON -DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN -DQT_QMAKE_TARGET_MKSPEC=devices/linux-rasp-pi4-aarch64 -DQT_FEATURE_xcb=ON -DFEATURE_xcb_xlib=ON -DQT_FEATURE_xlib=ON
../qt5/configure -no-opengl -release -opengl es2 -nomake examples -skip qtwebengine -nomake tests -qt-host-path $QTHOSTBIN -extprefix $QTPIBIN -prefix /usr/local/qt6 -device linux-rasp-pi4-aarch64 -device-option CROSS_COMPILE=aarch64-linux-gnu- -- -DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN -DQT_FEATURE_xcb=ON -DFEATURE_xcb_xlib=ON -DQT_FEATURE_xlib=ON

cmake --build . --parallel 4
cmake --install .