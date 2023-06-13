# Wombat OS-Builder

This repository contains scripts and a environment configuration to build KIPR software for the Wombat.

Note 1: All scripts in this programm should exclusively be executed from the workspace root folder inside the devcontainer (typically ```/workspaces/osbuilder```). If done differently, files might not be found.

Note 2: When using a linux host, clone this repo to an ext4 partition. It will not work if it is on a partition with another filesystem (especially if it doesn't support symlinks)

Sources:
 - Building Qt6 for RPiOS: https://wiki.qt.io/Cross-Compile_Qt_6_for_Raspberry_Pi


## Files
 - prepare_raspi.bash: installs deps no rapsberry pi
 - qt6_local_build.bash: copies sysroot from pi and builds qt6 host and pi version in local container