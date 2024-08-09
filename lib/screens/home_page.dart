import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_response_model.dart';
import 'package:weather_app/utils/location_handler.dart';
import 'package:weather_app/widgets/change_bgColor_widget.dart';
import 'package:weather_app/widgets/show_weather_animation.dart';
import 'package:weather_app/widgets/show_weather_type.dart';
import 'package:weather_app/widgets/build_text_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? currentAddress;
  Position? currentPosition;
  bool isLoading = true;
  Dio dio = Dio();
  WeatherResponseModel? weatherResponseModel;

  @override
  void initState() {
    // TODO: implement initState
    getLocation();
    // getWeather();
    super.initState();
  }

  void getLocation() async {
    currentPosition = await LocationHandler.getCurrentPosition();
    currentAddress =
        await LocationHandler.getAddressFromLatLng(currentPosition!);
    getWeather();
  }

  getWeather() async {
    String latitude = currentPosition!.latitude.toString();
    String longitude = currentPosition!.longitude.toString();
    final response = await dio.get(
        "https://api.tomorrow.io/v4/weather/forecast?location=$latitude, $longitude&apikey=WchXPfNe3B3phW9kxDgATzKrWzI5HqOf");

    if (response.statusCode == 200) {
      weatherResponseModel = WeatherResponseModel.fromJson(response.data);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: Container(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff004dbf),
                    Color(0xff4364f7),
                    Color(0xff6fb1fc)
                  ],
                  stops: [0.01, 0.2, 0.5],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Lottie.asset("assets/thunder_load.json"),
              ),
            ),
          )
        : Container(
            decoration: decoration,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 55),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BuildTextWidget(
                                text: currentAddress!,
                                font: "Poppins",
                                size: 25,
                                fontWeight: FontWeight.w700,
                              ),
                              BuildTextWidget(
                                text: 'Today, ${DateFormat('dd/MM/yyyy').format(
                                  DateTime.parse(
                                    weatherResponseModel!
                                        .timelines!.daily![0].time
                                        .toString(),
                                  ),
                                )}',
                                size: 17,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    alignment: const Alignment(-1, 5),
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: ShowWeatherAnimation(
                            weatherResponseModel: weatherResponseModel,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: BuildTextWidget(
                          text:
                              '${weatherResponseModel!.timelines!.daily![0].values!.temperatureAvg!.toInt().toString()}°',
                          font: "Electrolize",
                          fontWeight: FontWeight.bold,
                          size: 150,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 120),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: ShowWeatherType(
                          weatherResponseModel: weatherResponseModel,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 320,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24),
                        topLeft: Radius.circular(24),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: BuildTextWidget(
                                    text: "Weather now",
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.w700,
                                    size: 22,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 25,
                                            backgroundColor: Colors.grey[100],
                                            child: BuildTextWidget(
                                              text: "°C",
                                              color: Colors.grey[700],
                                              fontWeight: FontWeight.w600,
                                              size: 20,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                BuildTextWidget(
                                                  text: "Feel like",
                                                  color: Colors.grey[400],
                                                  size: 15,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                BuildTextWidget(
                                                  text:
                                                      '${weatherResponseModel!.timelines!.daily![0].values!.temperatureAvg!.toString()}°',
                                                  color: Colors.grey[700],
                                                  size: 15,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: CircleAvatar(
                                            radius: 25,
                                            backgroundColor: Colors.grey[100],
                                            child: Icon(
                                              Icons.air_outlined,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            BuildTextWidget(
                                              text: "Wind",
                                              color: Colors.grey[400],
                                              size: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            BuildTextWidget(
                                              text:
                                                  "${weatherResponseModel!.timelines!.daily![0].values!.windSpeedAvg} km/h",
                                              color: Colors.grey[700],
                                              size: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 25,
                                            backgroundColor: Colors.grey[100],
                                            child: Icon(
                                              Icons.water_drop_outlined,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                BuildTextWidget(
                                                  text: "Humidity",
                                                  color: Colors.grey[400],
                                                  size: 15,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                BuildTextWidget(
                                                  text:
                                                      '${weatherResponseModel!.timelines!.daily![0].values!.humidityAvg!.toInt()}%',
                                                  color: Colors.grey[700],
                                                  size: 15,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: CircleAvatar(
                                              radius: 25,
                                              backgroundColor: Colors.grey[100],
                                              child: Icon(
                                                Icons.sunny,
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              BuildTextWidget(
                                                text: "UV index",
                                                color: Colors.grey[400],
                                                size: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              BuildTextWidget(
                                                text:
                                                    '${weatherResponseModel!.timelines!.daily![0].values!.uvIndexAvg}',
                                                color: Colors.grey[700],
                                                size: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Colors.grey[100],
                                        child: ImageIcon(
                                          const AssetImage("assets/rain.png"),
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            BuildTextWidget(
                                              text: "Chance of rain",
                                              color: Colors.grey[400],
                                              size: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            BuildTextWidget(
                                              text:
                                                  '${weatherResponseModel!.timelines!.daily![0].values!.precipitationProbabilityAvg}%',
                                              color: Colors.grey[700],
                                              size: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
