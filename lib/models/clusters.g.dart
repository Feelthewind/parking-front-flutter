// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clusters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClusterList _$ClusterListFromJson(Map<String, dynamic> json) {
  return ClusterList(
    clusters: (json['clusters'] as List)
        ?.map((e) =>
            e == null ? null : Cluster.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ClusterListToJson(ClusterList instance) =>
    <String, dynamic>{
      'clusters': instance.clusters,
    };

Cluster _$ClusterFromJson(Map<String, dynamic> json) {
  return Cluster(
    count: json['count'] as String,
    center:
        (json['center'] as List)?.map((e) => (e as num)?.toDouble())?.toList(),
  );
}

Map<String, dynamic> _$ClusterToJson(Cluster instance) => <String, dynamic>{
      'count': instance.count,
      'center': instance.center,
    };
