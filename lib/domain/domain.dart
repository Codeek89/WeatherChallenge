import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather_challenge/domain/models/city_model.dart';
import 'package:http/http.dart' as http;
import 'package:weather_challenge/repository/api_exception.dart';
import 'package:weather_challenge/repository/mock_weather_api.dart';
import 'package:weather_challenge/repository/weather_api.dart';

// for testing purposes
abstract class BaseDomain {
  List<CityModel>? suggestedCities;
  WeatherCityModel? currentSearchedCity;
  List<WeatherCityModel>? fiveDaysForecastList;
  Future<void> getSuggestedCities(String name);
  Future<void> getWeatherOfCity(CityModel city);
  Future<void> getForecastOfCity(CityModel city);
}

/// Domain class contains all data needed
/// for the logic of the app. It will:
/// 1. Fetch suggestions for cities during search operation;
/// 2. Receive weather data for city tapped by the user;
class Domain extends BaseDomain {
  http.Client client = http.Client();
  final WeatherAPI _weatherAPI = WeatherAPI();

  // handling all app functionalities

  // Load list of cities during search operation
  @override
  Future<void> getSuggestedCities(String name) async {
    try {
      List<Location> locations = await locationFromAddress(name);
      if (locations.isEmpty) throw NoLocationFoundException();
      List<Placemark> addresses = await placemarkFromCoordinates(
          locations.first.latitude, locations.first.longitude);
      suggestedCities = addresses
          .map(
            (loc) => CityModel(
                name: loc.locality!.isEmpty ? loc.name! : loc.locality!,
                country: loc.country ?? '',
                locality: loc.locality ?? '',
                street: loc.street ?? '',
                lat: locations.first.latitude,
                lon: locations.first.longitude),
          )
          .toList();
    } catch (e) {
      print(e.toString());
      throw NoLocationFoundException();
    }
  }

  @override
  Future<void> getWeatherOfCity(CityModel city) async {
    try {
      currentSearchedCity =
          await _weatherAPI.getCurrentWeatherOfCity(client, city);
    } catch (e) {
      print("getWeatherOfCity: ${e.toString()}");
    }
  }

  @override
  Future<void> getForecastOfCity(CityModel city) async {
    try {
      fiveDaysForecastList =
          await _weatherAPI.get5DaysForecastOfCity(client, city);
    } catch (e) {
      print("getForecastOfCity: ${e.toString()}");
    }
  }
}
