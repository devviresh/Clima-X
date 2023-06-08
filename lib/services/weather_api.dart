import 'package:clima_x/services/location.dart';
import 'package:clima_x/services/networking.dart';

import '../apikey.dart';

class WeatherModel {

  Future<dynamic> getCityForecast(String cityName) async{
    NetworkHelper networkHelper = NetworkHelper('https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$APIKEY&units=metric');
    var forecastData = await networkHelper.getData();
    return forecastData;
  }

  Future<dynamic> getCityWeather(String cityName) async{
    NetworkHelper networkHelper = NetworkHelper('https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$APIKEY&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async{
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper('https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$APIKEY&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationForecast() async{
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper('https://api.openweathermap.org/data/2.5/forecast?lat=${location.latitude}&lon=${location.longitude}&appid=$APIKEY&units=metric');
    var forecastData = await networkHelper.getData();
    return forecastData;
  }
}