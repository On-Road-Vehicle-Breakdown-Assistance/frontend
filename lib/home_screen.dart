import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:math' show cos, sqrt, asin;

import 'package:url_launcher/url_launcher.dart';


class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Completer<GoogleMapController> _controller = Completer();
  var gotPosition = 0;
  List<Marker> _markers = <Marker>[];
  late Position position1 = new Position(
      longitude: 0.0,
      latitude: 0.0,
      timestamp: null,
      accuracy: 0.0,
      altitude: 0.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gotPosition = 0;
    setState(() {
      afunc();
      getShops();
    });

    
  }

  Future<void> afunc() async {
    
      Position position1 = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
        setState(() {
          gotPosition = 1;
        //   _markers.add(Marker(
        // markerId: MarkerId('SomeId'),
        // position: LatLng(position1.latitude, position1.longitude),
        // infoWindow: InfoWindow(title: 'My Current Location')));
        shopsToDisplay(position1.latitude, position1.longitude);
        });
      
    
  }

  @override
  Widget build(BuildContext context) {
    if(gotPosition == 1){
      
    }
    
    CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(12.504849898190843, 75.08339903766213),
      zoom: 18,
    );
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,
          zoomControlsEnabled: true,
          zoomGesturesEnabled: true,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          trafficEnabled: false,
          rotateGesturesEnabled: true,
          buildingsEnabled: true,
          markers: Set<Marker>.of(_markers),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
  
  var latitude = [];
  var longitude = [];
  var nearestShops = [];
  var phoneList = [];
  Future getShops() async {
    final response = await http.get(Uri.parse(
        'https://gear-up-56ec5-default-rtdb.firebaseio.com/workshops.json'));
    var flag = 0, flag1 = 0;
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var a = jsonDecode(response.body);
      latitude.clear();
      longitude.clear();
      nearestShops.clear();
      phoneList.clear();
      a.forEach((k, v) => v.forEach((c, d) => {
            if(c=='w_name'){
              nearestShops.add(d),
            },
            if( c == 'latitude'){
              latitude.add(d),
            },
              
            if(c == 'longitude'){
              longitude.add(d),
            },
            if(c=='phone'){
              phoneList.add(d),
            }
            
          }));
      print(longitude);
      print(latitude);
      return response.body;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 + 
          c(lat1 * p) * c(lat2 * p) * 
          (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }
  
  var shortest_distance = [];
  
  Future<void> shopsToDisplay(a,b) async {
    if(latitude.isNotEmpty && gotPosition==1){
      for(int i=0; i<latitude.length; i++){
        print(await position1.latitude);
        double distance = calculateDistance(double.parse(latitude[i]), double.parse(longitude[i]) , a, b);
         
        if(distance<10.000){
          // print("AAAAAAAAAAAAAAAAA $distance");
          var dist = double.parse((distance).toStringAsFixed(2));
          print(dist);
          setState(() {
             _markers.add(Marker(
        markerId: MarkerId('${nearestShops[i]}'),
        position: LatLng(double.parse(latitude[i]),  double.parse(longitude[i])),
        infoWindow: InfoWindow(title: '${nearestShops[i]} -${dist}km'),
        onTap: (){
          _makingPhoneCall(phoneList[i]);
        }));
        });
        }
        
      }
    }
  }
  Future _makingPhoneCall(phno) async {
    var url = Uri.parse("tel:$phno");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
////////////Upto here

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String currentAddress = 'My Address';
  late Position currentposition = new Position(
      longitude: 0.0,
      latitude: 0.0,
      timestamp: null,
      accuracy: 0.0,
      altitude: 0.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0);

  Future _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Please enable Your Location Service');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg:
              'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0];

      setState(() {
        currentposition = position;
        currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Location'),
      ),
      body: Center(
          child: Column(
        children: [
          Text(currentAddress),
          currentposition != null
              ? Text('Latitude = ' + currentposition.latitude.toString())
              : Container(),
          currentposition != null
              ? Text('Longitude = ' + currentposition.longitude.toString())
              : Container(),
          TextButton(
              onPressed: () {
                _determinePosition();
              },
              child: Text('Locate me'))
        ],
      )),
    );
  }
  


}
      












// List<Marker> list = const [
//   Marker(
//       markerId: MarkerId('SomeId'),
//       position: LatLng(12.504776577919422, 75.08321128304793),
//       infoWindow: InfoWindow(
//           title: 'The title of the marker'
//       )
//   ),
//   Marker(
//       markerId: MarkerId('SomeId'),
//       position: LatLng( 12.504776577919422, 75.08321128304793),
//       infoWindow: InfoWindow(
//           title: 'e-11 islamabd'
//       )
//   ),
// ];
//
// @override
// void initState() {
//   // TODO: implement initState
//   super.initState();
//   _markers.addAll(
//       list);
// }
