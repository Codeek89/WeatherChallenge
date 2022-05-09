import 'package:http/src/client.dart';
import 'package:weather_challenge/domain/models/city_model.dart';
import 'package:weather_challenge/repository/weather_api.dart';

final mockCurrentWeather = WeatherCityModel(
  name: "Città",
  lat: 10.0,
  lon: 10.0,
  country: "Paese",
  temp: 17.0,
  humidity: 40,
  windSpeed: 12,
  littleDescription: "description",
);

final mockForecastList = <WeatherCityModel>[
  WeatherCityModel(
    name: "Città",
    lat: 10.0,
    lon: 10.0,
    country: "Paese",
    temp: 17.0,
    humidity: 40,
    windSpeed: 12,
    littleDescription: "description",
    time: DateTime(2022, 05, 05),
  ),
  WeatherCityModel(
    name: "Città",
    lat: 10.0,
    lon: 10.0,
    country: "Paese",
    temp: 17.0,
    humidity: 40,
    windSpeed: 12,
    littleDescription: "description",
    time: DateTime(2022, 05, 06),
  ),
  WeatherCityModel(
    name: "Città",
    lat: 10.0,
    lon: 10.0,
    country: "Paese",
    temp: 17.0,
    humidity: 40,
    windSpeed: 12,
    littleDescription: "description",
    time: DateTime(2022, 05, 07),
  ),
  WeatherCityModel(
    name: "Città",
    lat: 10.0,
    lon: 10.0,
    country: "Paese",
    temp: 17.0,
    humidity: 40,
    windSpeed: 12,
    littleDescription: "description",
    time: DateTime(2022, 05, 08),
  ),
  WeatherCityModel(
    name: "Città",
    lat: 10.0,
    lon: 10.0,
    country: "Paese",
    temp: 17.0,
    humidity: 40,
    windSpeed: 12,
    littleDescription: "description",
    time: DateTime(2022, 05, 09),
  ),
];

class MockWeatherAPI extends BaseWeatherAPI {
  @override
  Future<List<WeatherCityModel>> get5DaysForecastOfCity(
      Client client, CityModel city) async {
    await Future.delayed(const Duration(seconds: 2), () => mockForecastList);
    return mockForecastList;
  }

  @override
  Future<WeatherCityModel> getCurrentWeatherOfCity(
      Client client, CityModel city) async {
    await Future.delayed(const Duration(seconds: 2), () => mockCurrentWeather);
    return mockCurrentWeather;
  }

  @override
  Future<List<WeatherCityModel>> parse5DaysForecast(String response) async {}

  @override
  WeatherCityModel parseCurrentWeather(String response) {}
}
