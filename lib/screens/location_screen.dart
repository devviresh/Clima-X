import 'package:clima_x/constant.dart';
import 'package:clima_x/screens/search_screen.dart';
import 'package:clima_x/services/weather_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_bg.dart';
import 'package:intl/intl.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({this.locationData, this.forecast});

  final dynamic locationData;
  final dynamic forecast;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late String temperature;
  late String cityName;
  late String description;
  late String feelsLike;
  late String humidity;
  late String windSpeed;
  late String visibility;
  String formattedDate = DateFormat('d MMM, EEE').format(DateTime.now());
  late dynamic forecastData;
  late String backgroundIconData;

  @override
  void initState() {
    super.initState();
    updateWeather(widget.locationData);
    updateForecast(widget.forecast);
  }

  void updateWeather(dynamic weatherData) {
    if (weatherData == null) {
      temperature = '--';
      description = 'No data';
      cityName = 'not found';
      feelsLike = '--';
      humidity = '--';
      windSpeed = '--';
      visibility = '--';
      return;
    }
    setState(() {
      temperature = weatherData['main']['temp'].toStringAsFixed(0);
      description = weatherData['weather'][0]['description'];
      cityName = weatherData['name'];
      feelsLike = weatherData['main']['feels_like'].toStringAsFixed(0);
      humidity = weatherData['main']['humidity'].toStringAsFixed(0);
      windSpeed = (weatherData['wind']['speed'] * 3.6).toStringAsFixed(0);
      visibility = (weatherData['visibility'] / 1000).toStringAsFixed(0);
      backgroundIconData = weatherData['weather'][0]['icon'].toString();
    });
  }

  void updateForecast(dynamic forecast) {
    setState(() {
      forecastData = forecast;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WeatherBg(
          weatherType: weatherBackground[backgroundIconData]!,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.black12,
            elevation: 1.0,
            leading: const Icon(Icons.adb),
            title: const Text('ClimaX'),
            actions: [
              IconButton(
                  onPressed: () async {
                    var weatherData = await WeatherModel().getLocationWeather();
                    updateWeather(weatherData);
                    var forecast = await WeatherModel().getLocationForecast();
                    updateForecast(forecast);
                  },
                  icon: const Icon(Icons.home)),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () async {
                  var cityName = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SearchScreen()));
                  var weatherData =
                      await WeatherModel().getCityWeather(cityName);
                  updateWeather(weatherData);
                  var forecast = await WeatherModel().getCityForecast(cityName);
                  updateForecast(forecast);
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(10.0),
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 3),
                Row(
                  children: [
                    Text(temperature, style: const TextStyle(fontSize: 60.0)),
                    const SizedBox(width: 15.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('°C', style: TextStyle(fontSize: 22.0)),
                        Text(description, style: const TextStyle(fontSize: 22.0))
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(formattedDate, style: const TextStyle(fontSize: 16.0)),
                    const SizedBox(width: 15.0),
                    const Icon(Icons.location_on_outlined, size: 20.0),
                    Text(cityName, style: const TextStyle(fontSize: 16.0))
                  ],
                ),
                const SizedBox(height: 10.0),
                Container(
                  padding: const EdgeInsets.only(top: 15.0),
                  height: 100.0,
                  width: double.infinity,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      for (int i = 0; i < forecastData['list'].length; i++)
                        Padding(
                          padding: const EdgeInsets.only(right: 30.0),
                          child: Column(
                            children: [
                              Text(
                                '${forecastData['list'][i]['dt_txt'].substring(11, 16)}',
                                style: const TextStyle(fontSize: 16.0),
                              ),
                              Icon(weatherIcons[forecastData['list'][i]
                                  ['weather'][0]['icon']]),
                              const SizedBox(height: 8.0),
                              Text(
                                '${forecastData['list'][i]['main']['temp'].toStringAsFixed(0)} °c',
                                style: const TextStyle(fontSize: 16.0),
                              )
                            ],
                          ),
                        )
                    ],
                  ),
                ),
                const Divider(thickness: 2.0),
                Container(
                  color: Colors.white10,
                  height: 200.0,
                  child: Column(
                    children: [
                      for (int i = 0; i < forecastData['list'].length; i += 8)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 100.0,
                                child: i == 0
                                    ? const Text('Today', style: kFont15)
                                    : i == 8
                                        ? const Text('Tomorrow', style: kFont15)
                                        : Text(
                                            DateFormat('d MMM, EEE').format(DateTime.parse(forecastData['list'][i]['dt_txt'])),
                                            style: kFont15),
                              ),
                              Expanded(
                                  child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        '${forecastData['list'][i]['weather'][0]['main']}',
                                        style: kFont15),
                                    const SizedBox(width: 10.0),
                                    Icon(weatherIcons[
                                        '${forecastData['list'][i]['weather'][0]['icon'].substring(0, 2)}d']),
                                  ],
                                ),
                              )),
                              Text(
                                  '${forecastData['list'][i]['main']['temp'].toStringAsFixed(0)} °c',
                                  style: kFont15)
                            ],
                          ),
                        )
                    ],
                  ),
                ),
                const Divider(thickness: 2.0),
                const SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 150.0,
                      height: 70.0,
                      child: Column(
                        children: [
                          const Text(
                            'Feels like',
                            style: TextStyle(
                                fontSize: 16.0, color: Colors.white60)
                          ),
                          Text(
                            '$feelsLike °c',
                            style: const TextStyle(fontSize: 20.0)
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 150.0,
                      height: 70.0,
                      child: Column(
                        children: [
                          const Text(
                            'Humidity',
                            style: TextStyle(
                                fontSize: 16.0, color: Colors.white60)
                          ),
                          Text(
                            '$humidity %',
                            style: const TextStyle(fontSize: 20.0)
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 150.0,
                      child: Column(
                        children: [
                          const Text(
                            'Wind Speed',
                            style: TextStyle(
                                fontSize: 16.0, color: Colors.white60)
                          ),
                          Text(
                            '$windSpeed km/h',
                            style: const TextStyle(fontSize: 20.0)
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 150.0,
                      child: Column(
                        children: [
                          const Text('Visibility',
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.white60)),
                          Text('$visibility km',
                              style: const TextStyle(fontSize: 20.0))
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15.0)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
