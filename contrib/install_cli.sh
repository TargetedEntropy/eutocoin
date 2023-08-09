 #!/usr/bin/env bash

 # Execute this file to install the eutocoin cli tools into your path on OS X

 CURRENT_LOC="$( cd "$(dirname "$0")" ; pwd -P )"
 LOCATION=${CURRENT_LOC%EutoCoin-Qt.app*}

 # Ensure that the directory to symlink to exists
 sudo mkdir -p /usr/local/bin

 # Create symlinks to the cli tools
 sudo ln -s ${LOCATION}/EutoCoin-Qt.app/Contents/MacOS/eutocoind /usr/local/bin/eutocoind
 sudo ln -s ${LOCATION}/EutoCoin-Qt.app/Contents/MacOS/eutocoin-cli /usr/local/bin/eutocoin-cli
