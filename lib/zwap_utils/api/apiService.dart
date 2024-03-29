/// IMPORTING THIRD PARTY PACKAGES
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

import 'package:http/testing.dart';

/// The different types of APIs calls
enum ApiType { POST, PUT, GET, DELETE, PATCH, HEAD }

enum ApiServiceLogLevel {
  /// `level0`
  ///
  /// Disabled log
  disabled,

  /// Logs only the path of the request (not the base path)
  level1,

  /// Logs the full path of the request (including the base path)
  level2,
}

/// The base class to call any endpoint
class ApiService {
  /// The base URL to call before using any endpoint
  final String baseUrl;

  /// The final auth key to call authenticated endpoints
  final String headerAuthKey;

  http.Client? _mockClient;

  final ApiServiceLogLevel logLevel;

  @visibleForTesting
  http.Client? get mockClient => _mockClient;

  /// The default custom headers
  Map<String, String> defaultHeaders = {'Accept': 'application/json', 'Content-Type': 'application/json', 'Cache-Control': 'no-cache'};

  ApiService({required this.baseUrl, required this.headerAuthKey, this.logLevel = ApiServiceLogLevel.level1}) : this._mockClient = null;

  ApiService.mock({required this.baseUrl, required this.headerAuthKey, required http.Client client, this.logLevel = ApiServiceLogLevel.level1})
      : this._mockClient = client;

  void setMockClient(http.Client? mockClient) {
    _mockClient = mockClient;
  }

  /// It gets the correct apiType name in base of the current ApiType
  String apiType(ApiType apiType) {
    switch (apiType) {
      case ApiType.POST:
        return "POST";
      case ApiType.PUT:
        return "PUT";
      case ApiType.GET:
        return "GET";
      case ApiType.DELETE:
        return "DELETE";
      case ApiType.PATCH:
        return "PATCH";
      case ApiType.HEAD:
        return "HEAD";
    }
  }

  /// Make a get API call
  Future<http.Response> head(String endpoint, String? token, Map<String, String>? queryData, {Map<String, dynamic> extreHeaders = const {}}) {
    _log(endpoint);
    String finalUrl = this.baseUrl + "/" + endpoint;
    Map<String, String> headers = new Map<String, String>.from(this.defaultHeaders);
    if (token != null) {
      headers[this.headerAuthKey] = "Token $token";
    }
    if (queryData != null) {
      finalUrl += "?";
      queryData.forEach((key, value) {
        finalUrl += "$key=$value&";
      });
      finalUrl = finalUrl.substring(0, finalUrl.length - 1);
    }

    if (_mockClient != null) {
      return _mockClient!.head(Uri.parse(finalUrl), headers: {...headers, ...extreHeaders});
    }

    return http.head(Uri.parse(finalUrl), headers: {...headers, ...extreHeaders});
  }

  /// Make a get API call
  Future<http.Response> get(String endpoint, String? token, Map<String, String>? queryData, {Map<String, dynamic> extreHeaders = const {}}) {
    _log(endpoint);
    Map<String, String> headers = new Map<String, String>.from(this.defaultHeaders);
    String finalUrl = this.baseUrl + "/" + endpoint;
    if (token != null) {
      headers[this.headerAuthKey] = "Token $token";
    }
    if (queryData != null) {
      finalUrl += "?";
      queryData.forEach((key, value) {
        finalUrl += "$key=$value&";
      });
      finalUrl = finalUrl.substring(0, finalUrl.length - 1);
    }

    if (_mockClient != null) {
      return _mockClient!.get(Uri.parse(finalUrl), headers: {...headers, ...extreHeaders});
    }

    return http.get(Uri.parse(finalUrl), headers: {...headers, ...extreHeaders});
  }

  /// Make a put API call
  ///
  /// Extre headers are added after normal headers, so overwrite from extraHeaders is possibile
  Future<http.Response> put(String endpoint, Map<String, dynamic> body, String? token, {Map<String, dynamic> extreHeaders = const {}}) {
    _log(endpoint);
    Map<String, String> headers = new Map<String, String>.from(this.defaultHeaders);
    String finalUrl = this.baseUrl + "/" + endpoint;
    if (token != null) {
      headers[this.headerAuthKey] = "Token $token";
    }
    String data = jsonEncode(body);

    if (_mockClient != null) {
      return _mockClient!.put(Uri.parse(finalUrl), headers: {...headers, ...extreHeaders}, body: data);
    }

    return http.put(Uri.parse(finalUrl), headers: {...headers, ...extreHeaders}, body: data);
  }

  /// Make a patch API call
  ///
  /// Extre headers are added after normal headers, so overwrite from extraHeaders is possibile
  Future<http.Response> patch(String endpoint, Map<String, dynamic> body, String? token, {Map<String, dynamic> extreHeaders = const {}}) {
    _log(endpoint);
    Map<String, String> headers = new Map<String, String>.from(this.defaultHeaders);
    String finalUrl = this.baseUrl + "/" + endpoint;
    if (token != null) {
      headers[this.headerAuthKey] = "Token $token";
    }
    String data = jsonEncode(body);

    if (_mockClient != null) {
      return _mockClient!.patch(Uri.parse(finalUrl), headers: {...headers, ...extreHeaders}, body: data);
    }

    return http.patch(Uri.parse(finalUrl), headers: {...headers, ...extreHeaders}, body: data);
  }

