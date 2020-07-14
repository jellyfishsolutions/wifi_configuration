import 'dart:async';

import 'package:flutter/services.dart';

enum WifiConnectionStatus {
  connected,
  alreadyConnected,
  notConnected,
  platformNotSupported,
  profileAlreadyInstalled,
  locationNotAllowed,
}

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

class WifiConfiguration {
  static const MethodChannel _channel =
      const MethodChannel('wifi_configuration');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');

    return version;
  }

  static Future<WifiConnectionStatus> connectToWifi(
      String ssid, String password, String packageName) async {
    final String isConnected = await _channel.invokeMethod(
        'connectToWifi', <String, dynamic>{
      "ssid": ssid,
      "password": password,
      "packageName": packageName
    });
    switch (isConnected) {
      case "connected":
        return WifiConnectionStatus.connected;
        break;

      case "alreadyConnected":
        return WifiConnectionStatus.alreadyConnected;
        break;

      case "notConnected":
        return WifiConnectionStatus.notConnected;
        break;

      case "platformNotSupported":
        return WifiConnectionStatus.platformNotSupported;
        break;

      case "profileAlreadyInstalled":
        return WifiConnectionStatus.profileAlreadyInstalled;
        break;

      case "locationNotAllowed":
        return WifiConnectionStatus.locationNotAllowed;
        break;
    }
  }

  static Future<List<WifiType>> getWifiList() async {
    final List<dynamic> wifiList = await _channel.invokeMethod('getWifiList');
    List<WifiType> toRet = [];
    for (dynamic tmp in wifiList) {
      toRet.add(WifiType(tmp));
    }
    return toRet;
  }

  static Future<bool> isConnectedToWifi(String ssid) async {
    final bool isConnected = await _channel
        .invokeMethod('isConnectedToWifi', <String, dynamic>{"ssid": ssid});
    return isConnected;
  }

  static Future<String> connectedToWifi() async {
    final String connectedWifiName =
        await _channel.invokeMethod('connectedToWifi');
    return connectedWifiName;
  }
}
