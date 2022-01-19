/// IMPORTING THIRD PARTY PACKAGES
import 'package:flutter/material.dart';

/// It manages the current device with some utils functions
abstract class CurrentState{

  /// call global method on current device with custom args
  void globalCallMethod(String method, List<dynamic> args);

  /// It retrieves the full path of the current location
  String getFullPath();

  /// It retrieves the current origin for the current location
  String getCurrentOrigin();

  /// It retrieves the current subDomain
  String? findSubDomain(String protocol, String currentDomain);

  /// It pushes the history paths state
  void pushHistoryState(String name, String args);

  /// It goes to another screen with optionally custom args
  void goToScreen(String name, BuildContext context, Map<String, String>? args);

  /// It goes to another screen reloading the page
  void openScreen(String url);

  /// It goes back to the previous page
  void goBack(BuildContext context);

  /// Open external url
  void openExternalUrl(String newUrl);

  /// Configure app url strategy
  void configureApp();

  /// It builds the args string from a dictionary
  String buildArgs(Map<String, String> args);

  /// It gets the args from the current web location
  Map<String, String> getArgs();

  /// It gets the current path
  String? currentPath();

  /// It gets the sub domain
  String? getSubDomain();

  /// It gets the current domain
  String? getCurrentDomain();
}