// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parkings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingList _$ParkingListFromJson(Map<String, dynamic> json) {
  return ParkingList(
    parkings: (json['parkings'] as List)
        ?.map((e) =>
            e == null ? null : Parking.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ParkingListToJson(ParkingList instance) =>
    <String, dynamic>{
      'parkings': instance.parkings,
    };

Parking _$ParkingFromJson(Map<String, dynamic> json) {
  return Parking(
    id: json['id'] as int,
    isAvailable: json['isAvailable'] as bool,
    price: json['price'] as String,
    description: json['description'] as String,
    coordinates: (json['coordinates'] as List)
        ?.map((e) => (e as num)?.toDouble())
        ?.toList(),
    images: (json['images'] as List)?.map((e) => e as String)?.toList(),
    timezones: (json['timezones'] as List)
        ?.map((e) =>
            e == null ? null : Timezone.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ParkingToJson(Parking instance) => <String, dynamic>{
      'id': instance.id,
      'isAvailable': instance.isAvailable,
      'price': instance.price,
      'description': instance.description,
      'coordinates': instance.coordinates,
      'images': instance.images,
      'timezones': instance.timezones,
    };

Timezone _$TimezoneFromJson(Map<String, dynamic> json) {
  return Timezone(
    day: json['day'] as int,
    from: json['from'] as String,
    to: json['to'] as String,
  );
}

Map<String, dynamic> _$TimezoneToJson(Timezone instance) => <String, dynamic>{
      'day': instance.day,
      'from': instance.from,
      'to': instance.to,
    };
