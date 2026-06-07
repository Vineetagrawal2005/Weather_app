import 'package:flutter/material.dart';
import 'package:weather_app/Weather_service.dart';
import 'package:weather_app/weather.dart';
import 'package:weather_app/apikey.dart';

class Weatherapp extends StatefulWidget {
  const Weatherapp({super.key});

  @override
  State<Weatherapp> createState() => _WeatherappState();
}

class _WeatherappState extends State<Weatherapp> {
  final _weatherService = WeatherService(apikey: apiKey);
  WeatherData? _weather;
  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchWeather();
  }

  String getweatherAnimation(String? maincondition) {
    if (maincondition == null) return 'assets/sun.png';
    switch (maincondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.png';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/sunandrain.png';
      case 'thunderstorm':
        return 'assets/rain.png';
      case 'clear':
        return 'assets/sun.png';
      default:
        return 'assets/sun.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on),
                    Text(_weather?.cityName ?? "Loading City ...."),
                    Image.asset(getweatherAnimation(_weather?.maincondition)),
                    Row(  mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${_weather?.temp.round()}',style: TextStyle(
                                                  fontSize: 40
                                                ),),
                            Text('°c',style: TextStyle(),),
                          ],
                        ),
                    Text(_weather?.maincondition ?? ""),
                  ],
                )
              : Row(
                children: [
                  Image.asset(getweatherAnimation(_weather?.maincondition)),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on),
                        Text(_weather?.cityName ?? "Loading City ...."),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${_weather?.temp.round()}',style: TextStyle(
                                                  fontSize: 80
                                                ),),
                            Text('°c',style: TextStyle(),),
                          ],
                        ),
                        Text(_weather?.maincondition ?? ""),
                      ],
                    ),
                ],
              );
        },
      ),
    );
  }
}
