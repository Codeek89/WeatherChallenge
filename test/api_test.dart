import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:weather_challenge/domain/models/city_model.dart';
import 'package:weather_challenge/repository/weather_api.dart';

void main() {
  test('test current weather', () async {
    WeatherAPI weatherAPI = WeatherAPI();
    final mockHttpClient = MockClient((request) async {
      final response = {
        "name": "Napoli",
        "country": "Italy",
        "coord": {
          "lat": 1,
          "lon": 2,
        },
        "main": {
          "temp": 20,
          "humidity": 50,
        },
        "wind": {
          "speed": 4,
        },
        "weather": {
          "0": {
            "description": "sunny",
          }
        }
      };
      return Response(jsonEncode(response), 200);
    });

    expect(
      await weatherAPI.getCurrentWeatherOfCity(
        mockHttpClient,
        CityModel(name: "Napoli"),
      ),
      WeatherCityModel(
        name: "Napoli",
        lat: 1,
        lon: 2,
        country: "Italy",
        temp: 20,
        humidity: 50,
        windSpeed: 4,
        littleDescription: "sunny",
      ),
    );
  });

  // This is failing due to Geocoding plugin, throwing MissingPluginException
  test('test one call API', () async {
    WidgetsFlutterBinding.ensureInitialized();
    WeatherAPI weatherAPI = WeatherAPI();
    final mockHttpClient = MockClient((request) async {
      final response = {
        "lat": 1,
        "lon": 2,
        "daily": {
          "1": {
            "temp": {
              "day": 20.0,
            },
            "humidity": 50.0,
            "wind_speed": 5,
            "weather": {
              "0": {
                "description": "sunny",
              }
            },
            "dt": "143724810",
          },
          "2": {
            "temp": {
              "day": 20.0,
            },
            "humidity": 50.0,
            "wind_speed": 5,
            "weather": {
              "0": {
                "description": "sunny",
              }
            },
            "dt": "143724810",
          },
          "3": {
            "temp": {
              "day": 20.0,
            },
            "humidity": 50.0,
            "wind_speed": 5,
            "weather": {
              "0": {
                "description": "sunny",
              }
            },
            "dt": "143724810",
          },
          "4": {
            "temp": {
              "day": 20.0,
            },
            "humidity": 50.0,
            "wind_speed": 5,
            "weather": {
              "0": {
                "description": "sunny",
              }
            },
            "dt": "143724810",
          },
          "5": {
            "temp": {
              "day": 20.0,
            },
            "humidity": 50.0,
            "wind_speed": 5,
            "weather": {
              "0": {
                "description": "sunny",
              }
            },
            "dt": "143724810",
          }
        }
      };
      return Response(jsonEncode(response), 200);
    });

    expect(
      await weatherAPI.get5DaysForecastOfCity(
        mockHttpClient,
        CityModel(name: "Napoli"),
      ),
      WeatherCityModel(
        name: "Napoli",
        lat: 1,
        lon: 2,
        country: "Italy",
        temp: 20.0,
        humidity: 50.0,
        windSpeed: 5,
        littleDescription: "sunny",
      ),
    );
  });
}
