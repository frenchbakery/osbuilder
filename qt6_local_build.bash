#!/bin/bash

# load variables
. env.bash

cd $WORKSPACE

mkdir $SYSROOT $SYSROOT/usr $SYSROOT/opt
mkdir $QTHOSTBIN $QTHOSTBUILD $QTPIBUILD

read

# install local deps
sudo apt-get update
sudo apt-get install make build-essential libclang-dev ninja-build gcc git bison python3 gperf pkg-config libfontconfig1-dev libfreetype6-dev libx11-dev libx11-xcb-dev libxext-dev libxfixes-dev libxi-dev libxrender-dev libxcb1-dev libxcb-glx0-dev libxcb-keysyms1-dev libxcb-image0-dev libxcb-shm0-dev libxcb-icccm4-dev libxcb-sync-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-randr0-dev libxcb-render-util0-dev libxcb-util-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev libatspi2.0-dev libgl1-mesa-dev libglu1-mesa-dev freeglut3-dev
sudo apt install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu symlinks

read

# copy sysroot
rsync -avz --rsync-path="sudo rsync" --delete "$RMUSER"@"$RMHOST":/lib "$SYSROOT"
rsync -avz --rsync-path="sudo rsync" --delete "$RMUSER"@"$RMHOST":/usr/include "$SYSROOT"/usr
rsync -avz --rsync-path="sudo rsync" --delete "$RMUSER"@"$RMHOST":/usr/lib "$SYSROOT"/usr
rsync -avz --rsync-path="sudo rsync" --delete "$RMUSER"@"$RMHOST":/opt/vc "$SYSROOT"/opt

read

# fix symlinks in sysroot
symlinks -rc "$SYSROOT"

read

# build qt for host
git clone "https://codereview.qt-project.org/qt/qt5"
cd qt5/
git checkout 6.4.0
perl init-repository -f
cd ..
read
cd $QTHOSTBUILD
cmake ../qt5/ -GNinja -DCMAKE_BUILD_TYPE=Release -DQT_BUILD_EXAMPLES=OFF -DQT_BUILD_TESTS=OFF -DCMAKE_INSTALL_PREFIX=$QTHOSTBIN
cmake --build . --parallel 8
cmake --install .

read

# build qt for raspi
cd $QTPIBUILD
cmake ../qt5/ -GNinja -DCMAKE_BUILD_TYPE=Release -DINPUT_opengl=es2 -DQT_BUILD_EXAMPLES=OFF -DQT_BUILD_TESTS=OFF -DQT_HOST_PATH=$QTHOSTBIN -DCMAKE_STAGING_PREFIX=$QTPIBIN -DCMAKE_INSTALL_PREFIX=/usr/local/qt6 -DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN -DQT_QMAKE_TARGET_MKSPEC=devices/linux-rasp-pi4-aarch64 -DQT_FEATURE_xcb=ON -DFEATURE_xcb_xlib=ON -DQT_FEATURE_xlib=ON
