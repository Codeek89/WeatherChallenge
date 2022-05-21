import 'package:flutter/material.dart';
import 'package:weather_challenge/util/dimensions.dart';

class WeatherValueBox extends StatelessWidget {
  final Icon property;
  final String value;
  final String unit;
  const WeatherValueBox({
    Key? key,
    required this.property,
    required this.value,
    required this.unit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: Dimensions.cardElevation,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.kSmallPadding,
          vertical: Dimensions.kMicroPadding,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            property,
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              unit,
              style: const TextStyle(
                fontSize: 8.0,
                fontWeight: FontWeight.w300,
              ),
            )
          ],
        ),
      ),
    );
  }
}
