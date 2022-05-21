import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weather_challenge/domain/models/city_model.dart';
import 'package:weather_challenge/ui/widgets/weather_box_back.dart';
import 'package:weather_challenge/ui/widgets/weather_box_front.dart';

class WeatherBox extends StatefulWidget {
  final WeatherCityModel cityModel;
  const WeatherBox({
    Key? key,
    required this.cityModel,
  }) : super(key: key);

  @override
  State<WeatherBox> createState() => _WeatherBoxState();
}

class _WeatherBoxState extends State<WeatherBox> {
  bool isFlipped = false;

  Widget _flipAnimationBuilder(Widget widget, Animation<double> animation) {
    final flipAnimation = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: flipAnimation,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(!isFlipped) != widget!.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
            isUnder ? min(flipAnimation.value, pi / 2) : flipAnimation.value;
        return Transform(
          transform: Matrix4.rotationY(value)..setEntry(3, 0, tilt),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(
        () {
          isFlipped = !isFlipped;
        },
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        layoutBuilder: (widget, list) => Stack(
          children: [
            widget!,
            ...list,
          ],
        ),
        transitionBuilder: _flipAnimationBuilder,
        child: !isFlipped
            ? WeatherBoxFront(
                key: const ValueKey(false),
                model: widget.cityModel,
              )
            : WeatherBoxBack(
                key: const ValueKey(true),
                model: widget.cityModel,
              ),
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeInBack.flipped,
      ),
    );
  }
}
