import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_challenge/bloc/events/weather_events.dart';
import 'package:weather_challenge/bloc/states/weather_states.dart';
import 'package:weather_challenge/domain/domain.dart';
import 'package:weather_challenge/repository/api_exception.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherStates> {
  Domain domain = Domain();

  WeatherBloc() : super(InitialWeatherState()) {
    // Event used to retrieve a list of cities when searching
    // on<GetListCities>(
    //   ((event, emit) async {
    //     try {
    //       await domain.getSuggestedCities(event.name).whenComplete(
    //         () {
    //           if (domain.suggestedCities == null) {
    //             emit(CityNotFound());
    //           }
    //           final citySuggestions = GetListSuggestions(
    //             allCitiesSuggestions: domain.suggestedCities!,
    //           );
    //           emit(citySuggestions);
    //         },
    //       );
    //     } on FetchDataException {
    //       emit(
    //         NoInternetConnection(
    //           message: "No Internet connection",
    //         ),
    //       );
    //     } on NoLocationFoundException {
    //       emit(CityNotFound());
    //     } catch (e) {
    //       print("WeatherBloc: ${e.toString()}");
    //     }
    //   }),
    // );

    // Event userd to retrieve city info on current weather and forecast
    on<EnterCity>((event, emit) async {
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
      } on FetchDataException {
        emit(
          ErrorState(
            message: "No Internet Connection",
          ),
        );
      } catch (e) {
        print("WeatherBLoC: ${e.toString()}");
      }
    });
  }
}
