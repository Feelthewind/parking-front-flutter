class ParkingList {
  final List<Parking> parkings;

  ParkingList({
    this.parkings,
  });

  factory ParkingList.fromJson(List<dynamic> parsedJson) {
    List<Parking> parkings = new List<Parking>();
    parkings = parsedJson.map((dynamic i) => Parking.fromJson(i)).toList();

    return new ParkingList(
      parkings: parkings,
    );
  }
}

class Parking {
  final int id;
  final bool isAvailable;
  final String price;
  final List<double> coordinates;

  Parking({
    this.id,
    this.isAvailable,
    this.price,
    this.coordinates,
  });

  factory Parking.fromJson(Map<String, dynamic> json) {
    List<double> coordinates = new List<double>.from(json['coordinates']);

    return new Parking(
      id: json['id'],
      isAvailable: json['isAvailable'],
      price: json['price'],
      coordinates: coordinates,
    );
  }
}
