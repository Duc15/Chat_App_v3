import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallPage extends StatelessWidget {
  const CallPage(
      {Key? key,
      required this.callID,
      required this.userID,
      required this.username})
      : super(key: key);
  final String callID;
  final String userID;
  final String username;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID:
          1927416788, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign:
          "2a75cc24eed10577933e1ebc8e8205ce4e5b4abfda8c2ee29a7c89a0bf1d401c", // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: userID,
      userName: username,
      callID: callID,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
        ..onOnlySelfInRoom = (context) => Navigator.of(context).pop(),
    );
  }
}
