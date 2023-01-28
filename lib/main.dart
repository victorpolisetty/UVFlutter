import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'VitaMinutes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double myLat = 0;
  double myLong = 0;
  double myAlt = 0;
  String weightValue = "99";
  String ageValue = "0";
  String genderValue = "NA";
  String skinColorValue = "NA";

  @override
  void initState() {
    // TODO: implement initState
    _determinePosition();
    super.initState();
  }

  // Future<void> initState() {
  //   var location = new Location();
  //   var serviceEnabled = await location.serviceEnabled();
  //   if (!serviceEnabled) {
  //     serviceEnabled = await location.requestService();
  //     if (!serviceEnabled) {
  //       return;
  //     }
  //   }
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4BB96),
      body:Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                    'WELCOME TO',
                    style: TextStyle(fontSize: 20),
                  ),
                RichText(
                  text: new TextSpan(
                    style: new TextStyle(
                      fontSize: 40.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      new TextSpan(
                          text: 'Vita',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF995201))),
                      new TextSpan(
                          text: 'Minutes',
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(110,50,0,0),
                  child: Row(
                    children: [
                      Text("Age: ", style: TextStyle(fontSize: 20),),
                      DropdownButton(
                          menuMaxHeight: 200,
                          value: ageValue,
                          items:
                          List<String>.generate(101, (int index) => '${index}')
                              .map(
                                (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: val == '0' ? Text('Select Age') : Text(val),
                              );
                            },
                          ).toList(),
                          onChanged: (value) {
                            setState(() {
                              ageValue = value.toString();
                            });
                          }),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(95,20,0,0),
                  child: Row(
                    children: [
                      Text("Weight: ", style: TextStyle(fontSize: 20),),
                      DropdownButton(
                          menuMaxHeight: 200,
                          value: weightValue,
                          items:
                          List<String>.generate(250, (int index) => '${index + 99}')
                              .map(
                                (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: val == '99' ? Text('Select Weight') : Text(val),
                              );
                            },
                          ).toList(),
                          onChanged: (value) {
                            setState(() {
                              weightValue = value.toString();
                            });
                          }),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(100,20,0,0),
                  child: Row(
                    children: [
                      Text("Gender: ", style: TextStyle(fontSize: 20),),
                      DropdownButton(
                          menuMaxHeight: 200,
                          value: genderValue,
                          items: [
                            DropdownMenuItem(
                              child: Text("Select Gender"),
                              value: "NA",
                            ),
                            DropdownMenuItem(
                              child: Text("Male"),
                              value: "Male",
                            ),
                            DropdownMenuItem(
                                child: Text("Female"), value: "Female"),
                          ],
                          onChanged: (value) {
                            setState(() {
                              genderValue = value.toString();
                            });
                          }),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(80,20,0,0),
                  child: Row(
                    children: [
                      Text("Skin Color: ", style: TextStyle(fontSize: 20),),
                      DropdownButton(
                          menuMaxHeight: 200,
                          value: skinColorValue,
                          items: [
                            DropdownMenuItem(
                              child: Text("Select Skin Color"),
                              value: "NA",
                            ),
                            DropdownMenuItem(
                              child: Icon(Icons.circle, color: Color(0xFFFFE2CC),),
                              value: "1",
                            ),
                            // DropdownMenuItem(
                            //     child: Text("Female"), value: "2"),
                          ],
                          onChanged: (value) {
                            setState(() {
                              skinColorValue = value.toString();
                            });
                          }),
                    ],
                  ),
                ),
                SizedBox(height: 50,),
                TextButton(
                  onPressed: () {
                    callAPI();
                  },
                  child: Text(
                    'CONTINUE',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),

              ],
            ),
        ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void callAPI() async {
    Map<String, dynamic> data;
    var url = Uri.parse(
        'https://api.openuv.io/api/v1/uv?lat=$myLat&lng=$myLong&alt=$myAlt');
    var apiKey = 'openuv-2lxbtldfix8q8-io';

    var headers = {
      'Content-type': 'application/json',
      'x-access-token': '$apiKey'
    };

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      print(data);
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();
    print(position);
    myLat = position.latitude;
    myLong = position.longitude;
    myAlt = position.altitude;
    return await Geolocator.getCurrentPosition();
  }
}
