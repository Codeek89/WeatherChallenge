import 'package:equatable/equatable.dart';
import 'package:weather_challenge/domain/models/city_model.dart';

/// States that may occur:
/// 1. CityFound;
/// 2. CityNotFound;
/// 3. Error while fetching data;
/// 4. Error because of lack of connectivity;

class WeatherStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialWeatherState extends WeatherStates {}

class CityFound extends WeatherStates {
  final WeatherCityModel? currentForecastCityModel;
  final List<WeatherCityModel?>? fiveDaysForecastList;

  CityFound({
    this.currentForecastCityModel,
    this.fiveDaysForecastList,
  });

  @override
  List<Object?> get props => [currentForecastCityModel, fiveDaysForecastList];
}

class CityNotFound extends WeatherStates {}

class ErrorState extends WeatherStates {
  final String message;

  ErrorState({required this.message});
}
