import 'package:json_annotation/json_annotation.dart';

part 'parkings.g.dart';

@JsonSerializable(nullable: true)
class ParkingList {
  final List<Parking> parkings;

  ParkingList({
    this.parkings,
  });

  factory ParkingList.fromJson(Map<String, dynamic> json) =>
      _$ParkingListFromJson(json);
  Map<String, dynamic> toJson() => _$ParkingListToJson(this);
}

@JsonSerializable(nullable: true)
class Parking {
  final int id;
  final bool isAvailable;
  final String price;
  final String description;
  final List<double> coordinates;
  final List<String> images;
  final List<Timezone> timezones;

  Parking({
    this.id,
    this.isAvailable,
    this.price,
    this.description,
    this.coordinates,
    this.images,
    this.timezones,
  });

  factory Parking.fromJson(Map<String, dynamic> json) =>
      _$ParkingFromJson(json);
  Map<String, dynamic> toJson() => _$ParkingToJson(this);
}

@JsonSerializable(nullable: true)
class Timezone {
  final int day;
  final String from;
  final String to;

  Timezone({
    this.day,
    this.from,
    this.to,
  });

  factory Timezone.fromJson(Map<String, dynamic> json) =>
      _$TimezoneFromJson(json);
  Map<String, dynamic> toJson() => _$TimezoneToJson(this);
}
