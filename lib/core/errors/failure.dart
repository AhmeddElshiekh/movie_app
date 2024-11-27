import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class Failure {
  final String errMessage;
  final IconData errIcon ;

  const Failure({required this.errMessage, this.errIcon = Icons.error});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errMessage, super.errIcon});

  factory ServerFailure.fromDioError(DioException dioExp) {
    switch (dioExp.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure( errMessage: 'Connection timeout with ApiServer,  Please check API url, parameters are invalid or your internet connection!');

      case DioExceptionType.sendTimeout:
        return ServerFailure(errMessage:'Send timeout with ApiServer');

      case DioExceptionType.receiveTimeout:
        return ServerFailure(errMessage:'Receive timeout with ApiServer');

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioExp.response!.statusCode, dioExp.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure(errMessage:'Request to ApiServer was canceled, please check API url or parameters are invalid');
      case DioExceptionType.connectionError:
        return ServerFailure(errMessage:'Connection Error, Please check your internet connection!',errIcon: Icons.signal_wifi_bad);
      case DioExceptionType.unknown:

        return ServerFailure(errMessage:'Unexpected Error, Please try again!');
      default:
        return ServerFailure(errMessage:'Oops There was an Error, Please try again');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(errMessage:response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailure(errMessage:'Your request not found, Please try later!');
    } else if (statusCode == 500) {
      return ServerFailure(errMessage:'Internal Server error, Please try later');
    } else {
      return ServerFailure(errMessage:'Oops There was an Error, Please try again');
    }
  }
}