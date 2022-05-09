import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_challenge/bloc/events/search_events.dart';
import 'package:weather_challenge/bloc/events/weather_events.dart';
import 'package:weather_challenge/bloc/search_bloc.dart';
import 'package:weather_challenge/bloc/weather_bloc.dart';

import '../../util/strings.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: const InputDecoration(
        hintText: WeatherStrings.searchBarHint,
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        context.read<SearchBloc>().add(
              ResetBloc(),
            );
      },
      onSubmitted: (value) {
        context.read<SearchBloc>().add(
              SearchCityEvent(name: value),
            );
      },
    );
  }
}
