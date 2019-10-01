import 'package:json_annotation/json_annotation.dart';

part 'clusters.g.dart';

@JsonSerializable(nullable: true)
class ClusterList {
  final List<Cluster> clusters;

  ClusterList({this.clusters});

  factory ClusterList.fromJson(Map<String, dynamic> json) =>
      _$ClusterListFromJson(json);
  Map<String, dynamic> toJson() => _$ClusterListToJson(this);
}

@JsonSerializable(nullable: true)
class Cluster {
  final String count;
  final List<double> center;

  Cluster({
    this.count,
    this.center,
  });

  factory Cluster.fromJson(Map<String, dynamic> json) =>
      _$ClusterFromJson(json);
  Map<String, dynamic> toJson() => _$ClusterToJson(this);
}
