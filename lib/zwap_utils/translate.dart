/// IMPORTING THIRD PARTY PACKAGES
import 'package:flutter/material.dart';

/// Localization class to handle the multi language texts
class LocalizationClass {

  LocalizationClass(this.locale);

  /// The local instance to retrieve the local language
  final Locale locale;

  static LocalizationClass of(BuildContext context) {
    return Localizations.of<LocalizationClass>(context, LocalizationClass)!;
  }

  /// Translation mapping
  static Map<String, Map<String, String>> _localizedValues = {};

  /// It retrieves the local text for this key
  String dynamicValue(String key) {
    return _localizedValues[locale.languageCode]![key]!;
  }
}