  /// Make a delete API call
  ///
  /// Extre headers are added after normal headers, so overwrite from extraHeaders is possibile
  Future<http.Response> delete(String endpoint, String? token, Map<String, dynamic>? deleteData, {Map<String, dynamic> extreHeaders = const {}}) {
    _log(endpoint);
    Map<String, String> headers = new Map<String, String>.from(this.defaultHeaders);
    String finalUrl = this.baseUrl + "/" + endpoint;
    if (token != null) {
      headers[this.headerAuthKey] = "Token $token";
    }
    String data = jsonEncode(deleteData);

    if (_mockClient != null) {
      return _mockClient!.delete(Uri.parse(finalUrl), headers: {...headers, ...extreHeaders}, body: data);
    }

    return http.delete(Uri.parse(finalUrl), headers: {...headers, ...extreHeaders}, body: data);
  }

  /// Make an API post call
  ///
  /// Extre headers are added after normal headers, so overwrite from extraHeaders is possibile
  Future<http.Response> post(String endpoint, Map<String, dynamic> body, String? token, {Map<String, dynamic> extreHeaders = const {}}) {
    _log(endpoint);
    Map<String, String> headers = new Map<String, String>.from(this.defaultHeaders);
    String finalUrl = this.baseUrl + "/" + endpoint;
    if (token != null) {
      headers[this.headerAuthKey] = "Token $token";
    }
    String data = jsonEncode(body);

    if (_mockClient != null) {
      return _mockClient!.post(Uri.parse(finalUrl), headers: {...headers, ...extreHeaders}, body: data);
    }

    return http.post(Uri.parse(finalUrl), headers: {...headers, ...extreHeaders}, body: data);
  }

  /// Make an API post call
  ///
  /// Extre headers are added after normal headers, so overwrite from extraHeaders is possibile
  Future<http.Response> postList(String endpoint, List body, String? token, {Map<String, dynamic> extreHeaders = const {}}) {
    _log(endpoint);
    Map<String, String> headers = new Map<String, String>.from(this.defaultHeaders);
    String finalUrl = this.baseUrl + "/" + endpoint;
    if (token != null) {
      headers[this.headerAuthKey] = "Token $token";
    }
    String data = jsonEncode(body);

    if (_mockClient != null) {
      return _mockClient!.post(Uri.parse(finalUrl), headers: {...headers, ...extreHeaders}, body: data);
    }

    return http.post(Uri.parse(finalUrl), headers: {...headers, ...extreHeaders}, body: data);
  }

  /// Make an API post call
  ///
  /// Extre headers are added after normal headers, so overwrite from extraHeaders is possibile
  Future<http.Response> putList(String endpoint, List body, String? token, {Map<String, dynamic> extreHeaders = const {}}) {
    _log(endpoint);
    Map<String, String> headers = new Map<String, String>.from(this.defaultHeaders);
    String finalUrl = this.baseUrl + "/" + endpoint;
    if (token != null) {
      headers[this.headerAuthKey] = "Token $token";
    }
    String data = jsonEncode(body);

    if (_mockClient != null) {
      return _mockClient!.put(Uri.parse(finalUrl), headers: {...headers, ...extreHeaders}, body: data);
    }

    return http.put(Uri.parse(finalUrl), headers: {...headers, ...extreHeaders}, body: data);
  }

  /// Make an API post multipart form call
  ///
  /// ! Do not support mockClient
  Future<http.StreamedResponse> multipartRequest(
      String endpoint, File fileAsset, String fileFieldName, String? fileName, Map<String, dynamic>? body, String? token,
      {ApiType apiType = ApiType.POST}) async {
    String currentApiType = this.apiType(apiType);
    var request = http.MultipartRequest(currentApiType, Uri.parse(endpoint));
    if (token != null) {
      Map<String, String> customHeaders = {this.headerAuthKey: token};
      request.headers.addAll(customHeaders);
    }
    request.files.add(http.MultipartFile.fromBytes(fileFieldName, fileAsset.readAsBytesSync(), filename: fileName));
    return request.send();
  }

  /// Call this function to simulate an interval seconds to wait before get the fake data from the fake api call
  Future<void> simulateApiCall({Duration? duration}) async {
    await Future.delayed(duration ?? Duration(milliseconds: 80));
  }

  void _log(String endpoint) {
    switch (logLevel) {
      case ApiServiceLogLevel.disabled:
        break;
      case ApiServiceLogLevel.level1:
        developer.log('Calling endpoint $endpoint', name: "API SERVICE LOG");
        break;
      case ApiServiceLogLevel.level2:
        developer.log('Calling endpoint $baseUrl/$endpoint', name: "API SERVICE LOG");
        break;
    }
  }
}
