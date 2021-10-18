/// IMPORTING THIRD PARTY PACKAGES
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

/// The different types of APIs calls
enum ApiType{
  POST,
  PUT,
  GET,
  DELETE,
  PATCH,
  OPTIONS
}

/// The base class to call any endpoint
class ApiService{

  /// The base URL to call before using any endpoint
  final String baseUrl;

  /// The final auth key to call authenticated endpoints
  final String headerAuthKey;

  /// The default custom headers
  Map<String, String> defaultHeaders = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Cache-Control': 'no-cache'
  };

  ApiService({
    required this.baseUrl,
    required this.headerAuthKey
  });

  /// It gets the correct apiType name in base of the current ApiType
  String apiType(ApiType apiType){
    switch(apiType){
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
      case ApiType.OPTIONS:
        return "OPTIONS";
    }
  }

  /// Make a get API call
  Future<http.Response> get(String endpoint, String? token, Map<String, String>? queryData){
    developer.log(
        'Calling endpoint ' + endpoint,
        name: "API SERVICE LOG"
    );
    String finalUrl = this.baseUrl + "/" + endpoint;
    if(token != null){
      this.defaultHeaders[this.headerAuthKey] = token;
    }
    if(queryData != null){
      finalUrl += "?";
      queryData.forEach((key, value) {
        finalUrl += "$key=$value&";
      });
      finalUrl = finalUrl.substring(0, finalUrl.length - 1);
    }
    return http.get(Uri.parse(finalUrl), headers: this.defaultHeaders);
  }

  /// Make a put API call
  Future<http.Response> put(String endpoint, Map<String, dynamic> body, String? token){
    developer.log(
        'Calling endpoint ' + endpoint,
        name: "API SERVICE LOG"
    );
    String finalUrl = this.baseUrl + "/" + endpoint;
    if(token != null){
      this.defaultHeaders[this.headerAuthKey] = token;
    }
    return http.put(Uri.parse(finalUrl), headers: this.defaultHeaders, body: body);
  }

  /// Make a delete API call
  Future<http.Response> delete(String endpoint, String? token){
    developer.log(
        'Calling endpoint ' + endpoint,
        name: "API SERVICE LOG"
    );
    String finalUrl = this.baseUrl + "/" + endpoint;
    if(token != null){
      this.defaultHeaders[this.headerAuthKey] = token;
    }
    return http.delete(Uri.parse(finalUrl), headers: this.defaultHeaders);
  }

  /// Make an API post call
  Future<http.Response> post(String endpoint, Map<String, dynamic> body, String? token){
    developer.log(
        'Calling endpoint ' + endpoint,
        name: "API SERVICE LOG"
    );
    String finalUrl = this.baseUrl + "/" + endpoint;
    if(token != null){
      this.defaultHeaders[this.headerAuthKey] = token;
    }
    return http.post(Uri.parse(finalUrl), headers: this.defaultHeaders, body: body);
  }

  /// Make an API post multipart form call
  Future<http.StreamedResponse> multipartRequest(String endpoint, File fileAsset, String? fileName,
      Map<String, dynamic>? body, String? token, {ApiType apiType = ApiType.POST}) async{
    String currentApiType = this.apiType(apiType);
    var request = http.MultipartRequest(currentApiType, Uri.parse(endpoint));
    if(token != null){
      Map<String, String> customHeaders = {this.headerAuthKey: token};
      request.headers.addAll(customHeaders);
    }
    request.files.add(
        http.MultipartFile.fromBytes(
            'picture',
            fileAsset.readAsBytesSync(),
            filename: fileName
        )
    );
    return request.send();
  }

  /// Call this function to simulate an interval seconds to wait before get the fake data from the fake api call
  Future<void> simulateApiCall() async{
    await Future.delayed(Duration(milliseconds: 80));
  }

}