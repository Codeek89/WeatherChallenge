import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:weather_challenge/bloc/events/search_events.dart';
import 'package:weather_challenge/bloc/search_bloc.dart';
import 'package:weather_challenge/bloc/states/search_states.dart';
import 'package:weather_challenge/domain/domain.dart';
import 'package:weather_challenge/domain/models/city_model.dart';

import 'search_test.mocks.dart';

final List<CityModel> mockCities = [
  CityModel(name: "Napoli"),
  CityModel(name: "Napoli"),
  CityModel(name: "Napoli"),
  CityModel(name: "Napoli"),
];

@GenerateMocks([],
    customMocks: [MockSpec<Domain>(returnNullOnMissingStub: true)])
void main() {
  group('searchBloc test', () {
    late SearchBloc searchBloc;
    setUp(() {
      searchBloc = SearchBloc(baseDomain: MockDomain());
    });

    blocTest<SearchBloc, SearchStates>(
      'emit [SuggestionsNotFound] state for locations not found (I think domain is not mocked correctly).',
      build: () => searchBloc,
      act: (bloc) => bloc.add(SearchCityEvent(name: "Napoli")),
      expect: () => [
        SuggestionsNotFound(),
      ],
    );

    tearDown(() {
      searchBloc.close();
    });
  });
}
