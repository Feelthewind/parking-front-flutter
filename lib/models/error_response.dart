import 'package:json_annotation/json_annotation.dart';

part 'error_response.g.dart';

// TODO: 서버측에서 에러 json 어떻게 보낼지 픽스 해야한다.
// 현재는 message가 string 형태로 오는 경우도 있고 list of object로 오는 경우도 있어서 json decoding이 불가능하다.

@JsonSerializable(nullable: true)
class ErrorResponse {
  final int statusCode;

  final String error;

  final String message;

  ErrorResponse({this.statusCode, this.error, this.message});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);
}
