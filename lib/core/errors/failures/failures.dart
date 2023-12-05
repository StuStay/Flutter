

import 'failure.dart';

enum GeneralFailureType {
  unexpectedError,
  internetConnectionError,
  formatError,
  noSuchMethodError,
  platformError,
  socketException,
  uploadFile,
  handshake,
  InternetConnectionError,
  dowloandFileFail


}

enum StripeFailureType {
  stripeExeption
}

enum PermissionCheckFailureType {
  permissionDenied,
  unknown
}

enum LocationFailureType {
  timeout,
  locationServiceDisabled,
  platformException
}

enum GoogleMapFailureType{
  failOpenMap
}

enum HttpResponseFailureType {
  authenticationRequired,
  authenticationFailed,
  invalidLoginOrPassword,
  invalidToken,
  tokenExpired,
  unauthorizedAccess,
  missingLoginField,
  missingPasswordField,
  missingStartField,
  missingEndField,
  missingFormIdField,
  missingUniqIdField,
  invalidOrMalformedData,
  invalidStartField,
  invalidEndField,
  unknown
}


/// General failure
class GeneralFailure extends Failure {
  GeneralFailure(GeneralFailureType type, String description, {errorCode ,displayMessage ,doAction })
      : super(type, description, errorCode, displayMessage , doAction);
}

class GoogleMapFailure extends Failure {
  GoogleMapFailure(GoogleMapFailureType type, String description, {errorCode ,displayMessage ,doAction })
      : super(type, description, errorCode, displayMessage , doAction);
}

/// permission failure
///
class PermissionCheckFailure extends Failure {
  PermissionCheckFailure(PermissionCheckFailureType type, String description, {errorCode ,displayMessage ,doAction })
      : super(type, description, errorCode, displayMessage , doAction);
}



class HttpResponseFailure extends Failure {
  HttpResponseFailure(HttpResponseFailureType type, description, {errorCode ,displayMessage ,doAction })
      : super(type, description, errorCode, displayMessage , doAction);
}
