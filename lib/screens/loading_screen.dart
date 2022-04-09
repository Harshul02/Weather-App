import 'package:flutter/material.dart';
import 'package:weather/services/location.dart';
import 'package:weather/services/networking.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  late double latitude;
  late double longitude;

  String key = '844e25a59dcf84f0fb68bd06bf58a3c7';
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

void getLocationData() async {
  Location location=Location();
  await location.getCurrentLocation();
  latitude = location.latitude;
  longitude= location.longitude;


  NetworkHelper networkhelper = NetworkHelper('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$key&units=metric');

  var weatherData = await networkhelper.getData();
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return LocationScreen(weatherData);
  }));
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}