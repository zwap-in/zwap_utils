/// IMPORTING THIRD PARTY PACKAGES
import 'dart:developer' as developer;

import 'package:flutter/cupertino.dart';

/// IMPORTING LOCAL PACKAGES
import 'package:zwap_utils/zwap_utils/interface/currentState.dart';

/// It manages the state on native devices
class CurrentStateNative extends CurrentState{

  @override
  String getFullPath() {
    throw UnimplementedError();
  }

  @override
  String getCurrentOrigin(){
    throw UnimplementedError();
  }

  @override
  String? findSubDomain(String protocol, String currentDomain){
    throw UnimplementedError();
  }

  @override
  void globalCallMethod(String method, List args) {
    // TODO: implement globalCallMethod
  }

  @override
  void pushHistoryState(String screenName, String args){
    /// TODO: implement globalCallMethod
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

  @override
  void configureApp(){
    throw UnimplementedError();
  }

  @override
  String buildArgs(Map<String, String> args) {
    throw UnimplementedError();
  }

  @override
  Map<String, String> getArgs() {
    throw UnimplementedError();
  }

  @override
  String? currentPath(){
    throw UnimplementedError();
  }

}