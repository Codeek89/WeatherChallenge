import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:weather_challenge/domain/models/city_model.dart';
import 'package:weather_challenge/repository/api_exception.dart';
import 'package:weather_challenge/util/api_key.dart';

/// Base class used originally to mock the API later.
abstract class BaseWeatherAPI {
  Future<WeatherCityModel> getCurrentWeatherOfCity(
      http.Client client, CityModel city);

  Future<List<WeatherCityModel>> get5DaysForecastOfCity(
      http.Client client, CityModel city);

  WeatherCityModel parseCurrentWeather(String response);

  Future<List<WeatherCityModel>> parse5DaysForecast(String response);
}

/// Api class used to fetch data for current weather
/// and forecast for the next 5 days.
/// It owns two methods for fetching data:
/// The first one retrieves current weather for a city
/// provided by latitude and longitude.
/// The second one retrieves data for forecast.
///
/// Both classes parse data into WeatherModelCity class,
/// using dedicated factory constructors.
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
    } catch (e) {
      throw FetchDataException(
        message: 'Error while fetching data for current weather from server.',
      );
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
    } catch (e) {
      throw FetchDataException(
        message: "Error while fetching five days forecast data.",
      );
    }
  }

  @override
  WeatherCityModel parseCurrentWeather(String response) {
    try {
      final castedBody = jsonDecode(response).cast<String, dynamic>();
      final parsed = WeatherCityModel.fromCurrentWeatherJson(castedBody);

      return parsed;
    } catch (e) {
      throw FetchDataException(
          message: "Error while parsing data current weather.");
    }
  }

  @override
  Future<List<WeatherCityModel>> parse5DaysForecast(String response) async {
    try {
      const int days = 5;
      final castedBody = jsonDecode(response).cast<String, dynamic>();
      List<WeatherCityModel> fiveDaysForecast = [];

      // This json doesn't own info on location, so we need to retrieve them from latitude and longitude
      Placemark address = await placemarkFromCoordinates(
        castedBody['lat'].toDouble(),
        castedBody['lon'].toDouble(),
      ).then((value) => value.first);

      for (int i = 1; i <= days; i++) {
        fiveDaysForecast.add(
          WeatherCityModel.fromOneCallJson(castedBody, i, address),
        );
      }

      return fiveDaysForecast;
    } on MissingPluginException {
      throw ApiException(
        "Error while converting data",
        "MissingPluginException: ",
      );
    } catch (e) {
      throw FetchDataException(
        message: "Error while fetching data from server.",
      );
    }
  }
}
