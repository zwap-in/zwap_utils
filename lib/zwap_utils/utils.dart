/// IMPORTING THIRD PARTY PACKAGES
import 'dart:io';
import 'dart:math';
import 'package:quiver/iterables.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'interface/currentState.dart';
import 'native/factoryNative.dart' if (dart.library.html) 'web/factoryWeb.dart';

import 'translate.dart';
import 'constants.dart';
import 'icons.dart';

/// Utilities class functions
class Utils {
  static CurrentState? _instance;

  @visibleForTesting
  static set instance(CurrentState value) => _instance = value;

  /// It retrieves the current state in base of current device
  static CurrentState get currentState => _instance ??= getCurrentState();

  /// It retrieves the GetIt instance
  static GetIt get getIt => GetIt.instance;

  /// Utils function to copy on clipboard dynamic text
  static Future<void> copy(String text) async {
    if (text.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: text));
    }
  }

  /// Utils function to retrieve the color hex value from a Color value
  static String colorString(Color color) {
    String colorString = color.toString();
    String valueString = colorString.split('(0x')[1].split(')')[0];
    return "#$valueString";
  }

  /// Utils function to evaluate the number from custom string
  static int evalNumber(String text) {
    return int.tryParse(text) ?? -1;
  }

  /// Utils function to validate a regex with a dynamic value and a string
  static bool validateRegex(String regexString, dynamic value) {
    return RegExp(regexString).hasMatch(value.toString());
  }

  /// Utils function to retrieve the date string format from a DateTime object
  static String getDateString(DateTime datetime) {
    return "${datetime.day} - ${Constants.monthlyName()[datetime.month]} - ${datetime.year}";
  }

  /// Utils function to register any T instance with GetIt
  static void registerType<T extends Object>(T instance) {
    if (Utils.getIt.isRegistered<T>()) {
      Utils.getIt.unregister<T>();
    }
    Utils.getIt.registerFactory<T>(() => instance);
  }

  /// Utils function to retrieve the dynamic translated text in base of any key
  ///
  /// If [arguments] is provided all the keyworks will be substituted, for example:
  /// if string 'foo' is "This is my {{adjective}} string! {{after_string}}".
  ///
  /// Providing `{"adjective": "Awesome", "after_string": "Save this post"}` as arguments,
  /// (with [key] == 'foo!)
  /// will return "This is my awesome string! Save this post"
  ///
  /// [arguments] have dynamic as type of value! Be carefull, .toString() will be called
  /// to the object if it isn't already a String
  ///
  /// If [replaceAll] is true all the occurences will be replaced, only the first one instead
  static String translatedText(String key, {Map<String, dynamic>? arguments, bool replaceAll = false}) {
    if (arguments == null || arguments.isEmpty) return Utils.getIt<LocalizationClass>().dynamicValue(key);

    String _string = Utils.getIt<LocalizationClass>().dynamicValue(key);

    for (String key in arguments.keys) {
      if (replaceAll)
        _string = _string.replaceAll('{{$key}}', arguments[key]!.toString());
      else
        _string = _string.replaceFirst('{{$key}}', arguments[key]!.toString());
    }

    return _string;
  }

  /// Utils function to retrieve the icon from the IconData dictionary
  static int iconData(String key) {
    int? codePoint = Utils.getIt<IconDataDict>().iconDict[key];
    return codePoint != null ? codePoint : -1;
  }

  /// Utils function to the minute to show as a String
  static String plotMinute(int minute) {
    return minute == 0 ? "${minute.toString()}0" : minute.toString();
  }

  /// Utils functions to download a file
  static Future<String> downloadFile(String url, String fileName, String dir) async {
    HttpClient httpClient = new HttpClient();
    File file;
    String filePath = '';
    String myUrl = '';
    try {
      myUrl = url + '/' + fileName;
      var request = await httpClient.getUrl(Uri.parse(myUrl));
      var response = await request.close();
      if (response.statusCode == 200) {
        var bytes = await consolidateHttpClientResponseBytes(response);
        filePath = '$dir/$fileName';
        file = File(filePath);
        await file.writeAsBytes(bytes);
      } else
        filePath = 'Error code: ' + response.statusCode.toString();
    } catch (ex) {
      filePath = 'Can not fetch url';
    }
    return filePath;
  }

  /// Utils functions to round a double number to two decimal position
  static double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  /// Split a list in chunks
  static List<List<T>> chunksList<T>(List<T> elements, int number) {
    return partition(elements, number).toList();
  }

  /// It generates a random boolean value
  static bool generateRandomBoolean() {
    Random randomNumberGenerator = Random();
    return randomNumberGenerator.nextBool();
  }
}
