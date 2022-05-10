import 'package:flutter/material.dart';
import 'package:weather_challenge/domain/models/city_model.dart';
import 'package:weather_icons/weather_icons.dart';

class ResourceManager {
  static const Map<String, String> _images = {
    "sunny":
        "https://images.unsplash.com/photo-1517464852481-002801a489e7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=715&q=80",
    "cloudy":
        "https://images.unsplash.com/photo-1496450681664-3df85efbd29f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
    "lightning":
        "https://images.unsplash.com/photo-1516912481808-3406841bd33c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=744&q=80",
    "rainy":
        "https://images.unsplash.com/photo-1534274988757-a28bf1a57c17?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80",
    "raindrops":
        "https://images.unsplash.com/photo-1523171164821-1122e5b3a1b2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
    "snowy":
        "https://images.unsplash.com/photo-1514632595-4944383f2737?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
    "foggy":
        "https://www.aldautomotive.com.my/Portals/Malaysia/EasyDNNnews/2047/img-foggy-weather-960x.jpg",
  };

  static Icon getIconFromDescription(
    WeatherCityModel model, {
    double size = 24.0,
  }) {
    try {
      final value = model.littleDescription;
      if (value.contains('light rain')) {
        return Icon(
          WeatherIcons.raindrop,
          color: Colors.blueGrey,
          size: size,
        );
      } else if (value.contains('fog')) {
        return Icon(
          WeatherIcons.fog,
          color: Colors.grey,
          size: size,
        );
      } else if (value.contains('snow')) {
        return Icon(
          WeatherIcons.snow,
          color: Colors.white,
          size: size,
        );
      } else if (value.contains('rain')) {
        return Icon(
          WeatherIcons.rain,
          color: Colors.blueAccent,
          size: size,
        );
      } else if (value.contains('clear')) {
        return Icon(
          WeatherIcons.day_sunny,
          color: Colors.orangeAccent,
          size: size,
        );
      } else if (value.contains('cloud')) {
        return Icon(
          WeatherIcons.cloud,
          color: Colors.grey,
          size: size,
        );
      } else if (value.contains('storm')) {
        return Icon(
          WeatherIcons.lightning,
          color: Colors.grey,
          size: size,
        );
      }
      return Icon(
        Icons.question_mark,
        color: Colors.orangeAccent,
        size: size,
      );
    } catch (e) {
      return Icon(
        Icons.question_mark,
        color: Colors.grey,
        size: size,
      );
    }
  }

  static String getImageFromDescription(WeatherCityModel model) {
    try {
      final value = model.littleDescription;
      if (value.contains('light rain')) {
        return _images['raindrops']!;
      } else if (value.contains('snow')) {
        return _images['snowy']!;
      } else if (value.contains('rain')) {
        return _images['rainy']!;
      } else if (value.contains('clear')) {
        return _images['sunny']!;
      } else if (value.contains('cloud')) {
        return _images['cloudy']!;
      } else if (value.contains('storm')) {
        return _images['lightning']!;
      } else if (value.contains('fog')) {
        return _images['foggy']!;
      }
      // Image not found
      return "https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled.png";
    } catch (e) {
      // Image not found
      return "https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled.png";
    }
  }
}
