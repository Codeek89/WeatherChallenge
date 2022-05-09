import 'package:flutter/material.dart';

class WeatherLogoImage extends StatefulWidget {
  const WeatherLogoImage({Key? key}) : super(key: key);

  @override
  State<WeatherLogoImage> createState() => _WeatherLogoImageState();
}

class _WeatherLogoImageState extends State<WeatherLogoImage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Image.asset(
        "res/images/cloudy.png",
      ),
    );
  }
}
