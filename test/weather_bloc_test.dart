import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:weather_challenge/bloc/events/weather_events.dart';
import 'package:weather_challenge/bloc/states/weather_states.dart';
import 'package:weather_challenge/bloc/weather_bloc.dart';
import 'package:weather_challenge/domain/domain.dart';
import 'package:weather_challenge/domain/models/city_model.dart';

import 'search_test.mocks.dart';

void main() {
  group('Weather BLoC test', () {
    late WeatherBloc weatherBloc;
    setUp((() => weatherBloc = WeatherBloc(baseDomain: MockDomain())));

    blocTest<WeatherBloc, WeatherStates>(
      'EnterCity event test - Enter a city and we expect a CityNotFound state in return',
      build: (() => weatherBloc),
      act: (bloc) => bloc.add(
        EnterCity(model: CityModel(name: "Napoli")),
      ),
      expect: () => [
        CityNotFound(),
      ],
    );

    tearDown(() {
      weatherBloc.close();
    });
  });
}
