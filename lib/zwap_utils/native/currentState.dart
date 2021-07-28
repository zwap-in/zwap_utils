/// IMPORTING THIRD PARTY PACKAGES
import 'dart:developer' as developer;

import 'package:flutter/cupertino.dart';

/// IMPORTING LOCAL PACKAGES
import 'package:zwap_utils/zwap_utils/interface/currentState.dart';

/// It manages the state on native devices
class CurrentStateNative extends CurrentState{

  @override
  String getCurrentLocation() {
    // TODO: implement getCurrentLocation
    throw UnimplementedError();
  }

  @override
  void globalCallMethod(String method, List args) {
    // TODO: implement globalCallMethod
  }

  @override
  void goToScreen(String screenName, BuildContext context, Map<String, String>? args){
    developer.log("Changing screen to $screenName");
    Navigator.pushReplacementNamed(context, "/$screenName");
  }

  @override
  void openExternalUrl(String newUrl){
    throw UnimplementedError();
  }

}