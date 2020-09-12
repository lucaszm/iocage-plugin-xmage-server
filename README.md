# XMage - Magic, Another Game Engine
This plugin jail will host an XMage server on your FreeBSD system.
XMage is an Open-Source _Magic: The Gathering_ game engine that allows you to play Magic against one or more online players or computer opponents.  

To play a game, you need to download the client application from http://xmage.de/ and connect to your server.
For more info, see https://github.com/magefree/mage

## To install this plugin
Download the plugin manifest file to your local file system.
```
fetch https://raw.githubusercontent.com/jsegaert/iocage-my-plugins/master/xmage-server.json
```
Install the plugin.  Adjust network settings as desired.  
```
iocage fetch -P xmage-server.json -n xmage-server 
```

