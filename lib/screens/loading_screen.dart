import 'package:clima_x/screens/location_screen.dart';

import 'package:clima_x/services/weather_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../apikey.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  void getLocationData() async{
    var weatherData = await WeatherModel().getLocationWeather();
    var forecastData = await WeatherModel().getLocationForecast();
    Navigator.push(context, MaterialPageRoute(builder: (context) => LocationScreen(locationData: weatherData, forecast: forecastData)));
  }

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SpinKitDoubleBounce(
        color: Colors.white,
        size: 50.0,
      )
    );
  }
}
