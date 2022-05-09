import 'package:equatable/equatable.dart';
import 'package:weather_challenge/domain/models/city_model.dart';

/// States that may occur:
/// 1. CityFound;
/// 2. CityNotFound;
/// 3. Error while fetching data;
/// 4. Error because of lack of connectivity;

abstract class SearchStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialSearchState extends SearchStates {}

class SuggestionsFound extends SearchStates {
  final List<CityModel?> allCitiesSuggestions;

  SuggestionsFound({
    required this.allCitiesSuggestions,
  });

  @override
  List<Object?> get props => [allCitiesSuggestions];
}

class SuggestionsNotFound extends SearchStates {}

class ErrorState extends SearchStates {
  final String message;

  ErrorState({required this.message});
  List<Object?> get props => [message];
}
