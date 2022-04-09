
import 'package:flutter/material.dart';
import 'package:weather/services/location.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  late double latitude;
  late double longitude;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

void getLocation() async {
  Location location=Location();
  await location.getCurrentLocation();
  latitude = location.latitude;
  longitude= location.longitude;

  getData();
}

void getData() async {
  var url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=844e25a59dcf84f0fb68bd06bf58a3c7');

http.Response response= await http.get(url);

if(response.statusCode == 200){
  String data = response.body;

  var decodeData= jsonDecode(data);
  double temperature = decodeData['main']['temp'];
  int condition = decodeData['weather'][0]['id'];
  String cityName = decodeData['Name'];
  print(temperature);
  print(condition);
  print(cityName);
}
else{
  print(response.statusCode);
}
}

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}