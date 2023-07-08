import 'package:flutter/material.dart';
import 'package:weatherapp/Model/Weather.dart';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  final WeatherInfo weatherInfo;
  Home({required this.weatherInfo});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _controller = TextEditingController();
  late WeatherInfo _currentWeatherInfo;

  @override
  void initState() {
    super.initState();
    _currentWeatherInfo = widget.weatherInfo;
  }

  void getWeatherInfo(String city) async {
    WeatherInfo newWeatherInfo = await WeatherInfo.empty().getInfo(city);
    setState(() {
      _currentWeatherInfo.airSpeed = newWeatherInfo.airSpeed;
      _currentWeatherInfo.temperature = newWeatherInfo.temperature;
      _currentWeatherInfo.icon = newWeatherInfo.icon;
      _currentWeatherInfo.humidity = newWeatherInfo.humidity;
      _currentWeatherInfo.description = newWeatherInfo.description;
      _currentWeatherInfo.location = newWeatherInfo.location;
      _currentWeatherInfo.main = newWeatherInfo.main;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.blue[300],
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.blue.shade300, Colors.blue.shade800],
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 30,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          if ((_controller.text).replaceAll(" ", "") == "") {
                            print("Nothing Found");
                          } else {
                            getWeatherInfo(_controller.text);
                          }
                        },
                        child: Container(
                          child: Icon(
                            Icons.search,
                            color: Colors.blue.shade700,
                            size: 35,
                          ),
                          margin: EdgeInsets.fromLTRB(3, 0, 10, 0),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          children: [
                            Image.network(
                              widget.weatherInfo.icon == null
                                  ? 'images/mlogo.png'
                                  : "http://openweathermap.org/img/wn/${widget.weatherInfo.icon}@2x.png",
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.weatherInfo.main,
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  widget.weatherInfo.location,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        margin:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        padding: EdgeInsets.all(26),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              WeatherIcons.thermometer,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.weatherInfo.temperature,
                                  style: TextStyle(fontSize: 90),
                                ),
                                Text(
                                  "C",
                                  style: TextStyle(fontSize: 30),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5)),
                        margin: EdgeInsets.fromLTRB(25, 0, 8, 0),
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [Icon(WeatherIcons.day_windy)],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              widget.weatherInfo.airSpeed,
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                            Text("km/hr")
                          ],
                        ),
                        height: 200,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5)),
                        margin: EdgeInsets.fromLTRB(7, 0, 25, 0),
                        padding: EdgeInsets.all(26),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [Icon(WeatherIcons.humidity)],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              widget.weatherInfo.humidity,
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                            Text("Percent")
                          ],
                        ),
                        height: 200,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Author: Muneeb",
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                        Text(
                          "Data Provided by OpenWeather",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )
                      ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
