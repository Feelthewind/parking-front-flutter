class ClusterList {
  final List<Cluster> clusters;

  ClusterList({this.clusters});

  factory ClusterList.fromJson(List<dynamic> json) {
    List<Cluster> clusters = new List<Cluster>();
    clusters = json.map((dynamic i) => Cluster.fromJson(i)).toList();
    return ClusterList(
      clusters: clusters,
    );
  }
}

class Cluster {
  final String count;
  final List<double> center;

  Cluster({
    this.count,
    this.center,
  });

  factory Cluster.fromJson(Map<String, dynamic> json) {
    List<double> center = new List<double>.from(json['center']);

    return Cluster(
      count: json['count'],
      center: center,
    );
  }
}
