import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart' hide Headers;

import '../core/component/flash/flash.dart';
import '../core/component/flash/flash_widget.dart';
import '../core/constant/app_colors.dart';

class ServerError implements Exception {
  String _errorMessage = "";
  ServerError.withError({required DioError error}) {
    _handleError(error);
  }

  _handleError(DioError error) async {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        _errorMessage = "Connection timeout";
        flash(_errorMessage, kPrimaryBlack50Color, position: FlashPosition.bottom);
        break;
      case DioErrorType.sendTimeout:
        _errorMessage = "Connection timeout";
        flash(_errorMessage, kPrimaryGrey100Color, position: FlashPosition.bottom);
        break;
      case DioErrorType.receiveTimeout:
        _errorMessage = "Connection timeout";
        flash(_errorMessage, kPrimaryGrey100Color, position: FlashPosition.bottom);
        break;
      case DioErrorType.response:
          // _errorMessage = error.response!.data['message'];
          // _errorCode = error.response!.data['code'].toString();
          flash('Server bilan xatolik yuz berdi', kPrimaryGrey100Color, position: FlashPosition.bottom);
        break;
      case DioErrorType.cancel:
        _errorMessage = "Canceled";
        flash(_errorMessage, kPrimaryGrey100Color, position: FlashPosition.bottom);
        break;
      case DioErrorType.other:
        _errorMessage = "Something wrong";
        final status = await Connectivity().checkConnectivity();
        if(status == ConnectivityResult.none){
          _errorMessage = 'Internet aloqasi uzilgan';
        }
        flash(_errorMessage, kPrimaryGrey100Color, position: FlashPosition.bottom);
        break;
    }
  }
}
