import 'dart:async';

import 'package:flutter/services.dart';

class FlutterNativeSharedPreferences {
  static const MethodChannel _channel =
      const MethodChannel('flutter_native_shared_preferences');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<Map<String, dynamic>> get portfolioName async {
    final Map<String, dynamic> response = await _channel.invokeMethod('getPortfolioName');
    return response;
  }
}
