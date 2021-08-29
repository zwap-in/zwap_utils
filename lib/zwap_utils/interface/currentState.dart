/// IMPORTING THIRD PARTY PACKAGES
import 'package:flutter/material.dart';

/// It manages the current device with some utils functions
abstract class CurrentState{

  /// call global method on current device with custom args
  void globalCallMethod(String method, List<dynamic> args);

  /// It retrieves the current screen location
  String getCurrentLocation();

  /// It goes to another screen with optionally custom args
  void goToScreen(String name, BuildContext context, Map<String, String>? args);

  /// Open external url
  void openExternalUrl(String newUrl);

  /// Configure app url strategy
  void configureApp();
}