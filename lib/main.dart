import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_app/contact.dart';
import 'package:my_app/dropdown.dart';
import 'package:my_app/forgot.dart';
import 'package:my_app/registeration.dart';
import 'package:http/http.dart' as http;
// import 'package:ui_tut/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

TextEditingController phoneTextEditingController = TextEditingController();
TextEditingController passwordTextEditingController = TextEditingController();

class _LoginPageState extends State<LoginPage> {
  late int mobileNumber = "00000000" as int;
  late String password = "aaaaaaaa";
  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 70),
          child: Text(
            'GearUp',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height / 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildMobileNumberRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        controller: phoneTextEditingController,
        keyboardType: TextInputType.number,
        // onChanged: (value) {
        //   // setState(() {
        //   //   mobileNumber = value as int;
        //   // });
        // },
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.phone,
              color: Colors.blue[500],
            ),
            labelText: 'Mobile Number'),
      ),
    );
  }

  Widget _buildPasswordRow() {
    // login("8281916295", "ashik2001");
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        controller: passwordTextEditingController,
        keyboardType: TextInputType.text,
        obscureText: true,
        onChanged: (value) {
          setState(() {
            password = value;
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.blue[500],
          ),
          labelText: 'Password',
        ),
      ),
    );
  }

  Future<bool> login(loginId, loginPsw) async {
    final response = await http.get(
        Uri.parse('https://gear-up-56ec5-default-rtdb.firebaseio.com/.json'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var data = jsonDecode(response.body);
      if (data["login"][0].containsKey(loginId)) {
        if (loginPsw == data["login"][0][loginId]) {
          return Future.value(true);
        }
        return Future.value(false);
      }
      return Future.value(false);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      return Future.value(false);
    }
  }

  Widget _buildForgetPasswordButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ForgotPassword()),
            );
          },
          padding: EdgeInsets.all(30),
          child: Text("Forgot Password"),
        ),
      ],
    );
  }

   _snackbar(message) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$message'),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width / 10),
          margin: EdgeInsets.only(bottom: 20),
          child: RaisedButton(
            elevation: 5.0,
            color: Colors.blue[500],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            onPressed: () async {
              // print(phoneTextEditingController.text);
              // passwordTextEditingController
              Future<bool> isAvailable = login(phoneTextEditingController.text,
                  passwordTextEditingController.text);
              if (await isAvailable) {
                // print('asdsad');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DropDown()),
                );
              } else {
                // print("nop");
                _snackbar("Wrong Mobile Number or Password");
              }
            },
            child: Text(
              "LOGIN",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: MediaQuery.of(context).size.height / 40,
              ),
            ),
          ),
        )
      ],
    );
  }


  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Please login to continue",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 45,
                      ),
                    ),
                  ],
                ),
                _buildMobileNumberRow(),
                _buildPasswordRow(),
                _buildForgetPasswordButton(),
                _buildLoginButton(),
                // _buildOrRow(),
                // _buildSocialBtnRow(),
              ],
            ),
          ),
        ),
      ],
    );
  }

    Widget _buildSignUpBtn() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupPage()),
                );
              },
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: 'Dont have an account? ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.height / 50,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: 'Signup',
                    style: TextStyle(
                      color: Colors.blue[500],
                      fontSize: MediaQuery.of(context).size.height / 50,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ]),
              ),
            ),
          ),
        ],
      );
    }

Widget _buildContactBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 30),
          child: FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactPage()),
              );
            },
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: 'Contact Developer ',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: MediaQuery.of(context).size.height / 50,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ]),
            ),
          ),
        ),
      ],
    );
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xfff2f3f7),
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue[500],
                  borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(70),
                    bottomRight: const Radius.circular(70),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildLogo(),
                _buildContainer(),
                _buildSignUpBtn(),
                _buildContactBtn(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
