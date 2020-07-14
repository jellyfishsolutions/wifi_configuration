package com.example.wifi_configuration;

import java.util.HashMap;

public class WifiType {
    String SSID;
    String capabilities;
    int centerFreq0;
    int centerFreq1;
    int channelWidth;
    int frequency;
    int level;
    String operatorFriendlyName;
    long timestamp;
    String venueName;


    public HashMap<String, Object> toMap() {
        HashMap<String, Object> tmp = new HashMap();
        tmp.put("SSID", SSID);
        tmp.put("capabilities", capabilities);
        tmp.put("centerFreq0", centerFreq0);
        tmp.put("centerFreq1", centerFreq1);
        tmp.put("frequency", frequency);
        tmp.put("level", level);
        tmp.put("operatorFriendlyName", operatorFriendlyName);
        tmp.put("timestamp", timestamp);
        tmp.put("venueName", venueName);
        return tmp;
    }
}