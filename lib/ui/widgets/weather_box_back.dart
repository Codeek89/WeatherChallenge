import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_challenge/domain/models/city_model.dart';
import 'package:weather_challenge/ui/widgets/weather_value_box.dart';
import 'package:weather_challenge/util/dimensions.dart';
import 'package:weather_challenge/util/resources_manager.dart';
import 'package:weather_challenge/util/strings.dart';
import 'package:weather_icons/weather_icons.dart';

/// Back of WeatherBox, it gives additional weather info
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
    return Stack(
      fit: StackFit.expand,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: Dimensions.kSmallPadding,
          ),
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: showName
                  ? [
                      Text(
                        model.name,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      Text(
                        model.time!.day == DateTime.now().day
                            ? WeatherStrings.today
                            : "${model.time!.day} ${DateFormat.MMMM().format(model.time!)}",
                        style: Theme.of(context).textTheme.bodyText2,
                      )
                    ]
                  : [
                      Text(
                        model.time!.day == DateTime.now().day
                            ? WeatherStrings.today
                            : "${model.time!.day} ${DateFormat.MMMM().format(model.time!)}",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(
              Dimensions.kMiniPadding,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ResourceManager.getIconFromDescription(
                  model,
                  size: Dimensions.currentWeatherIcon,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                Text(
                  model.littleDescription,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Dimensions.kMiniPadding,
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                WeatherValueBox(
                  property: const Icon(
                    WeatherIcons.windy,
                    size: Dimensions.weatherIcon,
                    color: Colors.lightBlue,
                  ),
                  value: model.windSpeed.toStringAsFixed(2),
                  unit: WeatherStrings.windUnit,
                ),
                WeatherValueBox(
                  property: const Icon(
                    WeatherIcons.thermometer,
                    size: Dimensions.weatherIcon,
                    color: Colors.red,
                  ),
                  value: model.temp.toStringAsFixed(1),
                  unit: WeatherStrings.tempUnit,
                ),
                WeatherValueBox(
                  property: const Icon(
                    WeatherIcons.humidity,
                    size: Dimensions.weatherIcon,
                    color: Colors.orange,
                  ),
                  value: model.humidity.round().toString(),
                  unit: WeatherStrings.humidityUnit,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
