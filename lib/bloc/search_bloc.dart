import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_challenge/bloc/states/search_states.dart';
import 'package:weather_challenge/domain/domain.dart';
import 'package:weather_challenge/repository/api_exception.dart';
import 'package:weather_challenge/util/strings.dart';

import 'events/search_events.dart';

/// BLoC that handles searching operations.
/// Possible states:
/// 1. InitialSearchState;
/// 2. SuggestionsFound, here we have a list of locations to be selected;
/// 3. SuggestionsNotFound, we have a list with null elements, so no city found;
/// 4. ErrorState, when something is wrong, we generally use this as a saver;
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
                } else {
                  final citySuggestions = SuggestionsFound(
                    allCitiesSuggestions: baseDomain.suggestedCities!,
                  );
                  emit(citySuggestions);
                }
              },
            );
          }
        } on FetchDataException {
          emit(
            ErrorState(
              message: WeatherStrings.noConnectionFound,
            ),
          );
        } on NoLocationFoundException {
          emit(SuggestionsNotFound());
        } catch (e) {
          emit(
            ErrorState(
              message: e.toString(),
            ),
          );
        }
      }),
    );

    on<ResetBloc>(
      (event, emit) => emit(InitialSearchState()),
    );
  }

  @override
  void onChange(Change<SearchStates> change) {
    super.onChange(change);
    print(change);
  }
}
