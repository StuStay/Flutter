import 'package:json_annotation/json_annotation.dart';

part 'response_model.g.dart';

@JsonSerializable()
class ResponseModel {
  dynamic data;
  ResponseError? error;

  ResponseModel({
    this.data,
    this.error,
  });

  factory ResponseModel.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$ResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);
}

@JsonSerializable()
class ResponseError {
  final String code;
  final String message;
  final String? description;

  ResponseError(
      {required this.code, required this.message, required this.description});

  factory ResponseError.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$ResponseErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseErrorToJson(this);
}
