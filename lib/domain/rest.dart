import 'package:alica/alice.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:najot_talim/domain/server_error.dart';

import '../presentation/route/route.dart';

enum Method { post, get, put, delete }

const String _baseUrl = 'https://testapp.hrone.uz/api/';

class Rest {

  final Dio _dio =
      Dio(BaseOptions(receiveTimeout: 60000, connectTimeout: 60000))
        ..interceptors.add(LogInterceptor(
            responseBody: true, requestBody: true, requestHeader: true));

  Future<Response?> request(
      {required String path,
      Method? method,
      Map<String, dynamic>? header,
      Map<String, dynamic>? params,
      Object? data}) async {
    method ??= Method.get;
    try {
      final _result = await _dio.fetch(
          Options(method: method.name, headers: header)
              .compose(_dio.options, path, data: data, queryParameters: params)
              .copyWith(baseUrl: _baseUrl));

      Alice(
          result: _result,
          showNotification: true,
          navigatorKey: NavigationService.navigatorKey);
      return _result;
    } on DioError catch (_) {
      ServerError.withError(error: _);
      if (kDebugMode) {
        print("error: ${_.type.name}");
      }
    }
    return null;
  }
}
