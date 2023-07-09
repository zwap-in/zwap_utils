/// IMPORTING THIRD PARTY PACKAGES
import 'dart:developer' as developer;

import 'package:flutter/cupertino.dart';

/// IMPORTING LOCAL PACKAGES
import 'package:zwap_utils/zwap_utils/interface/currentState.dart';

/// It manages the state on native devices
class CurrentStateNative extends CurrentState {
  void _warningLog() {
    developer.log("⚠️ \x1B[33mThis methods has not been implemented yet\x1B[0m");
  }

  @override
  String getFullPath() {
    _warningLog();
    return "";
  }

  @override
  String getCurrentOrigin() {
    _warningLog();
    return "";
  }

  @override
  String? findSubDomain(String protocol, String currentDomain) {
    _warningLog();
    return null;
  }

  @override
  void globalCallMethod(String method, List args) {
    _warningLog();
  }

  @override
  void pushHistoryState(String screenName, String args) {
    _warningLog();
  }

  @override
  void goToScreen(String screenName, BuildContext context, Map<String, String>? args) {
    developer.log("Changing screen to $screenName");
    Navigator.pushReplacementNamed(context, "/$screenName");
  }

  @override
  void goBack(BuildContext context) {
    developer.log("Going back");
    Navigator.pop(context);
  }

  @override
  void openExternalUrl(String newUrl) {
    _warningLog();
  }

  @override
  void openScreen(String newUrl) {
    _warningLog();
  }

  @override
  void configureApp() {
    _warningLog();
  }

  @override
  String buildArgs(Map<String, String> args) {
    _warningLog();
    return "";
  }

  @override
  Map<String, String> getArgs() {
    _warningLog();
    return {};
  }

  @override
  String? currentPath() {
    _warningLog();
    return null;
  }

  @override
  String? getSubDomain() {
    _warningLog();
    return null;
  }

  @override
  String? getCurrentDomain() {
    _warningLog();
    return null;
  }

  void removeQueryArgs() {
    _warningLog();
  }
}
