import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_challenge/domain/models/city_model.dart';
import 'package:weather_challenge/ui/widgets/weather_value_box.dart';
import 'package:weather_challenge/util/dimensions.dart';
import 'package:weather_challenge/util/resources_manager.dart';
import 'package:weather_challenge/util/strings.dart';
import 'package:weather_icons/weather_icons.dart';

/// Back of WeatherBox, it gives additional weather info
/// Date - Max temp - Min temp - Pressure - Cloud? - Rain? - Snow?
class WeatherBoxBack extends StatelessWidget {
  final WeatherCityModel model;
  final bool showName;
  const WeatherBoxBack({
    Key? key,
    this.showName = true,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(
            Dimensions.kMediumPadding,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Date: ${model.time!.day} ${DateFormat.MMMM().format(model.time!)}, ${DateFormat('EEEE').format(
                  model.time!,
                )}",
              ),
              Text(
                "Max Temp: ${model.time!.day} ${DateFormat.MMMM().format(model.time!)}, ${DateFormat('EEEE').format(
                  model.time!,
                )}",
              ),
              Text(
                "Min Temp: ${model.time!.day} ${DateFormat.MMMM().format(model.time!)}, ${DateFormat('EEEE').format(
                  model.time!,
                )}",
              ),
              Text(
                "Pressure: ${model.time!.day} ${DateFormat.MMMM().format(model.time!)}, ${DateFormat('EEEE').format(
                  model.time!,
                )}",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
