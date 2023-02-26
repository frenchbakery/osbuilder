#!/bin/bash

# load variables
. env.bash

cd $WORKSPACE

# prepare raspberry pi 
echo "$RMUSER"@"$RMHOST"
ssh -t "$RMUSER"@"$RMHOST" "mkdir -p Documents/qt6"
scp -r $WORKSPACE/remote_files/qt6_prepare.bash "$RMUSER"@"$RMHOST":Documents/qt6/qt6_prepare.bash
ssh -t "$RMUSER"@"$RMHOST" "Documents/qt6/qt6_prepare.bash"
