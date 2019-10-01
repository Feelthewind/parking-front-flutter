// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    id: json['id'] as int,
    from: json['from'] as String,
    to: json['to'] as String,
    state: json['state'] as String,
    parking: json['parking'] == null
        ? null
        : Parking.fromJson(json['parking'] as Map<String, dynamic>),
    buyer: json['buyer'] == null
        ? null
        : User.fromJson(json['buyer'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'from': instance.from,
      'to': instance.to,
      'state': instance.state,
      'parking': instance.parking,
      'buyer': instance.buyer,
    };
