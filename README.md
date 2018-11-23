# iocage-plugin-xmage
Artifact file(s) for XMage iocage plugin 

This plugin jail will host an XMage server.  To play a game, you need to download the client application from http://xmage.de/ and connect to your server.
For more info, see https://github.com/magefree/mage

## To install this plugin
Download the plugin manifest file to your local file system.
```
fetch https://raw.githubusercontent.com/jsegaert/iocage-my-plugins/master/xmage-server.json
```
Install the plugin.  Adjust host interface and IP address as needed.  
```
iocage fetch -P -n xmage-server.json ip4_addr="em0|192.168.0.100/24"
```

