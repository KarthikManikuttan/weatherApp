import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_response_model.dart';

class ShowWeatherAnimation extends StatefulWidget {
  final WeatherResponseModel? weatherResponseModel;

  const ShowWeatherAnimation({
    super.key,
    this.weatherResponseModel,
  });

  @override
  State<ShowWeatherAnimation> createState() => _ShowWeatherAnimationState();
}

class _ShowWeatherAnimationState extends State<ShowWeatherAnimation> {
  Widget weatherAnimation() {
    Values model = widget.weatherResponseModel!.timelines!.daily![0].values!;
    if (model.cloudCoverAvg! > 60) {
      return Lottie.asset("assets/cloudy.json");
    }
    return Lottie.asset("assets/sunny.json");
  }

  @override
  Widget build(BuildContext context) {
    return weatherAnimation();
  }
}
