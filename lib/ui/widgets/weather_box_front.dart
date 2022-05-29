import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_challenge/domain/models/city_model.dart';
import 'package:weather_challenge/ui/widgets/weather_value_box.dart';
import 'package:weather_challenge/util/dimensions.dart';
import 'package:weather_challenge/util/resources_manager.dart';
import 'package:weather_challenge/util/strings.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Widget used to give an overview of the current weather or forecast.
class WeatherBoxFront extends StatefulWidget {
  final WeatherCityModel model;
  final bool showName;
  const WeatherBoxFront({
    Key? key,
    this.showName = true,
    required this.model,
  }) : super(key: key);

  @override
  State<WeatherBoxFront> createState() => _WeatherBoxFrontState();
}

class _WeatherBoxFrontState extends State<WeatherBoxFront> {
  late Image backgroundImage;

  @override
  void initState() {
    backgroundImage = Image.network(
      ResourceManager.getImageFromDescription(
        widget.model,
      ),
      fit: BoxFit.fill,
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(backgroundImage.image, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Opacity(
          opacity: 0.3,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              Dimensions.kSmallPadding,
            ),
            child: backgroundImage,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: Dimensions.kSmallPadding,
          ),
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: widget.showName
                  ? [
                      Text(
                        widget.model.name,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      Text(
                        widget.model.time!.day == DateTime.now().day
                            ? AppLocalizations.of(context)!.today
                            : "${widget.model.time!.day} ${DateFormat.MMMM().format(widget.model.time!)}",
                        style: Theme.of(context).textTheme.bodyText2,
                      )
                    ]
                  : [
                      Text(
                        widget.model.time!.day == DateTime.now().day
                            ? AppLocalizations.of(context)!.today
                            : "${widget.model.time!.day} ${DateFormat.MMMM().format(widget.model.time!)}",
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
                  widget.model,
                  size: Dimensions.currentWeatherIcon,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                Text(
                  widget.model.littleDescription,
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
                  value: widget.model.windSpeed.toStringAsFixed(2),
                  unit: WeatherStrings.windUnit,
                ),
                WeatherValueBox(
                  property: const Icon(
                    WeatherIcons.thermometer,
                    size: Dimensions.weatherIcon,
                    color: Colors.red,
                  ),
                  value: widget.model.temp.toStringAsFixed(1),
                  unit: WeatherStrings.tempUnit,
                ),
                WeatherValueBox(
                  property: const Icon(
                    WeatherIcons.humidity,
                    size: Dimensions.weatherIcon,
                    color: Colors.orange,
                  ),
                  value: widget.model.humidity.round().toString(),
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
