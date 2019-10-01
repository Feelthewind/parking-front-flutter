// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as int,
    name: json['name'] as String,
    isDisabled: json['isDisabled'] as bool,
    isSharing: json['isSharing'] as bool,
    inUse: json['inUse'] as bool,
    imgURL: json['imgURL'] as String,
    accessToken: json['accessToken'] as String,
    orders: (json['orders'] as List)
        ?.map(
            (e) => e == null ? null : Order.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isDisabled': instance.isDisabled,
      'isSharing': instance.isSharing,
      'inUse': instance.inUse,
      'imgURL': instance.imgURL,
      'accessToken': instance.accessToken,
      'orders': instance.orders,
    };
