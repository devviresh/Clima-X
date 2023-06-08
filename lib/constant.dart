import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:weather_icons/weather_icons.dart';


const kFont15 = TextStyle(fontSize: 15.0);


const Map<String, IconData> weatherIcons = {
  '01d': WeatherIcons.day_sunny,
  '02d': WeatherIcons.day_cloudy,
  '03d': WeatherIcons.cloud,
  '04d': WeatherIcons.cloudy,
  '09d': WeatherIcons.day_rain_mix,
  '10d': WeatherIcons.day_rain,
  '11d': WeatherIcons.day_snow_thunderstorm,
  '13d': WeatherIcons.snowflake_cold,
  '50d': WeatherIcons.day_haze,
  '01n': WeatherIcons.night_clear,
  '02n': WeatherIcons.night_alt_cloudy,
  '03n': WeatherIcons.cloud,
  '04n': WeatherIcons.cloudy,
  '09n': WeatherIcons.night_alt_rain_mix,
  '10n': WeatherIcons.night_alt_rain,
  '11n': WeatherIcons.night_alt_snow_thunderstorm,
  '13n': WeatherIcons.snowflake_cold,
  '50n': WeatherIcons.night_fog,
};

const Map<String, WeatherType> weatherBackground = {
  '01d': WeatherType.sunny,//sunny
  '02d': WeatherType.overcast,//overcast
  '03d': WeatherType.cloudy,//cloudy
  '04d': WeatherType.cloudyNight,//cloudyNight
  '09d': WeatherType.lightRainy,//lightRainy
  '10d': WeatherType.middleRainy,//middleRainy
  '11d': WeatherType.thunder,//thunder
  '13d': WeatherType.lightSnow,//lightSnow
  '50d': WeatherType.hazy,//hazy
  '01n': WeatherType.sunnyNight,//sunnyNight
  '02n': WeatherType.cloudyNight,//cloudyNight
  '03n': WeatherType.cloudyNight,//cloudyNight
  '04n': WeatherType.cloudyNight,//cloudyNight
  '09n': WeatherType.middleRainy,//middleRainy
  '10n': WeatherType.heavyRainy,//heavyRainy
  '11n': WeatherType.thunder,//thunder
  '13n': WeatherType.middleSnow,//middleSnow
  '50n': WeatherType.foggy,//foggy
};