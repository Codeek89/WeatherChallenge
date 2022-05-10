import 'package:flutter/material.dart';

class WeatherLogoImage extends StatelessWidget {
  final double height;
  final double width;

  const WeatherLogoImage({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Image.asset(
        "res/images/cloudy.png",
      ),
    );
  }
}
