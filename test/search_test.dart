import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_challenge/bloc/search_bloc.dart';
import 'package:weather_challenge/bloc/states/search_states.dart';
import 'package:weather_challenge/repository/mock_weather_api.dart';

void main() {
  group('SearchBloc test', () {
    final searchBloc = SearchBloc();
    final mockWeatherAPI;
    setUp(() {
      mockWeatherAPI = 
    });

    blocTest<SearchBloc, SearchStates>(
      'emit [SuggestionsFound] state for successful locations found.',
      build: () => 
    );

    tearDown((){
      searchBloc.close();
    });
  });
}
