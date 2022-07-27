import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class ListShops extends StatefulWidget {
  ListShops({Key? key, required this.passedPlace}) : super(key: key);

  // const ListShops({Key? key}) : super(key: key);
  final String passedPlace;

  @override
  State<ListShops> createState() => _ListShopsState();
}

class _ListShopsState extends State<ListShops> {
  late List placeList = ["loading"];
  late List phoneList = ["loading"];


  @override
  void initState() {
    super.initState();
    print(widget.passedPlace);
    getLoc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10,5,10,10),
                child: ListTile(
                  subtitle: Text(placeList[index]),
                  title: Text(phoneList[index]),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemCount: placeList.length),
    );
  }

  Future getLoc() async {
    final response = await http.get(Uri.parse(
        'https://gear-up-56ec5-default-rtdb.firebaseio.com/workshops.json'));
    var flag = 0, flag1 = 0;
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var a = jsonDecode(response.body);
      placeList.clear();
      phoneList.clear();
      a.forEach((k, v) => v.forEach((c, d) => {
            if (d == widget.passedPlace)
              {
                flag = 1
                // setState(() {
                //   print(c);
                //   placeList.add("$d");
                // })
              },
            if (flag == 1 && c == 'phone')
              {
                print(d),
                flag1 = 1,
                flag = 0,
                setState(() {
                  placeList.add("$d");
                })
              },
              if (flag1 == 1 && c == 'w_name')
              {
                
                print(d),
                flag1 = 0,
                setState(() {
                  phoneList.add("$d");
                }),
                
              }
          }));
          print(phoneList);
      print(placeList);
      return response.body;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
