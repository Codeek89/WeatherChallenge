import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_challenge/bloc/events/search_events.dart';
import 'package:weather_challenge/bloc/events/weather_events.dart';
import 'package:weather_challenge/bloc/search_bloc.dart';
import 'package:weather_challenge/bloc/states/search_states.dart'
    as search_state;
import 'package:weather_challenge/bloc/weather_bloc.dart';
import 'package:weather_challenge/domain/models/city_model.dart';
import 'package:weather_challenge/ui/pages/weather_page.dart';
import 'package:weather_challenge/ui/widgets/search_bar.dart';
import 'package:weather_challenge/util/dimensions.dart';
import 'package:weather_challenge/util/keys.dart';
import 'package:weather_challenge/util/strings.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// This page will search locations and give
/// clickable results in order to be then
/// shown in the next page.
///
/// Here you can enter a name of a city
/// and get a list of cities corresponding
/// to the searched one. You have cards with
/// name, country, eventually streets or other
/// info.
class ActiveSearchPage extends StatefulWidget {
  const ActiveSearchPage({Key? key}) : super(key: key);

  @override
  State<ActiveSearchPage> createState() => _ActiveSearchPageState();
}

class _ActiveSearchPageState extends State<ActiveSearchPage> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.kPaddingFromDeviceHorizontal,
          vertical: Dimensions.kPaddingFromDeviceVertical,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Hero(
              tag: WeatherStrings.tagSearch,
              child: Material(
                child: CustomSearchBar(
                  key: const Key(
                    TestingKeys.searchBar,
                  ),
                  controller: textController,
                ),
              ),
            ),
            BlocBuilder<SearchBloc, search_state.SearchStates>(
              builder: ((context, state) {
                if (state is search_state.SuggestionsFound) {
                  final allCities = state.allCitiesSuggestions;
                  return ListView.builder(
                      key: const Key(TestingKeys.listSuggestions),
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(
                        top: Dimensions.kBigPadding,
                      ),
                      itemCount: state.allCitiesSuggestions.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: const Icon(
                              Icons.location_city,
                            ),
                            title: Text(
                              allCities[index]!.name,
                            ),
                            subtitle: Text(
                              "${allCities[index]!.street == '' ? allCities[index]!.locality! : allCities[index]!.street!}, ${allCities[index]!.country}",
                            ),
                            onTap: () {
                              context.read<WeatherBloc>().add(EnterCity(
                                      model: CityModel(
                                    name: allCities[index]!.name,
                                    country: allCities[index]!.country,
                                    lat: allCities[index]!.lat,
                                    lon: allCities[index]!.lon,
                                  )));
                              context.read<SearchBloc>().add(ResetBloc());
                              Navigator.push(
                                context,
                                RouteWrapper(
                                  pageBuilder: ((context, animation,
                                          secondaryAnimation) =>
                                      const WeatherPage()),
                                ),
                              );
                            },
                          ),
                        );
                      });
                } else if (state is search_state.SuggestionsNotFound) {
                  return Padding(
                    padding: const EdgeInsets.all(
                      Dimensions.kMiniPadding,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.noLocationFound,
                    ),
                  );
                } else if (state is search_state.ErrorState) {
                  return Center(
                    child: Text(
                      state.message,
                    ),
                  );
                } else {
                  return const Spacer();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class RouteWrapper extends PageRouteBuilder {
  RouteWrapper({required RoutePageBuilder pageBuilder})
      : super(pageBuilder: pageBuilder);

  @override
  Duration get transitionDuration => const Duration(
        milliseconds: 200,
      );

  @override
  RouteTransitionsBuilder get transitionsBuilder =>
      (context, animation, secAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: const WeatherPage(),
        );
      };
}
