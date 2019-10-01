import 'package:json_annotation/json_annotation.dart';
import 'package:parking_flutter/models/order.dart';

part 'user.g.dart';

@JsonSerializable(nullable: true)
class User {
  final int id;
  final String name;
  final bool isDisabled;
  final bool isSharing;
  final bool inUse;
  final String imgURL;
  final String accessToken;
  final List<Order> orders;

  User({
    this.id,
    this.name,
    this.isDisabled,
    this.isSharing,
    this.inUse,
    this.imgURL,
    this.accessToken,
    this.orders,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
