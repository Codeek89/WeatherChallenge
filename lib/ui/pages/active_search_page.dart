import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_challenge/bloc/events/weather_events.dart';
import 'package:weather_challenge/bloc/search_bloc.dart';
import 'package:weather_challenge/bloc/states/search_states.dart'
    as searchState;
import 'package:weather_challenge/bloc/states/weather_states.dart'
    as weatherState;
import 'package:weather_challenge/bloc/weather_bloc.dart';
import 'package:weather_challenge/domain/models/city_model.dart';
import 'package:weather_challenge/ui/pages/weather_page.dart';
import 'package:weather_challenge/ui/widgets/search_bar.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Hero(
              tag: 'search',
              child: Material(
                child: CustomSearchBar(
                  controller: textController,
                ),
              ),
            ),
            BlocBuilder<SearchBloc, searchState.SearchStates>(
              builder: ((context, state) {
                if (state is searchState.SuggestionsFound) {
                  final allCities = state.allCitiesSuggestions;
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.allCitiesSuggestions.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.location_city),
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
                } else if (state is searchState.SuggestionsNotFound) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "No location found. Try again please...",
                    ),
                  );
                } else if (state is searchState.ErrorState) {
                  return const Center(
                    child: Text(
                      "No internet connection available. Try connecting to the network...",
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