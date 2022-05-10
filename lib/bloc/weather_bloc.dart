import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_challenge/bloc/events/weather_events.dart';
import 'package:weather_challenge/bloc/states/weather_states.dart';
import 'package:weather_challenge/domain/domain.dart';
import 'package:weather_challenge/repository/api_exception.dart';

/// BLoC that handles searching operations.
/// Possible states:
/// 1. InitialWeatherState;
/// 2. CityFound, here we have a list of locations to be selected;
/// 3. CityNotFound, we have a list with null elements, so no city found;
/// 4. ErrorState, when something is wrong, we generally use this as a life-saver;
class WeatherBloc extends Bloc<WeatherEvent, WeatherStates> {
  final BaseDomain baseDomain;

  WeatherBloc({
    required this.baseDomain,
  }) : super(InitialWeatherState()) {
    // Event userd to retrieve city info on current weather and forecast
    on<EnterCity>((event, emit) async {
      final domain = baseDomain as Domain;
      try {
        WeatherStates state;
        await domain.getWeatherOfCity(event.model).whenComplete(() async {
          await domain.getForecastOfCity(event.model).whenComplete(() {
            if (domain.currentSearchedCity != null) {
              state = CityFound(
                currentForecastCityModel: domain.currentSearchedCity,
                fiveDaysForecastList: domain.fiveDaysForecastList,
              );
            } else {
              state = CityNotFound();
            }
            emit(state);
          });
        });
      } on NoLocationFoundException {
        emit(CityNotFound());
      } on FetchDataException catch (e) {
        emit(
          ErrorState(
            message: e.toString(),
          ),
        );
      } catch (e) {
        print("WeatherBLoC: ${e.toString()}");
        emit(
          ErrorState(
            message: e.toString(),
          ),
        );
      }
    });
  }
}
