/// IMPORTING THIRD PARTY PACKAGES
import 'dart:developer' as developer;

import 'dart:html' as html;
import 'dart:js' as js;

import 'package:flutter/cupertino.dart';

/// IMPORTING LOCAL PACKAGES
import 'package:zwap_utils/zwap_utils/interface/currentState.dart';

/// It manages the current state for the web devices
class CurrentStateWeb extends CurrentState{

  @override
  String getCurrentLocation() {
    return html.window.location.href;
  }

  @override
   void globalCallMethod(String method, List args) {
    return js.context.callMethod(method, args);
  }

  /// It parse a map inside a string args
  String buildArgs(Map<String, String> args){
    String queryArgs = "";
    queryArgs += "?";
    args.forEach((key, value) {
      queryArgs += "$key=$value&";
    });
    queryArgs = queryArgs.substring(0, queryArgs.length - 1);
    return queryArgs;
  }

  /// It retrieves the args from the current location inside in a map
  Map<String, String> getArgs(){
    String currentUrl = this.getCurrentLocation();
    Map<String, String> finalParams = {};
    List<String> params = currentUrl.split("?");
    if(params.length > 1){
      params = params[1].split("&");
      params.forEach((element) {
        List<String> tmpElements = element.split("=");
        String key = tmpElements[0];
        String value = tmpElements[1];
        finalParams[key] = value;
      });
    }
    return finalParams;
  }

  @override
  void goToScreen(String name, BuildContext context, Map<String, String>? args){
    developer.log("Changing screen to $name");
    String screenArgs = args != null ? this.buildArgs(args) : "";
    html.window.history.pushState("", "", "$name$screenArgs");
    Navigator.pushReplacementNamed(context, "/$name$screenArgs");
  }

  @override
  void openExternalUrl(String newUrl){
    return this.globalCallMethod('open', [newUrl]);
  }

}