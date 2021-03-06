import 'package:geocoding/geocoding.dart';

/// Base class for city data model.
/// It owns basically data related to the location.
class CityModel {
  final String name;
  double? lat;
  double? lon;
  String? country;
  String? street;
  String? locality;

  CityModel({
    required this.name,
    this.country,
    this.street,
    this.locality,
    this.lat,
    this.lon,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      name: json['name'],
      country: json['country'],
      lat: json['lat'].toDouble(),
      lon: json['lon'].toDouble(),
    );
  }
}

/// A city model that owns also data about weather.
class WeatherCityModel extends CityModel {
  final double temp;
  final double humidity;
  final double windSpeed;
  final String littleDescription;
  final double minTemp;
  final double maxTemp;
  final double pressure;
  final double cloudsPercentage;
  final double? rainVolume;
  final double? snowVolume;
  final DateTime? time;

  WeatherCityModel({
    required name,
    required lat,
    required lon,
    required country,
    required this.temp,
    required this.humidity,
    required this.windSpeed,
    required this.littleDescription,
    required this.minTemp,
    required this.maxTemp,
    required this.pressure,
    required this.cloudsPercentage,
    this.rainVolume,
    this.snowVolume,
    this.time,
  }) : super(
            name: name,
            country: country,
            lat: lat.toDouble(),
            lon: lon.toDouble());

  factory WeatherCityModel.fromCurrentWeatherJson(Map<String, dynamic> json) {
    return WeatherCityModel(
      name: json['name'],
      country: json['country'],
      lat: json['coord']['lat'].toDouble(),
      lon: json['coord']['lon'].toDouble(),
      temp: json['main']['temp'].toDouble(),
      humidity: json['main']['humidity'].toDouble(),
      windSpeed: json['wind']['speed'].toDouble(),
      littleDescription: json['weather'][0]['description'] ?? '',
      minTemp: json['main']['temp_min'].toDouble(),
      maxTemp: json['main']['temp_max'].toDouble(),
      pressure: json['main']['pressure'].toDouble(),
      cloudsPercentage: json['clouds']['all'].toDouble(),
      rainVolume: json['rain']?.toDouble(),
      snowVolume: json['snow']?.toDouble(),
      time: DateTime.now(),
    );
  }

  factory WeatherCityModel.fromOneCallJson(
      Map<String, dynamic> json, int index, Placemark address) {
    return WeatherCityModel(
      name: double.tryParse(address.name!) != null
          ? (address.locality!.isEmpty ? address.country : address.locality)
          : address.name,
      country: address.country ?? '',
      lat: json['lat'].toDouble(),
      lon: json['lon'].toDouble(),
      temp: json['daily'][index]['temp']['day'].toDouble() ?? 0.0,
      humidity: json['daily'][index]['humidity'].toDouble() ?? 0.0,
      windSpeed: json['daily'][index]['wind_speed'].toDouble() ?? 0.0,
      littleDescription:
          json['daily'][index]['weather'][0]['description'] ?? '',
      minTemp: json['daily'][index]['temp']['min'].toDouble(),
      maxTemp: json['daily'][index]['temp']['max'].toDouble(),
      pressure: json['daily'][index]['pressure'].toDouble(),
      cloudsPercentage: json['daily'][index]['clouds']?.toDouble(),
      rainVolume: json['daily'][index]['rain']?.toDouble(),
      snowVolume: json['daily'][index]['snow']?.toDouble(),
      time: DateTime.fromMillisecondsSinceEpoch(
          json['daily'][index]['dt'] * 1000),
    );
  }

  @override
  bool operator ==(covariant WeatherCityModel other) {
    return name == other.name &&
        country == other.country &&
        temp == other.temp &&
        humidity == other.humidity &&
        windSpeed == other.windSpeed &&
        lat == other.lat &&
        lon == other.lon;
  }

  @override
  // ignore: unnecessary_overrides
  int get hashCode => super.hashCode;
}
