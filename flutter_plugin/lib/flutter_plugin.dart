import 'dart:async';

import 'package:flutter/services.dart';

class WifiType {
    String SSID;
    String capabilities;
    int centerFreq0;
    int centerFreq1;
    int channelWidth;
    int frequency;
    int level;
    String operatorFriendlyName;
    int timestamp;
    String venueName;

    WifiType(dynamic obj) {
      SSID = obj['SSID'];
      capabilities = obj['capabilities'];
      centerFreq0 = obj['centerFreq0'];
      centerFreq1 = obj['centerFreq1'];
      channelWidth = obj['channelWidth'];
      frequency = obj['frequency'];
      level = obj['level'];
      operatorFriendlyName = obj['operatorFriendlyName'];
      timestamp = obj['timestamp'];
      venueName = obj['venueName'];
    }

}

class FlutterPlugin {
  static const MethodChannel _channel =
      const MethodChannel('flutter_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<bool> connectToWifi(String ssid, String password) async {

    final bool isConnected = await _channel.invokeMethod('connectToWifi', <String, dynamic>{"ssid" : ssid, "password" : password});
    return isConnected;
  }


  static Future<List<WifiType>> getWifiList() async {
    final List<dynamic> wifiList = await _channel.invokeMethod('getWifiList');
    List<WifiType> toRet = [];
    for (dynamic tmp in wifiList) {
      toRet.add(WifiType(tmp));
    }
    return toRet;
  }

//  static Future<bool> get connectWithWifi async {
//    return true;
//  }

  static Future<bool> isConnectedToWifi(String ssid) async {
    final bool isConnected = await _channel.invokeMethod('isConnectedToWifi');
    return isConnected;
  }


}
