import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_challenge/bloc/states/search_states.dart';
import 'package:weather_challenge/domain/domain.dart';
import 'package:weather_challenge/repository/api_exception.dart';

import 'events/search_events.dart';

class SearchBloc extends Bloc<SearchEvent, SearchStates> {
  final BaseDomain baseDomain;

  SearchBloc({
    required this.baseDomain,
  }) : super(InitialSearchState()) {
    // Event used to retrieve a list of cities when searching
    on<SearchCityEvent>(
      ((event, emit) async {
        try {
          if (baseDomain is Domain) {
            await baseDomain.getSuggestedCities(event.name).whenComplete(
              () {
                if (baseDomain.suggestedCities?.first == null) {
                  emit(SuggestionsNotFound());
                }
                final citySuggestions = SuggestionsFound(
                  allCitiesSuggestions: baseDomain.suggestedCities!,
                );
                emit(citySuggestions);
              },
            );
          }
        } on FetchDataException {
          emit(
            ErrorState(
              message: "No Internet connection",
            ),
          );
        } on NoLocationFoundException {
          emit(SuggestionsNotFound());
        } catch (e) {
          print("SearchBloc: ${e.toString()}");
        }
      }),
    );

    on<ResetBloc>(
      (event, emit) => emit(InitialSearchState()),
    );
  }
}
