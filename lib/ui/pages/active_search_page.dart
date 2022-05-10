import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => const WeatherPage()),
                                ),
                              );
                            },
                          ),
                        );
                      });
                } else if (state is search_state.SuggestionsNotFound) {
                  return const Padding(
                    padding: EdgeInsets.all(
                      Dimensions.kMiniPadding,
                    ),
                    child: Text(
                      WeatherStrings.noLocationFound,
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
