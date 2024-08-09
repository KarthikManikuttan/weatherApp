import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_response_model.dart';
import 'package:weather_app/widgets/build_text_widget.dart';

class ShowWeatherType extends StatefulWidget {
  final WeatherResponseModel? weatherResponseModel;

  const ShowWeatherType({
    super.key,
    this.weatherResponseModel,
  });

  @override
  State<ShowWeatherType> createState() => _ShowWeatherTypeState();
}

class _ShowWeatherTypeState extends State<ShowWeatherType> {
  Widget weatherType() {
    Values model = widget.weatherResponseModel!.timelines!.daily![0].values!;
    if (model.cloudCoverAvg! > 60) {
      return const BuildTextWidget(
        text: 'Cloudy',
        font: "Electrolize",
        fontWeight: FontWeight.bold,
        size: 20,
      );
    }
    return const BuildTextWidget(
      text: 'Sunny',
      font: "Electrolize",
      fontWeight: FontWeight.bold,
      size: 20,
    );
  }

  @override
  Widget build(BuildContext context) {
    return weatherType();
  }
}
