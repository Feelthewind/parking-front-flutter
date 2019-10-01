// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorResponse _$ErrorResponseFromJson(Map<String, dynamic> json) {
  return ErrorResponse(
    statusCode: json['statusCode'] as int,
    error: json['error'] as String,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$ErrorResponseToJson(ErrorResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'error': instance.error,
      'message': instance.message,
    };
