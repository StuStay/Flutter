

import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;

import '../errors/error_utils.dart';
import '../errors/exceptions/http_exception.dart';
import '../models/response_model.dart';

@lazySingleton
class HttpService {

  final httpClient = http.Client();

  final String baseUrl = 'https://test.plateforme-service.com/api-rest/';


  HttpService();

  Future<ResponseModel> postRequest(
      {Map<String, dynamic>? dataToSend,
        bool withHeaders = true,
        bool useDeviceToken = false,
        bool useRefreshToken = false,
        required String url}) async {


      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      var response;
      try {
        response = await httpClient.post(Uri.parse(baseUrl + url),
            headers: requestHeaders,
            body: (dataToSend != null) ? json.encode(dataToSend) : null);

        return ErrorUtils.getResponseOrThrowHttpException(response);
      } on HttpResponseException catch (e) {
        throw ErrorUtils.mapHttpExceptionToFailure(e);
      }

  }

  Future<ResponseModel> getRequest(
      {required String url, bool withHeader = false}) async {

      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',

      };

      try {
        var response = await httpClient.get(Uri.parse(baseUrl + url),
            headers: (withHeader) ? requestHeaders : null);
        var responseResult =
        ErrorUtils.getResponseOrThrowHttpException(response);
        return responseResult;
      } on HttpResponseException catch (e) {
        throw ErrorUtils.mapHttpExceptionToFailure(e);
      }

  }
}