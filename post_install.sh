#!/bin/sh

CONFIG_URL=http://xmage.de/xmage/config.json 
INSTALL_DIR=/usr/local/games/xmage
USER_NAME=xmagesvr
USER_UID=1201

# Create user
pw useradd -n $USER_NAME -u $USER_UID -G games -d /nonexistent -s /usr/sbin/nologin -w no

# Download XMAGE
mkdir -p $INSTALL_DIR
cd $INSTALL_DIR
fetch $CONFIG_URL -o "config.json"

FETCH_URL=`jq -r '.XMage.location' config.json`
FETCH_FILE=`basename $FETCH_URL`

fetch $FETCH_URL
tar xf $FETCH_FILE mage-server/ 

# File cleanup
rm  $FETCH_FILE
chown -R $USER_NAME:$USER_NAME .

cd mage-server
chmod +x startServer.sh
sed -i '' 's/$//' startServer.sh

for file in `ls config`; do
  sed -i '' 's/$//' ./config/$file
done

# parse the java command
JAVA_CMD=$(awk '/^java/{print}' ./startServer.sh)
JAVA_JAR=$(echo $JAVA_CMD | awk -F ' -jar ' '{print $2}')
JAVA_OPT=$(echo $JAVA_CMD | awk '{ for (i=2; i <= NF; i++) {
                                     if ($i =="-jar") break;
                                     if ($i ~ "^-Xmx" || $i ~ "^-Xms" || $i ~ "-XX:MaxPermSize") continue;
                                     print $i," "
                                     }
                                 }' )

# Enable & start the service
sysrc -f /etc/rc.conf xmageserver_enable="YES"
sysrc -f /etc/rc.conf xmageserver_jvmxms="-Xms256M"
sysrc -f /etc/rc.conf xmageserver_jvmxmx="-Xmx1024M"
sysrc -f /etc/rc.conf xmageserver_javacmd+=" $JAVA_JAR"
sysrc -f /etc/rc.conf xmageserver_javaopt+=" $JAVA_OPT"

service xmageserver start
