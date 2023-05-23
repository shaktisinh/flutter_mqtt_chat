# flutter_mqtt_chat

A Flutter MQTT project.

## Getting Started Steps

1. Add permissions to AndroidManifest.xml
   <uses-permission android:name="android.permission.INTERNET" />
   <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

2. Add below to Info.plist
   <key>NSLocalNetworkUsageDescription</key>
   <string>Looking for local tcp Bonjour service</string>
   <key>NSBonjourServices</key>
   <array>
   <string>mqtt.tcp</string>
   </array>
   
3. Add dependency to pubspec.yaml
   mqtt_client: ^9.8.1 
   // visit https://pub.dev/packages/mqtt_client to latest version
