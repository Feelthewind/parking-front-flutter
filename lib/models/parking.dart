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
  final String description;
  final List<double> coordinates;
  final List<String> images;
  final TimezoneList timezones;

  Parking({
    this.id,
    this.isAvailable,
    this.price,
    this.description,
    this.coordinates,
    this.images,
    this.timezones,
  });

  factory Parking.fromJson(Map<String, dynamic> json) {
    List<double> coordinates = new List<double>.from(json['coordinates']);
    List<String> images = new List<String>.from(json['images']);
    List<dynamic> timezonesJson = new List<dynamic>.from(json['timezones']);

    return new Parking(
      id: json['id'],
      isAvailable: json['isAvailable'],
      price: json['price'],
      description: json['description'],
      coordinates: coordinates,
      images: images,
      timezones: TimezoneList.fromJson(timezonesJson),
    );
  }
}

class TimezoneList {
  final List<Timezone> timezones;

  TimezoneList({
    this.timezones,
  });

  factory TimezoneList.fromJson(List<dynamic> parsedJson) {
    List<Timezone> timezones = new List<Timezone>();

    timezones = parsedJson.map((dynamic i) => Timezone.fromJson(i)).toList();

    return new TimezoneList(
      timezones: timezones,
    );
  }
}

class Timezone {
  final int day;
  final String from;
  final String to;

  Timezone({
    this.day,
    this.from,
    this.to,
  });

  factory Timezone.fromJson(Map<String, dynamic> json) {
    return new Timezone(
      day: json['day'],
      from: json['from'],
      to: json['to'],
    );
  }
}
