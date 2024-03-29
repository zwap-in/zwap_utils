/// IMPORTING THIRD PARTY PACKAGES
import 'dart:developer' as developer;

import 'dart:html' as html;
import 'dart:js' as js;

import 'package:flutter/cupertino.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

/// IMPORTING LOCAL PACKAGES
import 'package:zwap_utils/zwap_utils/interface/currentState.dart';

/// It manages the current state for the web devices
class CurrentStateWeb extends CurrentState {
  @override
  String getFullPath() {
    return html.window.location.href;
  }

  @override
  String getCurrentOrigin() {
    return html.window.location.origin;
  }

  @override
  String? findSubDomain(String protocol, String currentDomain) {
    String currentOrigin = this.getCurrentOrigin();
    String result = currentOrigin.split(protocol)[1].split(currentDomain)[0].split(".")[0];
    if (result.trim() != "") {
      return result;
    }
  }

  @override
  void globalCallMethod(String method, List args) {
    return js.context.callMethod(method, args);
  }

  @override
  String buildArgs(Map<String, String> args) {
    String queryArgs = "";
    queryArgs += "?";
    args.forEach((key, value) {
      queryArgs += "$key=$value&";
    });
    queryArgs = queryArgs.substring(0, queryArgs.length - 1);
    return queryArgs;
  }

  @override
  Map<String, String> getArgs() {
    String currentUrl = this.getFullPath();
    Map<String, String> finalParams = {};
    List<String> params = currentUrl.split("?");
    if (params.length > 1 && params[1].isNotEmpty) {
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
  void pushHistoryState(String screenName, String args) {
    html.window.history.pushState("", "", "$screenName$args");
  }

  @override
  void goToScreen(String name, BuildContext context, Map<String, String>? args) {
    developer.log("Changing screen to $name");
    String screenArgs = args != null ? this.buildArgs(args) : "";
    this.pushHistoryState(name, screenArgs);
    Navigator.pushReplacementNamed(context, name);
  }

  @override
  void openExternalUrl(String newUrl) {
    this.globalCallMethod("open", [newUrl]);
  }

  @override
  void openScreen(String newUrl) {
    html.window.location.href = newUrl;
  }

  @override
  void configureApp() {
    setUrlStrategy(PathUrlStrategy());
  }

  @override
  String? currentPath() {
    return html.window.location.pathname;
  }

  @override
  String? getSubDomain() {
    return html.window.location.host.split('.').length > 1 ? html.window.location.host.split('.')[0] : null;
  }

  @override
  String? getCurrentDomain() {
    return html.window.location.hostname;
  }

  @override
  void goBack(BuildContext context) {
    developer.log("Go to the previous screen");
    html.window.history.back();
  }

  @override
  void removeQueryArgs() {
    String currentUrl = html.window.location.href;
    String afterDomain = currentUrl.substring(currentUrl.lastIndexOf("/") + 1);
    String beforeQueryString = afterDomain.split("?")[0];
    html.window.history.pushState({}, html.document.title, "/$beforeQueryString");
  }
}
