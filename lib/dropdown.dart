import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/listShops.dart';
// import 'package:firebase_database';

class DropDown extends StatefulWidget {
  const DropDown({Key? key}) : super(key: key);

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String dropdownValue = 'One';
  late List<String> locationList = ['Loading...'];

  @override
  void initState() {
    super.initState();
    getLoc();
  }

  // final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: locationList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            
            color: Colors.blue[colorCodes[index]],
      child: ListTile(
        onTap: () {
          print(index);
          Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ListShops(passedPlace: locationList[index],)),
  );
        },
        leading: Icon(Icons.abc),
        title: Text('${locationList[index]}'),
      ),
      
    );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }

  Future getLoc() async {
    final response = await http.get(Uri.parse(
        'https://gear-up-56ec5-default-rtdb.firebaseio.com/workshops.json'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var a = jsonDecode(response.body);
      locationList.clear();
      a.forEach((k, v) => v.forEach((c, d) => {
            if (c == "location" && !locationList.contains(d))
              {
                setState(() {
                  locationList.add("$d");
                })
              }
          }));
      print(locationList);
      return response.body;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}

// class DropDown extends StatefulWidget {
//   const DropDown({Key? key}) : super(key: key);

//    @override
//    State<DropDown> createState() => _DropDownState();
//  }

//  class DropDownState extends State<DropDown> {
//     final databaseRef = FirebaseDatabase.instance.reference;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(child: FirebaseAnimatedList(query: databaseRef,itemBuilder: (BuildContext context, DataSnapshot snapshot,
//       Animation<double> animation,int index){
//         return Text(data)
//       },)),
//     );
//   }
//  }
