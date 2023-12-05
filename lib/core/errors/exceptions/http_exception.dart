/// The exceptions that could happen when using http api
class HttpResponseException implements Exception {
  String statusCode;
  String message;

  HttpResponseException({required this.statusCode,required this.message ,});

  @override
  String toString() {
    return message;
  }
}