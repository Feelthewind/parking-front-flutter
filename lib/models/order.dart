import 'package:json_annotation/json_annotation.dart';
import 'package:parking_flutter/models/parkings.dart';
import 'package:parking_flutter/models/user.dart';

part 'order.g.dart';

@JsonSerializable(nullable: true)
class Order {
  final int id;
  final String from;
  final String to;
  final String state;
  final Parking parking;
  final User buyer;

  Order({
    this.id,
    this.from,
    this.to,
    this.state,
    this.parking,
    this.buyer,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
