import 'dart:async';

import 'package:flutter/services.dart';
import 'package:rc_im_custom_plugin/rc_im_custom_method_key.dart';

class RcImCustomPlugin {
  static const MethodChannel _channel =
      const MethodChannel('rc_im_custom_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static void registerRedPackMessage() async {
    print("registerRedPackMessage");
    Map resultMap = await _channel.invokeMethod(
      RCIMCustomMethodKey.RegisterMessage_RedPack,
    );
    print(resultMap);
  }

  static Future<void> sendRedPackMessage(
      int conversationType,
      String targetId,
      String id,
      String type,
      String payType,
      String remark,
      String pushContent,
      String pushData,
      String userId,
      String name,
      String portraitUrl) async {
    Map map = {
      "conversationType": conversationType,
      "targetId": targetId,
      "id": id,
      "type": type,
      "payType": payType,
      "pushContent": pushContent,
      "pushData": pushData,
      "userId": userId,
      "name": name,
      "remark": remark,
      "portraitUrl": portraitUrl,
    };
    Map resultMap = await _channel.invokeMethod(
        RCIMCustomMethodKey.SendMessage_RedPack, map);
    print(resultMap);
  }

  static void registerTransferMessage() {
    _channel.invokeMethod(RCIMCustomMethodKey.RegisterMessage_Transfer, null);
  }

  static Future<void> sendTransferMessage(
      int conversationType,
      String targetId,
      String amount,
      String content,
      String payType,
      String remark,
      String pushContent,
      String pushData,
      String userId,
      String name,
      String portraitUrl) async {
    Map map = {
      "conversationType": conversationType,
      "targetId": targetId,
      "content": content,
      "amount": amount,
      "payType": payType,
      "pushContent": pushContent,
      "pushData": pushData,
      "userId": userId,
      "name": name,
      "remark": remark,
      "portraitUrl": portraitUrl,
    };
    Map resultMap = await _channel.invokeMethod(
        RCIMCustomMethodKey.SendMessage_Transfer, map);
    print(resultMap);
  }
}
