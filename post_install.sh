#!/bin/sh

CONFIG_URL=http://xmage.de/xmage/config.json 
INSTALL_DIR=/usr/local/games/xmage
USER_NAME=xmage
USER_UID=1200

# Create user
pw useradd -n $USER_NAME -u $USER_UID -G games -d /nonexistent -w random

# Download XMAGE
mkdir -p $XMAGEDIR
cd $XMAGEDIR
fetch $URL_XMAGE -o "config.json"

FETCH_URL=`jq -r '.XMage.location' config.json`
FETCH_FILE=`basename $FETCHURL`

fetch $FETCH_URL
tar xf $FETCH_FILE mage-server/ 
rm  $FETCH_FILE
chown -R xmage:xmage .

cd mage-server
chmod +x startServer.sh
sed -i '' 's/$//' startServer.sh


