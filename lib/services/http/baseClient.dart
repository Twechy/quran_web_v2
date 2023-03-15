import 'dart:io';

import 'package:dio/dio.dart';

class BaseClient {
  // chrome.exe --user-data-dir="C:/Chrome dev session" --disable-web-security
  // static const String _base = '192.168.1.7';
  static const String _base = '10.101.120.28';
  final String _baseUrl = 'http://$_base/QuranApi/api/';

  final int _connectTimeout = 15;
  int userId = 0;
  String token = '';

  Dio dio = Dio();

  BaseClient() {
    _createDio();
  }

  Future _createDio() async {
    var dioOptions = BaseOptions(
      baseUrl: _baseUrl,
      // connectTimeout: Duration(microseconds: _connectTimeout),
      headers: Map.from({HttpHeaders.authorizationHeader: 'Bearer $token'}),
    );

    dio = Dio(dioOptions);

    // _addInterceptors(dio);
  }

  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      Function(int, int)? onReceiveProgress}) async {
    var response = await dio.get(
      _baseUrl + path,
      queryParameters: queryParameters,
      options: options,
      onReceiveProgress: onReceiveProgress,
    );
    return response;
  }

  Future<Response> post(String path, dynamic data,
      {Map<String, dynamic>? queryParameters}) async {
    var response =
        await dio.post(path, data: data, queryParameters: queryParameters);
    return response;
  }

}
