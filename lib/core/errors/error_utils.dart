import 'dart:convert';
import 'package:flutter/cupertino.dart';


import '../models/response_model.dart';
import 'exceptions/http_exception.dart';
import 'failures/failures.dart';

enum ErrorCode {
  ERR_0000,
  ERR_0001,
  ERR_0002,
  ERR_0003,
  ERR_0004,
  ERR_0005,
  ERR_1000,
  ERR_1001,
  ERR_1004,
  ERR_1005,
  ERR_1006,
  ERR_1007,
  ERR_2000,
  ERR_2003,
  ERR_2004
}

class ErrorUtils {
  /// Takes a http [Response] and returns Json Object or Throws a http Exception
  static dynamic getResponseOrThrowHttpException(dynamic response) {
    debugPrint(
        'getResponseOrThrowHttpException response.body is : ${response.body}');
    var wsResponse = ResponseModel.fromJson(json.decode(response.body));
    debugPrint('response.body is : ${json.decode(response.body)}');
    if (wsResponse.data != null) {
      return wsResponse;
    } else {
      throw HttpResponseException(
        statusCode: wsResponse.error?.code ?? '',
        message: wsResponse.error?.message ?? '',
      );
    }
  }

  /// Converts [HttpResponseException] and returns a [HttpResponseFailure]
  static HttpResponseFailure mapHttpExceptionToFailure(
      HttpResponseException exception) {
    debugPrint('exception is : $exception');
    switch (exception.statusCode) {
      case "ERR_0000":
        return HttpResponseFailure(
          HttpResponseFailureType.authenticationRequired,
          exception.message,
          errorCode: exception.statusCode,
        );
      case "ERR_0001":
        return HttpResponseFailure(
          HttpResponseFailureType.authenticationFailed,
          exception.message,
          errorCode: exception.statusCode,
        );
      case "ERR_0002":
        return HttpResponseFailure(
          HttpResponseFailureType.invalidLoginOrPassword,
          exception.message,
          errorCode: exception.statusCode,
        );
      case "ERR_0003":
        return HttpResponseFailure(
          HttpResponseFailureType.invalidToken,
          exception.message,
          errorCode: exception.statusCode,
        );
      case "ERR_0004":
        return HttpResponseFailure(
          HttpResponseFailureType.tokenExpired,
          exception.message,
          errorCode: exception.statusCode,
        );
      case "ERR_0005":
        return HttpResponseFailure(
          HttpResponseFailureType.unauthorizedAccess,
          exception.message,
          errorCode: exception.statusCode,
        );
      case "ERR_1000":
        return HttpResponseFailure(
          HttpResponseFailureType.missingLoginField,
          exception.message,
          errorCode: exception.statusCode,
        );
      case "ERR_1001":
        return HttpResponseFailure(
          HttpResponseFailureType.missingPasswordField,
          exception.message,
          errorCode: exception.statusCode,
        );
      case "ERR_1004":
        return HttpResponseFailure(
          HttpResponseFailureType.missingStartField,
          exception.message,
          errorCode: exception.statusCode,
        );
      case "ERR_1005":
        return HttpResponseFailure(
          HttpResponseFailureType.missingEndField,
          exception.message,
          errorCode: exception.statusCode,
        );
      case "ERR_1006":
        return HttpResponseFailure(
          HttpResponseFailureType.missingFormIdField,
          exception.message,
          errorCode: exception.statusCode,
        );
      case "ERR_1007":
        return HttpResponseFailure(
          HttpResponseFailureType.missingUniqIdField,
          exception.message,
          errorCode: exception.statusCode,
        );
      case "ERR_2000":
        return HttpResponseFailure(
          HttpResponseFailureType.invalidOrMalformedData,
          exception.message,
          errorCode: exception.statusCode,
        );
      case "ERR_2003":
        return HttpResponseFailure(
          HttpResponseFailureType.invalidStartField,
          exception.message,
          errorCode: exception.statusCode,
        );
      case "ERR_2004":
        return HttpResponseFailure(
          HttpResponseFailureType.invalidEndField,
          exception.message,
          errorCode: exception.statusCode,
        );
      default:
        return HttpResponseFailure(
          HttpResponseFailureType.unknown,
          exception.message,
          errorCode: exception.statusCode,
        );
    }
  }
}
