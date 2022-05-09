import 'package:equatable/equatable.dart';
import 'package:weather_challenge/domain/models/city_model.dart';

class SearchEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class SearchCityEvent extends SearchEvent {
  final String name;

  SearchCityEvent({required this.name});

  @override
  List<Object?> get props => [name];
}

class ResetBloc extends SearchEvent {}
