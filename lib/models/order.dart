import 'package:parking_flutter/models/parking.dart';

class OrderEntity {
  final int id;
  final String from;
  final String to;
  final String orderState;
  final Parking parking;

  OrderEntity({
    this.id,
    this.from,
    this.to,
    this.orderState,
    this.parking,
  });

  factory OrderEntity.fromJson(Map<String, dynamic> json) {
    return OrderEntity(
      id: json['id'],
      from: json['from'],
      to: json['to'],
      orderState: json['state'],
      parking: Parking.fromJson(json['parking']),
    );
  }
}
