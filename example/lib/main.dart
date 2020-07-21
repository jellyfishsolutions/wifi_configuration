import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import 'package:wifi_configuration/wifi_configuration.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

//enum wifiStatus {
//  conected,
//alreadyConnected,.
//notConnected ,
//platformNotSupported,
//profileAlreadyInstalled,
//
//}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    getConnectionState();
  }


  void testConnection() async {
    final result = await http.get("http://192.168.5.1:8888");
    print("result: ${result.body}");
  }

  void getConnectionState() async {
    var listAvailableWifi = await WifiConfiguration.getWifiList();
    for (final tmp in listAvailableWifi) {
      print("${tmp.SSID} - ${tmp.level}");
    }
    WifiConnectionStatus connectionStatus = await WifiConfiguration.connectToWifi(
        "Powahome-a020a6222a3eR", "", "com.example.wifi_configuration_example");
    print("is Connected 2: ${connectionStatus}");
//
//
    switch (connectionStatus) {
      case WifiConnectionStatus.connected:
        print("connected");
        break;

      case WifiConnectionStatus.alreadyConnected:
        print("alreadyConnected");
        break;

      case WifiConnectionStatus.notConnected:
        print("notConnected");
        break;

      case WifiConnectionStatus.platformNotSupported:
        print("platformNotSupported");
        break;

      case WifiConnectionStatus.profileAlreadyInstalled:
        print("profileAlreadyInstalled");
        break;

      case WifiConnectionStatus.locationNotAllowed:
        print("locationNotAllowed");
        break;
    }
//
//    bool isConnected = await WifiConfiguration.isConnectedToWifi("DBWSN5");
    // String connectionState = await WifiConfiguration.connectedToWifi();
    //   print("coneection status ${connectionState}");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: FlatButton(
            color: Colors.red,
            child: Text("connect"),
            onPressed: () async {
              WifiConnectionStatus connectionStatus = await WifiConfiguration.connectToWifi(
                  "Powahome-a020a6222a3eR",
                  "",
                  "com.example.wifi_configuration_example");
              print("is Connected 3: ${connectionStatus}");
              testConnection();
            },
          ),
        ),
      ),
    );
  }
}
