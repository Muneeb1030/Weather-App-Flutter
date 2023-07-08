import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weatherapp/Model/Weather.dart';

import './Home.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String City = "Sahiwal";
  @override
  void initState() {
    super.initState();
    LoadData(City);
  }

  void LoadData(String _city) async {
    WeatherInfo New = await WeatherInfo.empty().getInfo(_city);

    await Future.delayed(Duration(seconds: 5));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Home(weatherInfo: New),
      ),
    );
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
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
              radius: 0.9,
              colors: [Colors.pink.shade400, Colors.purple.shade500]),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 200,
              ),
              Image.asset(
                'images/mlogo.png',
                height: 240,
                width: 240,
              ),
              Text(
                "Weather Application",
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 60,
              ),
              SpinKitSpinningLines(
                color: Colors.white,
                size: 80.0,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Author: Muneeb",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
