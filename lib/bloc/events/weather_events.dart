import 'package:equatable/equatable.dart';
import 'package:weather_challenge/domain/models/city_model.dart';

class WeatherEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class EnterCity extends WeatherEvent {
  final CityModel model;

  EnterCity({required this.model});

  @override
  List<Object?> get props => [model, model.lat, model.lon];
}
