import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                "Date: ${model.time!.day} ${DateFormat.MMMM().format(model.time!)}, ${DateFormat('EEEE').format(
                  model.time!,
                )}",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(
                height: Dimensions.kSmallDistanceBetweenWidgets,
              ),
              Text(
                "Max Temp: ${model.maxTemp} C",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(
                height: Dimensions.kSmallDistanceBetweenWidgets,
              ),
              Text(
                "Min Temp: ${model.minTemp} C",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(
                height: Dimensions.kSmallDistanceBetweenWidgets,
              ),
              Text(
                "Pressure: ${model.pressure}",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(
                height: Dimensions.kSmallDistanceBetweenWidgets,
              ),
              Text(
                "Clouds: ${model.cloudsPercentage}%",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(
                height: Dimensions.kSmallDistanceBetweenWidgets,
              ),
              if (model.rainVolume != null)
                Text(
                  "Rain volume: ${model.rainVolume} mm",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              const SizedBox(
                height: Dimensions.kSmallDistanceBetweenWidgets,
              ),
              if (model.snowVolume != null)
                Text(
                  "Snow volume: ${model.snowVolume} mm",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  child: const Text("View location on Maps"),
                  onPressed: () async {
                    final lat = model.lat!;
                    final lon = model.lon!;
                    MapsLauncher.launchCoordinates(lat, lon);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
