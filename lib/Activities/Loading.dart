import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weatherapp/Model/Weather.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:connectivity/connectivity.dart';

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
    checkConnection().then((isConnected) {
      if (isConnected) {
        LoadData(City);
      } else {}
    });
  }

  Future<bool> checkConnection() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity())
          .timeout(Duration(seconds: 5));
      if (connectivityResult == ConnectivityResult.none) {
        Fluttertoast.showToast(
            msg: "No Internet Connection",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);

        return false;
      }
      return true;
    } on TimeoutException catch (_) {
      Fluttertoast.showToast(
          msg: "Connection Timed Out",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      return false;
    }
  }

  void LoadData(String _city) async {
    WeatherInfo New = await WeatherInfo.empty().getInfo(_city);
    await Future.delayed(Duration(seconds: 3));

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
            ],
          ),
        ),
      ),
    );
  }
}
