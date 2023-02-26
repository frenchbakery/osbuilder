# Wombat OS-Builder

This repository contains scripts and a environment configuration to build KIPR software for the Wombat.

Note: All scripts in this programm should exclusively be executed from the workspace root folder inside the devcontainer (typically ```/workspaces/osbuilder```). If done differently, files might not be found.


Sources:
 - Building Qt6 for RPiOS: https://wiki.qt.io/Cross-Compile_Qt_6_for_Raspberry_Pi


## Files
 - prepare_raspi.bash: installs deps no rapsberry pi
 - qt6_local_build.bash: copies sysroot from pi and builds qt6 host and pi version in local container