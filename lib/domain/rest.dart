import 'package:alica/alice.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:najot_talim/domain/server_error.dart';

import '../presentation/route/route.dart';

enum Method { post, get, put, delete }

class Rest {

  final Dio _dio =
      Dio(BaseOptions(receiveTimeout: 60000, connectTimeout: 60000))
        ..interceptors.add(LogInterceptor(
            responseBody: true, requestBody: true, requestHeader: true));

  Future<Response?> request(
      {
        required String baseUrl,
        required String path,
      Method? method,
      Map<String, dynamic>? header,
      Map<String, dynamic>? params,
      Object? data}) async {
    method ??= Method.get;
    try {
      final result = await _dio.fetch(
          Options(method: method.name, headers: header)
              .compose(_dio.options, path, data: data, queryParameters: params)
              .copyWith(baseUrl: baseUrl));

      Alice(
          result: result,
          showNotification: true,
          navigatorKey: NavigationService.navigatorKey);
      return result;
    } on DioError catch (_) {
      ServerError.withError(error: _);
      if (kDebugMode) {
        print("error: ${_.type.name}");
      }
    }
    return null;
  }
}
