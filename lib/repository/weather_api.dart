import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:weather_challenge/domain/models/city_model.dart';
import 'package:weather_challenge/repository/api_exception.dart';
import 'package:weather_challenge/util/api_key.dart';

abstract class BaseWeatherAPI {
  Future<WeatherCityModel> getCurrentWeatherOfCity(
      http.Client client, CityModel city);

  Future<List<WeatherCityModel>> get5DaysForecastOfCity(
      http.Client client, CityModel city);

  WeatherCityModel parseCurrentWeather(String response);

  Future<List<WeatherCityModel>> parse5DaysForecast(String response);
}

class WeatherAPI extends BaseWeatherAPI {
  final String currentWeatherUrl =
      "https://api.openweathermap.org/data/2.5/weather?";
  final String fiveDaysForecastUrl =
      "https://api.openweathermap.org/data/2.5/onecall?";

  @override
  Future<WeatherCityModel> getCurrentWeatherOfCity(
      http.Client client, CityModel city) async {
    final String customUrl = currentWeatherUrl +
        'lat=${city.lat}&lon=${city.lon}&units=metric&appid=$openWeatherApiKey';
    try {
      final response = await client.get(Uri.parse(customUrl)).timeout(
            const Duration(seconds: 5),
            onTimeout: () => throw const SocketException(
                "Error while connecting to the website"),
          );

      return parseCurrentWeather(response.body);
    } on SocketException {
      throw FetchDataException(message: 'No Internet connection');
    }
  }

  @override
  Future<List<WeatherCityModel>> get5DaysForecastOfCity(
      http.Client client, CityModel city) async {
    final String customUrl = fiveDaysForecastUrl +
        'lat=${city.lat}&lon=${city.lon}&exclude=current,minutely,hourly,alerts&units=metric&appid=$openWeatherApiKey';
    try {
      final response = await client.get(Uri.parse(customUrl)).timeout(
            const Duration(seconds: 5),
            onTimeout: () => throw const SocketException(
                "Error while connecting to the website"),
          );

      return parse5DaysForecast(response.body);
    } on SocketException {
      throw FetchDataException(message: 'No Internet connection');
    }
  }

  @override
  WeatherCityModel parseCurrentWeather(String response) {
    try {
      final castedBody = jsonDecode(response).cast<String, dynamic>();
      final parsed = WeatherCityModel.fromCurrentWeatherJson(castedBody);
      debugPrint(
          "${parsed.name} - ${parsed.temp} C - ${parsed.littleDescription}");
      return parsed;
    } catch (e) {
      print(e.toString());
      throw FetchDataException(
          message: "Error while fetching data from server.");
    }
  }

  @override
  Future<List<WeatherCityModel>> parse5DaysForecast(String response) async {
    try {
      const int days = 5;
      final castedBody = jsonDecode(response).cast<String, dynamic>();
      List<WeatherCityModel> fiveDaysForecast = [];
      Placemark address;
      // This json doesn't own info on location, so we need to retrieve them from latitude and longitude
      address = await placemarkFromCoordinates(
        castedBody['lat'].toDouble(),
        castedBody['lon'].toDouble(),
      ).then((value) => value.first);

      for (int i = 1; i <= days; i++) {
        fiveDaysForecast.add(
          WeatherCityModel.fromOneCallJson(castedBody, i, address),
        );
      }

      return fiveDaysForecast;
    } catch (e) {
      print("parse5days: ${e.toString()}");
      throw FetchDataException(
          message: "Error while fetching data from server.");
    }
  }
}
